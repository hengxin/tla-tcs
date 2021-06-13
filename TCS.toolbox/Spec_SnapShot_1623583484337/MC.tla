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
const_16235834823211008000 == 
{s1, s2}
----

\* MV CONSTANT definitions Tid
const_16235834823211009000 == 
{t1, t2}
----

\* MV CONSTANT definitions Key
const_16235834823211010000 == 
{k1, k2}
----

\* SYMMETRY definition
symm_16235834823211011000 == 
Permutations(const_16235834823211008000) \union Permutations(const_16235834823211009000) \union Permutations(const_16235834823211010000)
----

\* CONSTANT definitions @modelParameterConstants:2RSet
const_16235834823211012000 == 
t1 :> {<<k1, 0>>, <<k2, 0>>} @@ t2 :> {<<k1, 1>>, <<k2, 1>>}
----

\* CONSTANT definitions @modelParameterConstants:4KeySharding
const_16235834823211013000 == 
k1 :> s1 @@ k2 :> s2
----

\* CONSTANT definitions @modelParameterConstants:5WSet
const_16235834823211014000 == 
t1 :> {k2} @@ t2 :> {k1}
----

\* CONSTANT definitions @modelParameterConstants:6CVer
const_16235834823211015000 == 
t1 :> 1 @@ t2 :> 2
----

\* CONSTANT definitions @modelParameterConstants:7Coord
const_16235834823211016000 == 
t1 :> s1 @@ t2 :> s2
----

=============================================================================
\* Modification History
\* Created Sun Jun 13 19:24:42 CST 2021 by hengxin
