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
const_16235844116171030000 == 
{s1, s2}
----

\* MV CONSTANT definitions Tid
const_16235844116171031000 == 
{t1, t2}
----

\* MV CONSTANT definitions Key
const_16235844116171032000 == 
{k1, k2}
----

\* SYMMETRY definition
symm_16235844116171033000 == 
Permutations(const_16235844116171030000) \union Permutations(const_16235844116171031000) \union Permutations(const_16235844116171032000)
----

\* CONSTANT definitions @modelParameterConstants:2RSet
const_16235844116171034000 == 
t1 :> {<<k1, 0>>, <<k2, 0>>} @@ t2 :> {<<k1, 1>>, <<k2, 1>>}
----

\* CONSTANT definitions @modelParameterConstants:4KeySharding
const_16235844116171035000 == 
k1 :> s1 @@ k2 :> s2
----

\* CONSTANT definitions @modelParameterConstants:5WSet
const_16235844116171036000 == 
t1 :> {k2} @@ t2 :> {k1}
----

\* CONSTANT definitions @modelParameterConstants:6CVer
const_16235844116171037000 == 
t1 :> 1 @@ t2 :> 2
----

\* CONSTANT definitions @modelParameterConstants:7Coord
const_16235844116171038000 == 
t1 :> s1 @@ t2 :> s2
----

=============================================================================
\* Modification History
\* Created Sun Jun 13 19:40:11 CST 2021 by hengxin
