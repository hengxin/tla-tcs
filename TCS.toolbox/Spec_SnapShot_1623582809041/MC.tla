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
const_1623582807026937000 == 
{s1, s2}
----

\* MV CONSTANT definitions Tid
const_1623582807026938000 == 
{t1, t2}
----

\* MV CONSTANT definitions Key
const_1623582807026939000 == 
{k1, k2}
----

\* SYMMETRY definition
symm_1623582807026940000 == 
Permutations(const_1623582807026937000) \union Permutations(const_1623582807026938000) \union Permutations(const_1623582807026939000)
----

\* CONSTANT definitions @modelParameterConstants:2RSet
const_1623582807026941000 == 
t1 :> {<<k1, 0>>, <<k2, 0>>} @@ t2 :> {<<k1, 1>>, <<k2, 1>>}
----

\* CONSTANT definitions @modelParameterConstants:4KeySharding
const_1623582807026942000 == 
k1 :> s1 @@ k2 :> s2
----

\* CONSTANT definitions @modelParameterConstants:5WSet
const_1623582807026943000 == 
t1 :> {k2} @@ t2 :> {k1}
----

\* CONSTANT definitions @modelParameterConstants:6CVer
const_1623582807026944000 == 
t1 :> 1 @@ t2 :> 2
----

\* CONSTANT definitions @modelParameterConstants:7Coord
const_1623582807026945000 == 
t1 :> s1 @@ t2 :> s2
----

\* Constant expression definition @modelExpressionEval
const_expr_1623582807026947000 == 
TKey(t1)= Key /\ TKey(t2) = Key /\ TSharding(t1) = Shard
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_1623582807026947000>>)
----

=============================================================================
\* Modification History
\* Created Sun Jun 13 19:13:27 CST 2021 by hengxin
