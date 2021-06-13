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
const_1623550778247186000 == 
{s1, s2}
----

\* MV CONSTANT definitions Tid
const_1623550778247187000 == 
{t1, t2}
----

\* MV CONSTANT definitions Key
const_1623550778247188000 == 
{k1, k2}
----

\* SYMMETRY definition
symm_1623550778247189000 == 
Permutations(const_1623550778247186000) \union Permutations(const_1623550778247187000) \union Permutations(const_1623550778247188000)
----

\* CONSTANT definitions @modelParameterConstants:2RSet
const_1623550778247190000 == 
t1 :> {<<k1, 0>>, <<k2, 0>>} @@ t2 :> {<<k1, 1>>, <<k2, 1>>}
----

\* CONSTANT definitions @modelParameterConstants:4KeySharding
const_1623550778247191000 == 
k1 :> s1 @@ k2 :> s2
----

\* CONSTANT definitions @modelParameterConstants:5WSet
const_1623550778247192000 == 
t1 :> {k2} @@ t2 :> {k1}
----

\* CONSTANT definitions @modelParameterConstants:6CVer
const_1623550778247193000 == 
t1 :> 1 @@ t2 :> 2
----

\* CONSTANT definitions @modelParameterConstants:7Coord
const_1623550778247194000 == 
t1 :> s1 @@ t2 :> s2
----

\* INIT definition @modelBehaviorNoSpec:0
init_1623550778247196000 ==
FALSE/\phase = 0
----
\* NEXT definition @modelBehaviorNoSpec:0
next_1623550778247197000 ==
FALSE/\phase' = phase
----
=============================================================================
\* Modification History
\* Created Sun Jun 13 10:19:38 CST 2021 by hengxin
