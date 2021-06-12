---- MODULE MC ----
EXTENDS TCS, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
v1, v2
----

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
t1, t2
----

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
k1, k2
----

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
c1, c2
----

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
s1, s2
----

\* MV CONSTANT definitions Val
const_1623506009046151000 == 
{v1, v2}
----

\* MV CONSTANT definitions Trans
const_1623506009046152000 == 
{t1, t2}
----

\* MV CONSTANT definitions Key
const_1623506009046153000 == 
{k1, k2}
----

\* MV CONSTANT definitions Client
const_1623506009046154000 == 
{c1, c2}
----

\* MV CONSTANT definitions Shard
const_1623506009046155000 == 
{s1, s2}
----

\* SYMMETRY definition
symm_1623506009046156000 == 
Permutations(const_1623506009046151000) \union Permutations(const_1623506009046152000) \union Permutations(const_1623506009046153000) \union Permutations(const_1623506009046154000) \union Permutations(const_1623506009046155000)
----

\* CONSTANT definitions @modelParameterConstants:3KeySharding
const_1623506009046157000 == 
k1 :> s1 @@ k2 :> s2
----

\* CONSTANT definitions @modelParameterConstants:4TxCoord
const_1623506009046158000 == 
t1 :> s1 @@ t2 :> s2
----

\* INIT definition @modelBehaviorNoSpec:0
init_1623506009046161000 ==
FALSE/\next = 0
----
\* NEXT definition @modelBehaviorNoSpec:0
next_1623506009046162000 ==
FALSE/\next' = next
----
=============================================================================
\* Modification History
\* Created Sat Jun 12 21:53:29 CST 2021 by hengxin
