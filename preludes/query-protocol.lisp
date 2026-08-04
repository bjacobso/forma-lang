; query-protocol.lisp
; -----------------------------------------------------------------------------
; Hosted QueryPlan protocol descriptors.
; -----------------------------------------------------------------------------

(define-form query-type-name-ref
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name TypeNameRef)
      (:fields
        (:kind (:kind literal) (:values [name]) (:required true))
        (:name (:type string) (:required true))))))

(define-form query-type-id-ref
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name TypeIdRef)
      (:fields
        (:kind (:kind literal) (:values [id]) (:required true))
        (:id (:type string) (:required true))))))

(define-form query-type-ref
  (:phase meta)
  (:extensions
    (:protocol/union
      (:name TypeRef)
      (:schema-name TypeRef)
      (:members
        (:name (:ref TypeNameRef))
        (:id (:ref TypeIdRef))))))

(define-form query-relationship-type-name-ref
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name RelationshipTypeNameRef)
      (:fields
        (:kind (:kind literal) (:values [name]) (:required true))
        (:name (:type string) (:required true))))))

(define-form query-relationship-type-id-ref
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name RelationshipTypeIdRef)
      (:fields
        (:kind (:kind literal) (:values [id]) (:required true))
        (:id (:type string) (:required true))))))

(define-form query-relationship-type-ref
  (:phase meta)
  (:extensions
    (:protocol/union
      (:name RelationshipTypeRef)
      (:schema-name RelationshipTypeRef)
      (:members
        (:name (:ref RelationshipTypeNameRef))
        (:id (:ref RelationshipTypeIdRef))))))

(define-form query-value-var-expr
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryVarExpr)
      (:fields
        (:kind (:kind literal) (:values [var]) (:required true))
        (:var (:type string) (:required true))))))

(define-form query-value-field-expr
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryFieldExpr)
      (:fields
        (:kind (:kind literal) (:values [field]) (:required true))
        (:on (:type QueryValueExpr) (:required true))
        (:name (:type string) (:required true))))))

(define-form query-value-lit-expr
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryLiteralExpr)
      (:fields
        (:kind (:kind literal) (:values [lit]) (:required true))
        (:value (:type unknown) (:required true))))))

(define-form query-value-agg-expr
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryAggregateExpr)
      (:fields
        (:kind (:kind literal) (:values [agg]) (:required true))
        (:fn (:type AggFn) (:required true))
        (:of (:type QueryValueExpr))))))

(define-form query-value-expr
  (:phase meta)
  (:extensions
    (:protocol/union
      (:name QueryValueExpr)
      (:schema-name QueryValueExpr)
      (:members
        (:var (:ref QueryVarExpr))
        (:field (:ref QueryFieldExpr))
        (:lit (:ref QueryLiteralExpr))
        (:agg (:ref QueryAggregateExpr))))))

(define-form query-and-or-expr
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryAndOrExpr)
      (:fields
        (:op (:kind literal) (:values [and or]) (:required true))
        (:args (:kind array) (:item QueryExpr) (:required true))))))

(define-form query-not-expr
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryNotExpr)
      (:fields
        (:op (:kind literal) (:values [not]) (:required true))
        (:arg (:type QueryExpr) (:required true))))))

(define-form query-comparison-expr
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryComparisonExpr)
      (:fields
        (:op (:type ComparisonOp) (:required true))
        (:a (:type QueryValueExpr) (:required true))
        (:b (:type QueryValueExpr) (:required true))))))

(define-form query-in-expr
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryInExpr)
      (:fields
        (:op (:kind literal) (:values [in]) (:required true))
        (:a (:type QueryValueExpr) (:required true))
        (:set (:kind array) (:item QueryValueExpr) (:required true))))))

(define-form query-exists-expr
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryExistsExpr)
      (:fields
        (:op (:kind literal) (:values [exists]) (:required true))
        (:q (:type SubqueryPlan) (:required true))))))

(define-form query-expr
  (:phase meta)
  (:extensions
    (:protocol/union
      (:name QueryExpr)
      (:schema-name QueryExpr)
      (:members
        (:and-or (:ref QueryAndOrExpr))
        (:not (:ref QueryNotExpr))
        (:comparison (:ref QueryComparisonExpr))
        (:in (:ref QueryInExpr))
        (:exists (:ref QueryExistsExpr))))))

