; action-protocol.lisp
; -----------------------------------------------------------------------------
; Hosted ActionPlan protocol descriptors.
; -----------------------------------------------------------------------------

(define-form action-primitive-field-value-type
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name PrimitiveActionFieldType)
      (:fields
        (:kind (:kind literal) (:values [primitive]) (:required true))
        (:type (:type ActionPrimitiveType) (:required true))))))

(define-form action-ref-type
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ActionRefType)
      (:fields
        (:kind (:kind literal) (:values [ref]) (:required true))
        (:type (:type TypeRef) (:required true))))))

(define-form action-refs-type
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ActionRefsType)
      (:fields
        (:kind (:kind literal) (:values [refs]) (:required true))
        (:type (:type TypeRef) (:required true))))))

(define-form action-enum-type
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ActionEnumType)
      (:fields
        (:kind (:kind literal) (:values [enum]) (:required true))
        (:values (:kind array) (:item string) (:required true))))))

(define-form action-field-value-type
  (:phase meta)
  (:extensions
    (:protocol/union
      (:name ActionFieldType)
      (:schema-name ActionFieldType)
      (:members
        (:primitive (:ref PrimitiveActionFieldType))
        (:ref (:ref ActionRefType))
        (:refs (:ref ActionRefsType))
        (:enum (:ref ActionEnumType))))))

(define-form action-field-validation
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ActionFieldValidation)
      (:fields
        (:min (:type number))
        (:max (:type number))
        (:pattern (:type string))
        (:format (:type string))))))

(define-form action-input-field
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ActionInput)
      (:fields
        (:name (:type string) (:required true))
        (:type (:type ActionFieldType) (:required true))
        (:required (:type boolean))
        (:description (:type string))
        (:validation (:type ActionFieldValidation))))))

(define-form action-set-clause
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ActionSetClause)
      (:fields
        (:attr (:type string) (:required true))
        (:value (:type QueryValueExpr) (:required true))))))

(define-form action-create-effect
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name CreateActionEffect)
      (:fields
        (:kind (:kind literal) (:values [create]) (:required true))
        (:type (:type TypeRef) (:required true))
        (:sets (:kind array) (:item ActionSetClause) (:required true))))))

(define-form action-patch-effect
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name PatchActionEffect)
      (:fields
        (:kind (:kind literal) (:values [patch]) (:required true))
        (:target (:type QueryValueExpr) (:required true))
        (:sets (:kind array) (:item ActionSetClause) (:required true))))))

(define-form action-link-effect
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name LinkActionEffect)
      (:fields
        (:kind (:kind literal) (:values [link]) (:required true))
        (:from (:type QueryValueExpr) (:required true))
        (:type (:type RelationshipTypeRef) (:required true))
        (:to (:type QueryValueExpr) (:required true))
        (:properties (:kind array) (:item ActionSetClause))))))

(define-form action-emit-effect
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name EmitActionEffect)
      (:fields
        (:kind (:kind literal) (:values [emit]) (:required true))
        (:event (:type string) (:required true))
        (:payload (:type QueryValueExpr))))))

(define-form action-return-effect
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ReturnActionEffect)
      (:fields
        (:kind (:kind literal) (:values [return]) (:required true))
        (:value (:type QueryValueExpr) (:required true))))))

(define-form action-effect
  (:phase meta)
  (:extensions
    (:protocol/union
      (:name ActionEffect)
      (:schema-name ActionEffect)
      (:members
        (:create (:ref CreateActionEffect))
        (:patch (:ref PatchActionEffect))
        (:link (:ref LinkActionEffect))
        (:emit (:ref EmitActionEffect))
        (:return (:ref ReturnActionEffect))))))

(define-form action-requires-permission
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ActionRequiresPermission)
      (:fields
        (:permission (:type string) (:required true))
        (:on (:type QueryValueExpr))))))

(define-form action-auth
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ActionAuth)
      (:fields
        (:requires (:kind array) (:item ActionRequiresPermission) (:required true))))))

(define-form action-definition
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ActionPlan)
      (:fields
        (:v (:kind literal) (:values [1]) (:required true))
        (:name (:type string) (:required true))
        (:description (:type string))
        (:inputs (:kind array) (:item ActionInput) (:required true))
        (:auth (:type ActionAuth))
        (:effects (:kind array) (:item ActionEffect) (:required true))))))

(define-form action-plan-module
  (:phase meta)
  (:extensions
    (:protocol/module
      (:name ActionPlan)
      (:imports [
        [RelationshipTypeRef from QueryPlan RelationshipTypeRef]
        [TypeRef from QueryPlan TypeRef]
        [QueryValueExpr from QueryPlan QueryValueExpr]
      ])
      (:objects [
        PrimitiveActionFieldType
        ActionRefType
        ActionRefsType
        ActionEnumType
        ActionFieldValidation
        ActionInput
        ActionSetClause
        CreateActionEffect
        PatchActionEffect
        LinkActionEffect
        EmitActionEffect
        ReturnActionEffect
        ActionRequiresPermission
        ActionAuth
        ActionPlan
      ])
      (:unions [ActionFieldType ActionEffect])
      (:literals [
        {:name ActionPrimitiveType
         :values [String Number Boolean Datetime Json]
         :description "Primitive field type: String, Number, Boolean, Datetime, Json"}
      ]))))
