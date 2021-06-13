-------------------------------- MODULE TCS --------------------------------
(*
See DISC'2018: Multi-Shot Distributed Transaction Commit
*)
EXTENDS Naturals, Integers, FiniteSets, Sequences, Functions, TLC,
        FiniteSetsExt
----------------------------------------------------------------------------
CONSTANTS
    Key,      \* the set of keys, ranged over by k \in Key
    Tid,      \* the set of transaction identifiers, ranged over by t \in Tid
    RSet,     \* RSet[t]: the read set of t \in Tid
    WSet,     \* WSet[t]: the write set of t \in Tid
    CVer,     \* CVer[t]: the commit version of t \in Tid
    Shard,    \* the set of shards, ranged over by s \in Shard
    Coord,    \* Coord[t]: the coordinator of t \in Tid
    KeySharding  \* KeySharding[k]: the shard that holds k \in Key

NotTid == CHOOSE t : t \notin Tid

Ver == 0 .. Cardinality(Tid) \* with a distinguished minimum version 0
Slot == 0 .. Cardinality(Tid) - 1

TKey(t) == WSet[t] \cup {kv[1] : kv \in RSet[t]}
TSharding(t) == {KeySharding[k] : k \in TKey(t)}

ASSUME
    /\ RSet \in [Tid -> SUBSET (Key \X Ver)]
\*    /\ \A t \in Tid: RSet[t]  \* TODO: one version per object
    /\ WSet \in [Tid -> SUBSET Key]
\*    /\    \* TODO: "no blind update" assumption
    /\ CVer \in [Tid -> Ver]
\*    /\  \* TODO: higher than any of the versions read
    /\ Coord \in [Tid -> Shard]
    /\ KeySharding \in [Key -> Shard]
----------------------------------------------------------------------------
VARIABLES
    next,  \* next[s] \in Z points to the last filled slot
    txn,   \* txn[s][i] is the transaction (identifier) to certify in the i-th slot
    vote,  \* vote[s][i] is the vote for txn[s][i]
    dec,   \* dec[s][i] is the decision for txn[s][i]
    phase, \* phase[s][i] is the phase for txn[s][i]
    msg,   \* the set of messages in transit
    submitted    \* the set of t \in Tid that have been submitted to TCS

sVars == <<next, txn, vote, dec, phase>>
vars == <<next, txn, vote, dec, phase, msg, submitted>>
----------------------------------------------------------------------------
Message == [type : {"PREPARE"}, t : Tid, s : Shard]
    \cup [type : {"PREPARE_ACK"}, s : Shard, n : Int, t : Tid, v : {"COMMIT", "ABORT"}]
    \cup [type : {"DECISION"}, p : Int, d : {"COMMIT", "ABORT"}, s : Shard]

Send(m) == msg' = msg \cup m
Delete(m) == msg' = msg \ m
SendAndDelete(sm, dm) == msg' = (msg \cup sm) \ dm
----------------------------------------------------------------------------
TypeOK ==
    /\ next \in [Shard -> Int]
    /\ txn \in [Shard -> [Slot -> Tid \cup {NotTid}]]
    /\ vote \in [Shard -> [Slot -> {"COMMIT", "ABORT", "NULL"}]]
    /\ dec \in [Shard -> [Slot -> {"COMMIT", "ABORT", "NULL"}]]
    /\ phase \in [Shard -> [Slot -> {"START", "PREPARED", "DECIDED"}]]
    /\ msg \subseteq Message
    /\ submitted \subseteq Tid
----------------------------------------------------------------------------
Init ==
    /\ next = [s \in Shard |-> -1]
    /\ txn = [s \in Shard |-> [i \in Slot |-> NotTid]]
    /\ vote = [s \in Shard |-> [i \in Slot |-> "NULL"]]
    /\ dec = [s \in Shard |-> [i \in Slot |-> "NULL"]]
    /\ phase = [s \in Shard |-> [i \in Slot |-> "START"]]
    /\ msg = {}
    /\ submitted = {}
----------------------------------------------------------------------------
Vote(t, s, n) == "ABORT" \* TODO
Decision(ms) == "ABORT" \* TODO
----------------------------------------------------------------------------
Certify(t) == \* Certify t \in Tid
    /\ t \in Tid \ submitted
    /\ Send([type : {"PREPARE"}, t : {t}, s : TSharding(t)])
    /\ submitted' = submitted \cup {t}
    /\ UNCHANGED sVars

Prepare(t, s) == \* Prepare t \in Tid on s \in Shard when receive "PREPARE(t)" message
    /\ \E m \in msg:
        /\ m = [type |-> "PREPARE", t |-> t, s |-> s]
        /\ next' = [next EXCEPT ![s] = @ + 1]
        /\ txn' = [txn EXCEPT ![s][next'[s]] = t]
        /\ vote' = [vote EXCEPT ![s][next'[s]] = Vote(t, s, next'[s])] \* TODO
        /\ phase' = [phase EXCEPT ![s][next'[s]] = "PREPARED"]
        /\ SendAndDelete({[type |-> "PREPARE_ACK",
                              s |-> s,
                              n |-> next'[s],
                              t |-> t,
                              v |-> vote'[s][next'[s]]]},
                         {m})
    /\ UNCHANGED <<dec, submitted>>

Pos(t, s) ==
    LET m == ChooseUnique(msg, LAMBDA m : m.type = "PREPARE_ACK" /\ m.t = t /\ m.s = s)
     IN m.n
     
PrepareAck(t, s) ==
    /\ s = Coord[t]
    /\ LET ms == {m \in msg : m.type = "PREPARE_ACK" /\ m.t = t}
       shards == {m.s : m \in ms}
        IN /\ shards = TSharding(t)
           /\ SendAndDelete({[type |-> "DECISION",
                                 p |-> Pos(t, shard),
                                 d |-> Decision(ms),
                                 s |-> shard] : shard \in shards}, 
                         ms)
    /\ UNCHANGED <<sVars, submitted>>
----------------------------------------------------------------------------
Next ==
    \/ \E t \in Tid: Certify(t)
    \/ \E t \in Tid, s \in Shard:
        \/ Prepare(t, s)
        \/ PrepareAck(t, s)

Spec == Init /\ [][Next]_vars
=============================================================================
\* Modification History
\* Last modified Sun Jun 13 12:25:10 CST 2021 by hengxin
\* Created Sat Jun 12 21:01:57 CST 2021 by hengxin