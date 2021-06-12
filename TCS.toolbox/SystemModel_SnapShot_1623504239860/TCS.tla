-------------------------------- MODULE TCS --------------------------------
(*
See DISC'2018: Multi-Shot Distributed Transaction Commit
*)
EXTENDS Naturals, FiniteSets, TLC
----------------------------------------------------------------------------
CONSTANTS
  Key,      \* the set of keys, ranged over by k \in Key
  Val,      \* the set of values, ranged over by v \in Val
  Trans,    \* the set of transactions, ranged over by t \in Trans
  Shard,    \* the set of shards, ranged over by s \in Shard
  Client,   \* the set of clients, ranged over by c \in Client
  TxCoord,  \* TxCoord(t) is the coordinator of t \in Trans
  KeySharding  \* KeySharding(k) is the shard that holds k \in Key

ASSUME
  /\ TxCoord \in [Trans -> Shard]
  /\ KeySharding \in [Key -> Shard]
\*  /\ \A t \in Trans: 
=============================================================================
\* Modification History
\* Last modified Sat Jun 12 21:22:52 CST 2021 by hengxin
\* Created Sat Jun 12 21:01:57 CST 2021 by hengxin