(define-form query-type-from
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryTypeSource)
      (:fields
        (:kind (:kind literal) (:values [type]) (:required true))
        (:type (:type TypeRef) (:required true))
        (:as (:type string) (:required true))))))

(define-form query-entity-from
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryEntitySource)
      (:fields
        (:kind (:kind literal) (:values [entity]) (:required true))
        (:id (:type string) (:required true))
        (:as (:type string) (:required true))))))

(define-form query-cte-from
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryCteSource)
      (:fields
        (:kind (:kind literal) (:values [cte]) (:required true))
        (:name (:type string) (:required true))
        (:as (:type string) (:required true))))))

(define-form query-view-from
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryViewSource)
      (:fields
        (:kind (:kind literal) (:values [view]) (:required true))
        (:name (:type string) (:required true))
        (:args (:kind record) (:value QueryValueExpr) (:required true))
        (:as (:type string) (:required true))))))

(define-form query-from
  (:phase meta)
  (:extensions
    (:protocol/union
      (:name QuerySource)
      (:schema-name QuerySource)
      (:members
        (:type (:ref QueryTypeSource))
        (:entity (:ref QueryEntitySource))
        (:cte (:ref QueryCteSource))
        (:view (:ref QueryViewSource))))))

(define-form query-one-hop
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryOneHop)
      (:fields
        (:kind (:kind literal) (:values [one]) (:required true))))))

(define-form query-many-hop
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryManyHop)
      (:fields
        (:kind (:kind literal) (:values [many]) (:required true))
        (:min (:type number))
        (:max (:type number) (:required true))))))

(define-form query-closure-hop
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryClosureHop)
      (:fields
        (:kind (:kind literal) (:values [closure]) (:required true))
        (:limit (:type number) (:required true))))))

(define-form query-hop
  (:phase meta)
  (:extensions
    (:protocol/union
      (:name QueryHop)
      (:schema-name QueryHop)
      (:members
        (:one (:ref QueryOneHop))
        (:many (:ref QueryManyHop))
        (:closure (:ref QueryClosureHop))))))

(define-form query-join
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryJoin)
      (:fields
        (:kind (:kind literal) (:values [link]) (:required true))
        (:as (:type string))
        (:from (:type string) (:required true))
        (:type (:type RelationshipTypeRef) (:required true))
        (:to (:type string) (:required true))
        (:dir (:type LinkDir))
        (:optional (:type boolean))
        (:hop (:type QueryHop))
        (:where (:type QueryExpr))))))

(define-form query-object-shape
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryObjectShape)
      (:fields
        (:kind (:kind literal) (:values [object]) (:required true))
        (:fields (:kind record) (:value QueryShape) (:required true))))))

(define-form query-pick-shape
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryPickShape)
      (:fields
        (:kind (:kind literal) (:values [pick]) (:required true))
        (:from (:type string) (:required true))
        (:fields (:kind array) (:item string) (:required true))))))

(define-form query-value-shape
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryValueShape)
      (:fields
        (:kind (:kind literal) (:values [value]) (:required true))
        (:expr (:type QueryValueExpr) (:required true))))))

(define-form query-list-shape
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryListShape)
      (:fields
        (:kind (:kind literal) (:values [list]) (:required true))
        (:of (:type QueryShape) (:required true))
        (:limit (:type number))
        (:distinct (:type boolean))))))

(define-form query-shape
  (:phase meta)
  (:extensions
    (:protocol/union
      (:name QueryShape)
      (:schema-name QueryShape)
      (:members
        (:object (:ref QueryObjectShape))
        (:pick (:ref QueryPickShape))
        (:value (:ref QueryValueShape))
        (:list (:ref QueryListShape))))))

(define-form query-order
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryOrder)
      (:fields
        (:expr (:type QueryValueExpr) (:required true))
        (:dir (:type SortDir) (:required true))
        (:nulls (:type NullsOrder))))))

(define-form query-page
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryPage)
      (:fields
        (:first (:type number) (:required true))
        (:after (:type string))))))

(define-form query-options
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryOptions)
      (:fields
        (:maxJoins (:type number))
        (:maxHops (:type number))
        (:maxCost (:type number))
        (:timeoutMs (:type number))))))

