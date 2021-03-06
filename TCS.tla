-------------------------------- MODULE TCS --------------------------------
(*
The specification of the Transaction Certification Service (TCS)
in DISC'2018 "Multi-Shot Distributed Transaction Commit" by Gregory Chockler
and Alexey Gotsman.

We have specified the multi-shot 2PC protocol in Figure 1 of DISC'2018.

TODO: We plan
  - to test SER using the Serializability Theorem
  - to integrate TCS into a real distributed transaction protocol
  - to implement certification functions for other isolation levels
  - to specify the fault-tolerant commit protocol in Figure 5 of DISC'2018.
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

TShard(t) == {KeySharding[k] : k \in (WSet[t] \cup {kv[1] : kv \in RSet[t]})}

ASSUME \* TODO: See Section 2 of DISC'2018
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
(*
To utilize the logical computations, we replace "COMMIT/ABORT" with "TRUE/FALSE".
The initial value of vote[s][i] and dec[s][i] is then "FALSE".

TODO: Should we do this?
  - using CONSTANTS for "PREPARE/PREPARE_ACK/DECISION"
  - using CONSTANTS for "START/PREPARED/DECIDED"
*)
Message == [type : {"PREPARE"}, t : Tid, s : Shard]
    \cup [type : {"PREPARE_ACK"}, s : Shard, n : Int, t : Tid, v : BOOLEAN]
    \cup [type : {"DECISION"}, p : Int, d : BOOLEAN, s : Shard]

Send(m) == msg' = msg \cup m
Delete(m) == msg' = msg \ m
SendAndDelete(sm, dm) == msg' = (msg \cup sm) \ dm
----------------------------------------------------------------------------
TypeOK ==
    /\ next \in [Shard -> Int]
    /\ txn \in [Shard -> [Slot -> Tid \cup {NotTid}]]
    /\ vote \in [Shard -> [Slot -> BOOLEAN]]
    /\ dec \in [Shard -> [Slot -> BOOLEAN]]
    /\ phase \in [Shard -> [Slot -> {"START", "PREPARED", "DECIDED"}]]
    /\ msg \subseteq Message
    /\ submitted \subseteq Tid
----------------------------------------------------------------------------
Init ==
    /\ next = [s \in Shard |-> -1]
    /\ txn = [s \in Shard |-> [i \in Slot |-> NotTid]]
    /\ vote = [s \in Shard |-> [i \in Slot |-> FALSE]]
    /\ dec = [s \in Shard |-> [i \in Slot |-> FALSE]]
    /\ phase = [s \in Shard |-> [i \in Slot |-> "START"]]
    /\ msg = {}
    /\ submitted = {}
----------------------------------------------------------------------------
KeyOnShard(s) == {k \in Key : KeySharding[k] = s}

ComputeVote(t, s, n) ==
    LET cs == {k \in Slot : \* committed slots before position n
                  /\ k < n
                  /\ phase[s][k] = "DECIDED"
                  /\ dec[s][k]}
        ct == {txn[s][k] : k \in cs} \* committed transactions
        fv == \A k \in KeyOnShard(s), v \in Ver:
                  <<k, v>> \in RSet[t] => (\A c \in ct : k \in WSet[c] => CVer[c] <= v)
        ps == {k \in Slot: \* "prepared to commit" slots before position n
                  /\ k < n
                  /\ phase[s][k] = "PREPARED"
                  /\ vote[s][k]}
        pt == {txn[s][k] : k \in ps} \* "prepared to commit" transactions
        gv == \A k \in KeyOnShard(s), v \in Ver:
                  /\ <<k, v>> \in RSet[t] => (\A p \in pt : k \notin WSet[p])
                  /\ k \in WSet[t] => (\A p \in pt : <<k, v>> \notin RSet[p])
     IN fv /\ gv

ComputeDecision(vs) == \A v \in vs: v
----------------------------------------------------------------------------
Certify(t) == \* Certify t \in Tid
    /\ t \in Tid \ submitted
    /\ Send([type : {"PREPARE"}, t : {t}, s : TShard(t)])
    /\ submitted' = submitted \cup {t}
    /\ UNCHANGED sVars

Prepare(t, s) == \* Prepare t \in Tid on s \in Shard when receive "PREPARE(t)" message
    /\ \E m \in msg:
        /\ m = [type |-> "PREPARE", t |-> t, s |-> s]
        /\ next' = [next EXCEPT ![s] = @ + 1]
        /\ txn' = [txn EXCEPT ![s][next'[s]] = t]
        /\ vote' = [vote EXCEPT ![s][next'[s]] = ComputeVote(t, s, next'[s])]
        /\ phase' = [phase EXCEPT ![s][next'[s]] = "PREPARED"]
        /\ SendAndDelete({[type |-> "PREPARE_ACK",
                              s |-> s,
                              n |-> next'[s],
                              t |-> t,
                              v |-> vote'[s][next'[s]]]},
                         {m})
    /\ UNCHANGED <<dec, submitted>>

PrepareAck(t, s) == \* PrepareAck for t \in Tid on shard s \in Shard when receive all "PREPARE_ACK" messages for t
    /\ s = Coord[t]
    /\ LET ms == {m \in msg : m.type = "PREPARE_ACK" /\ m.t = t}
           vs == {m.v : m \in ms}
           ss == {m.s : m \in ms}
        IN /\ ss = TShard(t)
           /\ SendAndDelete({[type |-> "DECISION",
                                 p |-> ChooseUnique(ms, LAMBDA m : m.s = shard).n,
                                 d |-> ComputeDecision(vs),
                                 s |-> shard] : shard \in ss}, 
                            ms)
    /\ UNCHANGED <<sVars, submitted>>

Decision(s) == \* Decide on shard s \in Shard when receive a "DECISION" message
    /\ \E m \in msg:
        /\ m.type = "DECISION"
        /\ m.s = s
        /\ dec' = [dec EXCEPT ![s][m.p] = m.d]
        /\ phase' = [phase EXCEPT ![s][m.p] = "DECIDED"]
        /\ Delete({m})
    /\ UNCHANGED <<next, txn, vote, submitted>>
----------------------------------------------------------------------------
(*
TODO: adding the two non-deterministic actions
*)
----------------------------------------------------------------------------
Next ==
    \/ \E t \in Tid: Certify(t)
    \/ \E t \in Tid, s \in Shard:
        \/ Prepare(t, s)
        \/ PrepareAck(t, s)
    \/ \E s \in Shard:
        \/ Decision(s)

Spec == Init /\ [][Next]_vars
=============================================================================
\* Modification History
\* Last modified Sun Jun 13 20:02:41 CST 2021 by hengxin
\* Created Sat Jun 12 21:01:57 CST 2021 by hengxin