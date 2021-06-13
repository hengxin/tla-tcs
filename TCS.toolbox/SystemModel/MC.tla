---- MODULE MC ----
EXTENDS TCS, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
s1, s2
----

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
t1, t2
----

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
k1, k2
----

\* MV CONSTANT definitions Shard
const_16235857692041041000 == 
{s1, s2}
----

\* MV CONSTANT definitions Tid
const_16235857692041042000 == 
{t1, t2}
----

\* MV CONSTANT definitions Key
const_16235857692041043000 == 
{k1, k2}
----

\* SYMMETRY definition
symm_16235857692041044000 == 
Permutations(const_16235857692041041000) \union Permutations(const_16235857692041042000) \union Permutations(const_16235857692041043000)
----

\* CONSTANT definitions @modelParameterConstants:2RSet
const_16235857692041045000 == 
t1 :> {<<k1, 0>>, <<k2, 0>>} @@ t2 :> {<<k1, 1>>, <<k2, 1>>}
----

\* CONSTANT definitions @modelParameterConstants:4KeySharding
const_16235857692041046000 == 
k1 :> s1 @@ k2 :> s2
----

\* CONSTANT definitions @modelParameterConstants:5WSet
const_16235857692041047000 == 
t1 :> {k2} @@ t2 :> {k1}
----

\* CONSTANT definitions @modelParameterConstants:6CVer
const_16235857692041048000 == 
t1 :> 1 @@ t2 :> 2
----

\* CONSTANT definitions @modelParameterConstants:7Coord
const_16235857692041049000 == 
t1 :> s1 @@ t2 :> s2
----

\* INIT definition @modelBehaviorNoSpec:0
init_16235857692041051000 ==
FALSE/\phase = 0
----
\* NEXT definition @modelBehaviorNoSpec:0
next_16235857692041052000 ==
FALSE/\phase' = phase
----
=============================================================================
\* Modification History
\* Created Sun Jun 13 20:02:49 CST 2021 by hengxin
