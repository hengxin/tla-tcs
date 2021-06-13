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
const_1623551052792254000 == 
{s1, s2}
----

\* MV CONSTANT definitions Tid
const_1623551052792255000 == 
{t1, t2}
----

\* MV CONSTANT definitions Key
const_1623551052793256000 == 
{k1, k2}
----

\* SYMMETRY definition
symm_1623551052793257000 == 
Permutations(const_1623551052792254000) \union Permutations(const_1623551052792255000) \union Permutations(const_1623551052793256000)
----

\* CONSTANT definitions @modelParameterConstants:2RSet
const_1623551052793258000 == 
t1 :> {<<k1, 0>>, <<k2, 0>>} @@ t2 :> {<<k1, 1>>, <<k2, 1>>}
----

\* CONSTANT definitions @modelParameterConstants:4KeySharding
const_1623551052793259000 == 
k1 :> s1 @@ k2 :> s2
----

\* CONSTANT definitions @modelParameterConstants:5WSet
const_1623551052793260000 == 
t1 :> {k2} @@ t2 :> {k1}
----

\* CONSTANT definitions @modelParameterConstants:6CVer
const_1623551052793261000 == 
t1 :> 1 @@ t2 :> 2
----

\* CONSTANT definitions @modelParameterConstants:7Coord
const_1623551052793262000 == 
t1 :> s1 @@ t2 :> s2
----

=============================================================================
\* Modification History
\* Created Sun Jun 13 10:24:12 CST 2021 by hengxin