(define-form query-defs
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryDefs)
      (:fields
        (:ctes (:kind record) (:value SubqueryPlan))))))

(define-form query-subquery
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name SubqueryPlan)
      (:fields
        (:v (:kind literal) (:values [1]) (:required true))
        (:asOf (:type string) (:required true))
        (:defs (:type QueryDefs))
        (:from (:type QuerySource) (:required true))
        (:joins (:kind array) (:item QueryJoin))
        (:where (:type QueryExpr))
        (:groupBy (:kind array) (:item QueryValueExpr))
        (:having (:type QueryExpr))
        (:select (:type QueryShape) (:required true))))))

(define-form query-plan
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryPlan)
      (:fields
        (:v (:kind literal) (:values [1]) (:required true))
        (:asOf (:type string) (:required true))
        (:defs (:type QueryDefs))
        (:from (:type QuerySource) (:required true))
        (:joins (:kind array) (:item QueryJoin))
        (:where (:type QueryExpr))
        (:groupBy (:kind array) (:item QueryValueExpr))
        (:having (:type QueryExpr))
        (:select (:type QueryShape) (:required true))
        (:orderBy (:kind array) (:item QueryOrder))
        (:page (:type QueryPage))
        (:options (:type QueryOptions))))))

(define-form query-page-info
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name PageInfo)
      (:fields
        (:nextCursor (:type string))
        (:hasMore (:type boolean) (:required true))))))

(define-form query-stats
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryStats)
      (:fields
        (:scannedFacts (:type number))
        (:elapsedMs (:type number))))))

(define-form query-result
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryResult)
      (:fields
        (:asOf (:type string) (:required true))
        (:rows (:kind array) (:item (:kind record) (:value unknown)) (:required true))
        (:page (:type PageInfo))
        (:stats (:type QueryStats))))))

(define-form query-agg-fn
  (:phase meta)
  (:extensions
    (:protocol/enum
      (:name AggFn)
      (:values [count countDistinct sum avg min max])
      (:description "Aggregate function: count, countDistinct, sum, avg, min, max"))))

(define-form query-comparison-op
  (:phase meta)
  (:extensions
    (:protocol/enum
      (:name ComparisonOp)
      (:values [eq neq lt lte gt gte])
      (:description "Comparison operator: eq, neq, lt, lte, gt, gte"))))

(define-form query-link-dir
  (:phase meta)
  (:extensions
    (:protocol/enum
      (:name LinkDir)
      (:values [out in both])
      (:description "Link traversal direction: out, in, or both"))))

(define-form query-sort-dir
  (:phase meta)
  (:extensions
    (:protocol/enum
      (:name SortDir)
      (:values [asc desc])
      (:description "Sort direction: ascending or descending"))))

(define-form query-nulls-order
  (:phase meta)
  (:extensions
    (:protocol/enum
      (:name NullsOrder)
      (:values [first last])
      (:description "Where to place null values in sort order"))))

(define-form query-plan-module
  (:phase meta)
  (:extensions
    (:protocol/module
      (:name QueryPlan)
      (:enums [AggFn ComparisonOp LinkDir SortDir NullsOrder])
      (:objects [
        TypeNameRef
        TypeIdRef
        RelationshipTypeNameRef
        RelationshipTypeIdRef
        QueryVarExpr
        QueryFieldExpr
        QueryLiteralExpr
        QueryAggregateExpr
        QueryAndOrExpr
        QueryNotExpr
        QueryComparisonExpr
        QueryInExpr
        QueryExistsExpr
        QueryTypeSource
        QueryEntitySource
        QueryCteSource
        QueryViewSource
        QueryOneHop
        QueryManyHop
        QueryClosureHop
        QueryJoin
        QueryObjectShape
        QueryPickShape
        QueryValueShape
        QueryListShape
        QueryOrder
        QueryPage
        QueryOptions
        QueryDefs
        SubqueryPlan
        QueryPlan
        PageInfo
        QueryStats
        QueryResult
      ])
      (:unions [
        TypeRef
        RelationshipTypeRef
        QueryValueExpr
        QueryExpr
        QuerySource
        QueryHop
        QueryShape
      ]))))
