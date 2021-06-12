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
const_162350423463658000 == 
{v1, v2}
----

\* MV CONSTANT definitions Trans
const_162350423463659000 == 
{t1, t2}
----

\* MV CONSTANT definitions Key
const_162350423463660000 == 
{k1, k2}
----

\* MV CONSTANT definitions Client
const_162350423463661000 == 
{c1, c2}
----

\* MV CONSTANT definitions Shard
const_162350423463662000 == 
{s1, s2}
----

\* SYMMETRY definition
symm_162350423463663000 == 
Permutations(const_162350423463658000) \union Permutations(const_162350423463659000) \union Permutations(const_162350423463660000) \union Permutations(const_162350423463661000) \union Permutations(const_162350423463662000)
----

\* CONSTANT definitions @modelParameterConstants:3KeySharding
const_162350423463664000 == 
k1 :> s1 @@ k2 :> s2
----

\* CONSTANT definitions @modelParameterConstants:4TxCoord
const_162350423463665000 == 
t1 :> s1 @@ t2 :> s2
----

=============================================================================
\* Modification History
\* Created Sat Jun 12 21:23:54 CST 2021 by hengxin
