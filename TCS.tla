-------------------------------- MODULE TCS --------------------------------
(*
See DISC'2018: Multi-Shot Distributed Transaction Commit
*)
EXTENDS Naturals, Integers, FiniteSets, Sequences, Functions, TLC
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
Op == [type : {"read", "write"}, key : Key, val : Val]
R(k, v) == [type |-> "read", key |-> k, val |-> v]
W(k, v) == [type |-> "write", key |-> k, val |-> v]

ASSUME
    /\ Trans \in Seq(Op)  \* A transaction is a sequence of operations.

RS(t) == {op.key : op \in Range(t)}
----------------------------------------------------------------------------
VARIABLES
    next,  \* next[s] \in Z points to the last filled slot
    txn,   \* txn[s][i] is the transaction to certify in the i-th slot
    vote,  \* vote[s][i] is the vote for txn[s][i]
    dec,   \* dec[s][i] is the decision for txn[s][i]
    phase  \* phase[s][i] is the phase for txn[s][i]

vars == <<next, txn, vote, dec, phase>>
----------------------------------------------------------------------------
TypeOK ==
    /\ next \in [Shard -> Int]
    /\ txn \in [Shard -> [Slot -> Trans \cup {NotTrans}]]
    /\ vote \in [Shard -> [Slot -> {"COMMIT", "ABORT", "NULL"}]]
    /\ dec \in [Shard -> [Slot -> {"COMMIT", "ABORT", "NULL"}]]
    /\ phase \in [Shard -> [Slot -> {"START", "PREPARED", "DECIDED"}]]
----------------------------------------------------------------------------
Init ==
    /\ next = [s \in Shard |-> -1]
    /\ txn = [s \in Shard |-> [i \in Slot |-> NotTrans]]
    /\ vote = [s \in Shard |-> [i \in Slot |-> "NULL"]]
    /\ dec = [s \in Shard |-> [i \in Slot |-> "NULL"]]
    /\ phase = [s \in Shard |-> [i \in Slot |-> "START"]]
----------------------------------------------------------------------------
Certify(t, s) == \* Cerify transaction t \in Trans on shard s \in Shard
    /\ FALSE
----------------------------------------------------------------------------
Next == TRUE

Spec == Init /\ [][Next]_vars
=============================================================================
\* Modification History
\* Last modified Sat Jun 12 22:14:42 CST 2021 by hengxin
\* Created Sat Jun 12 21:01:57 CST 2021 by hengxin
