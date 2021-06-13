-------------------------------- MODULE TCS --------------------------------
(*
See DISC'2018: Multi-Shot Distributed Transaction Commit
*)
EXTENDS Naturals, Integers, FiniteSets, Sequences, Functions, TLC
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

Ver == 0 .. Cardinality(Tid)    \* with a distinguished minimum version 0
Slot == 1 .. Cardinality(Tid)

TKey(t) == WSet[t] \cup {kv[1] : kv \in RSet[t]}
TSharding == [t \in Tid |-> {KeySharding[k] : k \in TKey(t)}]

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
    phase  \* phase[s][i] is the phase for txn[s][i]

vars == <<next, txn, vote, dec, phase>>
----------------------------------------------------------------------------
TypeOK ==
    /\ next \in [Shard -> Int]
    /\ txn \in [Shard -> [Slot -> Tid \cup {NotTid}]]
    /\ vote \in [Shard -> [Slot -> {"COMMIT", "ABORT", "NULL"}]]
    /\ dec \in [Shard -> [Slot -> {"COMMIT", "ABORT", "NULL"}]]
    /\ phase \in [Shard -> [Slot -> {"START", "PREPARED", "DECIDED"}]]
----------------------------------------------------------------------------
Init ==
    /\ next = [s \in Shard |-> -1]
    /\ txn = [s \in Shard |-> [i \in Slot |-> NotTid]]
    /\ vote = [s \in Shard |-> [i \in Slot |-> "NULL"]]
    /\ dec = [s \in Shard |-> [i \in Slot |-> "NULL"]]
    /\ phase = [s \in Shard |-> [i \in Slot |-> "START"]]
----------------------------------------------------------------------------
Certify(t, s) == \* Cerify t \in Tid on shard s \in Shard
    /\ FALSE
----------------------------------------------------------------------------
Next == TRUE

Spec == Init /\ [][Next]_vars
=============================================================================
\* Modification History
\* Last modified Sun Jun 13 10:22:37 CST 2021 by hengxin
\* Created Sat Jun 12 21:01:57 CST 2021 by hengxin
