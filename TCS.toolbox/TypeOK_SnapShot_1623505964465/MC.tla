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
const_1623505962451140000 == 
{v1, v2}
----

\* MV CONSTANT definitions Trans
const_1623505962451141000 == 
{t1, t2}
----

\* MV CONSTANT definitions Key
const_1623505962451142000 == 
{k1, k2}
----

\* MV CONSTANT definitions Client
const_1623505962451143000 == 
{c1, c2}
----

\* MV CONSTANT definitions Shard
const_1623505962451144000 == 
{s1, s2}
----

\* SYMMETRY definition
symm_1623505962451145000 == 
Permutations(const_1623505962451140000) \union Permutations(const_1623505962451141000) \union Permutations(const_1623505962451142000) \union Permutations(const_1623505962451143000) \union Permutations(const_1623505962451144000)
----

\* CONSTANT definitions @modelParameterConstants:3KeySharding
const_1623505962451146000 == 
k1 :> s1 @@ k2 :> s2
----

\* CONSTANT definitions @modelParameterConstants:4TxCoord
const_1623505962451147000 == 
t1 :> s1 @@ t2 :> s2
----

=============================================================================
\* Modification History
\* Created Sat Jun 12 21:52:42 CST 2021 by hengxin
