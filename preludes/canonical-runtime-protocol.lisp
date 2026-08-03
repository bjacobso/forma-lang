; canonical-runtime-protocol.lisp
; -----------------------------------------------------------------------------
; Hosted CanonicalRuntime protocol descriptors.
; -----------------------------------------------------------------------------

(define-protocol CanonicalRuntime
  (:imports [[CanonicalDeclarationRef from CanonicalRef CanonicalDeclarationRef]])

  (record Span
    (:schema-name Span)
    (:fields
      (:sourceId (:type string) (:required true))
      (:startOffset (:type number) (:required true))
      (:endOffset (:type number) (:required true))))

  (type CanonicalExpr
    (:schema-name CanonicalExpr)
    (:type (:kind union)
      (:variants [nil boolean number string {:array CanonicalExpr} {:record CanonicalExpr}])))

  (record CanonicalRuntimeExpr
    (:schema-name CanonicalRuntimeExpr)
    (:fields
      (:kind (:kind literal) (:values [raw-expr]) (:required true))
      (:expr (:type CanonicalExpr) (:required true))))

  (record CanonicalRuntimeActionInput
    (:schema-name CanonicalRuntimeActionInput)
    (:fields
      (:name (:type string) (:required true))
      (:entityRef (:type CanonicalDeclarationRef) (:required true))))

  (record CanonicalRuntimeFieldValue
    (:schema-name CanonicalRuntimeFieldValue)
    (:fields
      (:field (:type string) (:required true))
      (:value (:type CanonicalExpr) (:required true))))

  (record CanonicalRuntimeEmitStep
    (:schema-name CanonicalRuntimeEmitStep)
    (:fields
      (:kind (:kind literal) (:values [emit]) (:required true))
      (:event (:type CanonicalExpr) (:required true))))

  (record CanonicalRuntimeSetFieldStep
    (:schema-name CanonicalRuntimeSetFieldStep)
    (:fields
      (:kind (:kind literal) (:values [set-field]) (:required true))
      (:targetBinding (:type string) (:required true))
      (:field (:type string) (:required true))
      (:value (:type CanonicalExpr) (:required true))))

  (record CanonicalRuntimeCreateEntityStep
    (:schema-name CanonicalRuntimeCreateEntityStep)
    (:fields
      (:kind (:kind literal) (:values [create-entity]) (:required true))
      (:entityName (:type string) (:required true))
      (:assignments (:kind array) (:item CanonicalRuntimeFieldValue) (:required true))))

  (record CanonicalRuntimeLinkRecordsStep
    (:schema-name CanonicalRuntimeLinkRecordsStep)
    (:fields
      (:kind (:kind literal) (:values [link-records]) (:required true))
      (:sourceBinding (:type string) (:required true))
      (:targetBinding (:type string) (:required true))
      (:relation (:type string) (:required true))))

  (record CanonicalRuntimeCallActionStep
    (:schema-name CanonicalRuntimeCallActionStep)
    (:fields
      (:kind (:kind literal) (:values [call-action]) (:required true))
      (:actionRef (:type CanonicalDeclarationRef) (:required true))
      (:entityArguments (:kind array) (:item string) (:required true))
      (:arguments (:kind array) (:item CanonicalRuntimeFieldValue) (:required true))))

  (record CanonicalRuntimeEvalStep
    (:schema-name CanonicalRuntimeEvalStep)
    (:fields
      (:kind (:kind literal) (:values [eval]) (:required true))
      (:expr (:type CanonicalRuntimeExpr) (:required true))))

  (sum CanonicalRuntimeActionStep
    (:schema-name CanonicalRuntimeActionStep)
    (:members
      (:emit (:ref CanonicalRuntimeEmitStep))
      (:set-field (:ref CanonicalRuntimeSetFieldStep))
      (:create-entity (:ref CanonicalRuntimeCreateEntityStep))
      (:link-records (:ref CanonicalRuntimeLinkRecordsStep))
      (:call-action (:ref CanonicalRuntimeCallActionStep))
      (:eval (:ref CanonicalRuntimeEvalStep))))

  (record CanonicalRuntimeAction
    (:schema-name CanonicalRuntimeAction)
    (:fields
      (:kind (:kind literal) (:values [RuntimeAction]) (:required true))
      (:name (:type string) (:required true))
      (:inputs (:kind array) (:item CanonicalRuntimeActionInput) (:required true))
      (:declaredReturnType (:type CanonicalExpr) (:required true))
      (:steps (:kind array) (:item CanonicalRuntimeActionStep) (:required true))
      (:loc (:type Span)))))
