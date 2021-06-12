-------------------------------- MODULE TCS --------------------------------
(*
See DISC'2018: Multi-Shot Distributed Transaction Commit
*)
EXTENDS Naturals, Integers, FiniteSets, TLC
----------------------------------------------------------------------------
CONSTANTS
    Key,      \* the set of keys, ranged over by k \in Key
    Val,      \* the set of values, ranged over by v \in Val
    Trans,    \* the set of transactions, ranged over by t \in Trans
    Shard,    \* the set of shards, ranged over by s \in Shard
    Client,   \* the set of clients, ranged over by c \in Client
    TxCoord,  \* TxCoord(t) is the coordinator of t \in Trans
    KeySharding  \* KeySharding(k) is the shard that holds k \in Key

Slot == 1 .. Cardinality(Trans)

NotVal == CHOOSE v : v \notin Val
NotTrans == CHOOSE t : t \notin Trans

ASSUME
    /\ TxCoord \in [Trans -> Shard]
    /\ KeySharding \in [Key -> Shard]
\*  /\ \A t \in Trans: 
----------------------------------------------------------------------------
VARIABLES
    next,  \* next[s] \in Z points to the last filled slot
    txn,   \* txn[s][i] is the transaction to certify in the i-th slot
    vote  \* vote[s][i] is the vote for txn[s][i]

vars == <<next, txn, vote>>
----------------------------------------------------------------------------
TypeOK ==
    /\ next \in [Shard -> Int]
    /\ txn \in [Shard -> [Slot -> Trans \cup {NotTrans}]]
    /\ vote \in [Shard -> [Slot -> {"COMMIT", "ABORT", "UNVOTED"}]]
----------------------------------------------------------------------------
Init ==
    /\ next = [s \in Shard |-> -1]
    /\ txn = [s \in Shard |-> [i \in Slot |-> NotTrans]]
    /\ vote = [s \in Shard |-> [i \in Slot |-> "UNVOTED"]]

----------------------------------------------------------------------------
Next == FALSE

Spec == Init /\ [][Next]_vars
=============================================================================
\* Modification History
\* Last modified Sat Jun 12 21:41:13 CST 2021 by hengxin
\* Created Sat Jun 12 21:01:57 CST 2021 by hengxin
