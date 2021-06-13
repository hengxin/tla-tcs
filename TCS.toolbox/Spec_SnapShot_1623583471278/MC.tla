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
const_1623583469265985000 == 
{s1, s2}
----

\* MV CONSTANT definitions Tid
const_1623583469265986000 == 
{t1, t2}
----

\* MV CONSTANT definitions Key
const_1623583469265987000 == 
{k1, k2}
----

\* SYMMETRY definition
symm_1623583469265988000 == 
Permutations(const_1623583469265985000) \union Permutations(const_1623583469265986000) \union Permutations(const_1623583469265987000)
----

\* CONSTANT definitions @modelParameterConstants:2RSet
const_1623583469265989000 == 
t1 :> {<<k1, 0>>, <<k2, 0>>} @@ t2 :> {<<k1, 1>>, <<k2, 1>>}
----

\* CONSTANT definitions @modelParameterConstants:4KeySharding
const_1623583469265990000 == 
k1 :> s1 @@ k2 :> s2
----

\* CONSTANT definitions @modelParameterConstants:5WSet
const_1623583469265991000 == 
t1 :> {k2} @@ t2 :> {k1}
----

\* CONSTANT definitions @modelParameterConstants:6CVer
const_1623583469265992000 == 
t1 :> 1 @@ t2 :> 2
----

\* CONSTANT definitions @modelParameterConstants:7Coord
const_1623583469265993000 == 
t1 :> s1 @@ t2 :> s2
----

\* Constant expression definition @modelExpressionEval
const_expr_1623583469265995000 == 
TShard(t1) = Shard
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_1623583469265995000>>)
----

=============================================================================
\* Modification History
\* Created Sun Jun 13 19:24:29 CST 2021 by hengxin
