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
const_162350527775374000 == 
{v1, v2}
----

\* MV CONSTANT definitions Trans
const_162350527775375000 == 
{t1, t2}
----

\* MV CONSTANT definitions Key
const_162350527775376000 == 
{k1, k2}
----

\* MV CONSTANT definitions Client
const_162350527775377000 == 
{c1, c2}
----

\* MV CONSTANT definitions Shard
const_162350527775378000 == 
{s1, s2}
----

\* SYMMETRY definition
symm_162350527775379000 == 
Permutations(const_162350527775374000) \union Permutations(const_162350527775375000) \union Permutations(const_162350527775376000) \union Permutations(const_162350527775377000) \union Permutations(const_162350527775378000)
----

\* CONSTANT definitions @modelParameterConstants:3KeySharding
const_162350527775380000 == 
k1 :> s1 @@ k2 :> s2
----

\* CONSTANT definitions @modelParameterConstants:4TxCoord
const_162350527775381000 == 
t1 :> s1 @@ t2 :> s2
----

\* INIT definition @modelBehaviorNoSpec:0
init_162350527775382000 ==
FALSE/\next = 0
----
\* NEXT definition @modelBehaviorNoSpec:0
next_162350527775383000 ==
FALSE/\next' = next
----
=============================================================================
\* Modification History
\* Created Sat Jun 12 21:41:17 CST 2021 by hengxin
