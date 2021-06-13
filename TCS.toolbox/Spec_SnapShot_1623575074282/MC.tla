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
const_1623575072258853000 == 
{s1, s2}
----

\* MV CONSTANT definitions Tid
const_1623575072258854000 == 
{t1, t2}
----

\* MV CONSTANT definitions Key
const_1623575072258855000 == 
{k1, k2}
----

\* SYMMETRY definition
symm_1623575072258856000 == 
Permutations(const_1623575072258853000) \union Permutations(const_1623575072258854000) \union Permutations(const_1623575072258855000)
----

\* CONSTANT definitions @modelParameterConstants:2RSet
const_1623575072258857000 == 
t1 :> {<<k1, 0>>, <<k2, 0>>} @@ t2 :> {<<k1, 1>>, <<k2, 1>>}
----

\* CONSTANT definitions @modelParameterConstants:4KeySharding
const_1623575072258858000 == 
k1 :> s1 @@ k2 :> s2
----

\* CONSTANT definitions @modelParameterConstants:5WSet
const_1623575072258859000 == 
t1 :> {k2} @@ t2 :> {k1}
----

\* CONSTANT definitions @modelParameterConstants:6CVer
const_1623575072258860000 == 
t1 :> 1 @@ t2 :> 2
----

\* CONSTANT definitions @modelParameterConstants:7Coord
const_1623575072258861000 == 
t1 :> s1 @@ t2 :> s2
----

\* Constant expression definition @modelExpressionEval
const_expr_1623575072258863000 == 
TKey(t1)= Key /\ TKey(t2) = Key /\ TSharding(t1) = Shard
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_1623575072258863000>>)
----

=============================================================================
\* Modification History
\* Created Sun Jun 13 17:04:32 CST 2021 by hengxin
