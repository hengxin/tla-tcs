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
const_16235857873921075000 == 
{s1, s2}
----

\* MV CONSTANT definitions Tid
const_16235857873921076000 == 
{t1, t2}
----

\* MV CONSTANT definitions Key
const_16235857873921077000 == 
{k1, k2}
----

\* SYMMETRY definition
symm_16235857873921078000 == 
Permutations(const_16235857873921075000) \union Permutations(const_16235857873921076000) \union Permutations(const_16235857873921077000)
----

\* CONSTANT definitions @modelParameterConstants:2RSet
const_16235857873921079000 == 
t1 :> {<<k1, 0>>, <<k2, 0>>} @@ t2 :> {<<k1, 1>>, <<k2, 1>>}
----

\* CONSTANT definitions @modelParameterConstants:4KeySharding
const_16235857873921080000 == 
k1 :> s1 @@ k2 :> s2
----

\* CONSTANT definitions @modelParameterConstants:5WSet
const_16235857873921081000 == 
t1 :> {k2} @@ t2 :> {k1}
----

\* CONSTANT definitions @modelParameterConstants:6CVer
const_16235857873921082000 == 
t1 :> 1 @@ t2 :> 2
----

\* CONSTANT definitions @modelParameterConstants:7Coord
const_16235857873921083000 == 
t1 :> s1 @@ t2 :> s2
----

=============================================================================
\* Modification History
\* Created Sun Jun 13 20:03:07 CST 2021 by hengxin
