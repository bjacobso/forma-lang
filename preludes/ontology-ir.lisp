; ontology-ir.lisp
; -----------------------------------------------------------------------------
; Canonical ontology IR metadata used by TypeScript code generation.
;
; This file describes declaration catalog facts that are otherwise easy to
; duplicate across schemas, grouping helpers, and declaration indexes.
; -----------------------------------------------------------------------------

(define-form ontology-ir-entity-field
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name EntityFieldIR)
      (:fields
        (:name (:type string) (:required true))
        (:type (:type RuntimeExpr) (:required true))
        (:required (:kind union) (:variants [boolean string]))
        (:indexed (:kind union) (:variants [boolean string]))
        (:format (:type string))
        (:description (:type string))))))

(define-form ontology-ir-action-input
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ActionInputIR)
      (:fields
        (:name (:type string) (:required true))
        (:type (:type RuntimeExpr) (:required true))
        (:required (:kind union) (:variants [boolean string]))))))

(define-form ontology-ir-view-column
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ViewColumnIR)
      (:fields
        (:name (:type string) (:required true))
        (:label (:type string))
        (:expr (:type ExecutableRuntimeExpr))))))

(define-form ontology-ir-view-sort
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ViewSortIR)
      (:fields
        (:field (:type string) (:required true))
        (:direction (:kind literal) (:values [asc desc]) (:required true))))))

(define-form ontology-ir-resolution-input
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ResolutionInputIR)
      (:fields
        (:param (:type string))
        (:runtimeSource (:type ExecutableRuntimeExpr))))))

(define-form ontology-ir-resolution
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ResolutionIR)
      (:fields
        (:kind (:kind literal) (:values [Resolution]))
        (:action (:type string))
        (:actionRef (:type RuntimeExpr))
        (:mutation (:type string))
        (:mutationRef (:type RuntimeExpr))
        (:label (:type string))
        (:autoInvoke (:kind union) (:variants [boolean string]))
        (:auto (:kind union) (:variants [boolean string]))
        (:inputs (:kind array) (:item ResolutionInputIR))))))

(define-form ontology-ir-trigger
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name TriggerIR)
      (:fields
        (:kind (:kind literal) (:values [Trigger]))
        (:triggerKind (:type string))
        (:entity (:type string))))))

(define-form ontology-ir-process-node-input
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ProcessNodeInputIR)
      (:fields
        (:name (:type string) (:required true))
        (:expr (:type ExecutableRuntimeExpr) (:required true))))))

(define-form ontology-ir-process-node
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ProcessNodeIR)
      (:fields
        (:kind (:kind literal) (:values [Node]))
        (:id (:type string))
        (:action (:type string))
        (:actionRef (:type RuntimeExpr))
        (:mutation (:type string))
        (:mutationRef (:type RuntimeExpr))
        (:join (:type string))
        (:fanOut (:type string))
        (:inputs (:kind array) (:item ProcessNodeInputIR))))))

(define-form ontology-ir-process-guard
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ProcessGuardIR)
      (:fields
        (:kind (:kind literal) (:values [Guard]))
        (:guardKind (:type string))
        (:expr (:type ExecutableRuntimeExpr))))))

(define-form ontology-ir-process-edge
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ProcessEdgeIR)
      (:fields
        (:kind (:kind literal) (:values [Edge]))
        (:from (:type string))
        (:to (:type string))
        (:guard (:type ProcessGuardIR))))))

(define-form ontology-ir-document-completion
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name DocumentCompletionIR)
      (:fields
        (:kind (:kind literal) (:values [CompletionMutation]))
        (:mutation (:type string))
        (:mutationRef (:type RuntimeExpr))
        (:entity (:type string))
        (:entityRef (:type RuntimeExpr))))))

(define-form ontology-ir-document-page
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name DocumentPageIR)
      (:fields
        (:kind (:kind literal) (:values [Page]))
        (:sectionId (:type string))
        (:assignee (:type string))
        (:description (:type string))
        (:dependsOn (:kind array) (:item string))
        (:completion (:type DocumentCompletionIR))
        (:fields (:kind array) (:item DocumentFieldIR))))))

(define-form ontology-ir-attribute-binding
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name AttributeBindingIR)
      (:fields
        (:kind (:kind literal) (:values [AttributeBinding]))
        (:attribute (:type string) (:required true))
        (:transform (:type AttributeBindingTransformIR))
        (:entity (:type string))
        (:cardinality (:type AttributeBindingCardinalityIR))))))

(define-form ontology-ir-document-field-option
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name DocumentFieldOptionIR)
      (:fields
        (:kind (:kind literal) (:values [Option]))
        (:value (:type string))
        (:label (:type string))))))

(define-form ontology-ir-document-field
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name DocumentFieldIR)
      (:fields
        (:kind (:kind literal) (:values [Field]))
        (:type (:type string))
        (:path (:type string))
        (:label (:type string))
        (:description (:type string))
        (:content (:type string))
        (:required (:kind union) (:variants [boolean string]))
        (:options (:kind array) (:item DocumentFieldOptionIR))
        (:binding (:type AttributeBindingIR))))))

(define-form ontology-ir-document-role-locale
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name DocumentRoleLocaleIR)
      (:fields
        (:kind (:kind literal) (:values [Role]))
        (:name (:type string))
        (:label (:type string))
        (:description (:type string))))))

(define-form ontology-ir-document-section-locale
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name DocumentSectionLocaleIR)
      (:fields
        (:kind (:kind literal) (:values [Section]))
        (:name (:type string))
        (:label (:type string))
        (:description (:type string))))))

(define-form ontology-ir-document-field-locale
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name DocumentFieldLocaleIR)
      (:fields
        (:kind (:kind literal) (:values [LocaleField]))
        (:path (:type string))
        (:label (:type string))
        (:description (:type string))
        (:options (:kind array) (:item DocumentFieldOptionIR))))))

(define-form ontology-ir-pdf-direct-mapping
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name PdfDirectMappingIR)
      (:fields
        (:kind (:kind literal) (:values [Direct]) (:required true))
        (:source (:type string))
        (:pdfField (:type string))
        (:transform (:type string))))))

(define-form ontology-ir-pdf-computed-mapping
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name PdfComputedMappingIR)
      (:fields
        (:kind (:kind literal) (:values [Computed computed]) (:required true))
        (:expr (:type ExecutableRuntimeExpr))
        (:pdfField (:type string))
        (:transform (:type string))))))

(define-form ontology-ir-pdf-switch-assignment
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name PdfSwitchAssignmentIR)
      (:fields
        (:kind (:kind literal) (:values [Set set]))
        (:pdfField (:type string))
        (:value (:kind union) (:variants [string boolean number]))))))

(define-form ontology-ir-pdf-switch-case
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name PdfSwitchCaseIR)
      (:fields
        (:kind (:kind literal) (:values [Case case]))
        (:when (:type string))
        (:assignments (:kind array) (:item PdfSwitchAssignmentIR))))))

(define-form ontology-ir-pdf-switch-mapping
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name PdfSwitchMappingIR)
      (:fields
        (:kind (:kind literal) (:values [Switch switch]) (:required true))
        (:source (:type string))
        (:cases (:kind array) (:item PdfSwitchCaseIR))))))

(define-form ontology-ir-pdf-mapping-entry
  (:phase meta)
  (:extensions
    (:protocol/union
      (:name PdfMappingEntryIR)
      (:schema-name PdfMappingEntryIRSchema)
      (:members
        (:direct (:ref PdfDirectMappingIR))
        (:computed (:ref PdfComputedMappingIR))
        (:switch (:ref PdfSwitchMappingIR))))))

(define-form ontology-ir-system-attribute
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name SystemAttributeIR)
      (:fields
        (:kind (:kind literal) (:values [SystemAttribute]) (:required true))
        (:name (:type string) (:required true))
        (:doc (:type string))
        (:valueType (:type RuntimeExpr))
        (:required (:kind union) (:variants [boolean string]))
        (:enum (:kind array) (:item string))))))

(define-form ontology-ir-entity
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name EntityIR)
      (:fields
        (:kind (:kind literal) (:values [Entity]) (:required true))
        (:name (:type string) (:required true))
        (:doc (:type string))
        (:role (:type string))
        (:idPattern (:type string))
        (:fields (:kind array) (:item EntityFieldIR) (:required true))))))

(define-form ontology-ir-meta-entity
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name MetaEntityIR)
      (:fields
        (:kind (:kind literal) (:values [MetaEntity]) (:required true))
        (:name (:type string) (:required true))
        (:doc (:type string))
        (:role (:type string))
        (:idPattern (:type string))
        (:fields (:kind array) (:item EntityFieldIR) (:required true))))))

(define-form ontology-ir-relation
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name RelationIR)
      (:fields
        (:kind (:kind literal) (:values [Relation]) (:required true))
        (:name (:type string) (:required true))
        (:source (:type string) (:required true))
        (:target (:type string) (:required true))
        (:fields (:kind array) (:item EntityFieldIR))))))

(define-form ontology-ir-record
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name RecordIR)
      (:fields
        (:kind (:kind literal) (:values [Record]) (:required true))
        (:id (:type string) (:required true))
        (:entity (:type string) (:required true))
        (:fields (:kind record) (:value RuntimeExpr))))))

(define-form ontology-ir-link-field
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name LinkFieldIR)
      (:fields
        (:name (:type string) (:required true))
        (:value (:type RuntimeExpr) (:required true))))))

(define-form ontology-ir-link
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name LinkIR)
      (:fields
        (:kind (:kind literal) (:values [Link]) (:required true))
        (:relation (:type string) (:required true))
        (:source (:type string) (:required true))
        (:target (:type string) (:required true))
        (:sourceId (:type string))
        (:targetId (:type string))
        (:fields (:kind array) (:item LinkFieldIR))))))

(define-form ontology-ir-query
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryIR)
      (:fields
        (:kind (:kind literal) (:values [Query]) (:required true))
        (:name (:type string) (:required true))
        (:from (:type string) (:required true))
        (:fromRef (:type RuntimeExpr))
        (:where (:type RuntimeExpr))
        (:datalog (:type RuntimeExpr))
        (:select (:kind array) (:item string))))))

(define-form ontology-ir-query-ref
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryRefIR)
      (:fields
        (:kind (:kind literal) (:values [Query]) (:required true))
        (:name (:type string) (:required true))))))

(define-form ontology-ir-query-preset-param
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryPresetParamIR)
      (:fields
        (:name (:type string) (:required true))
        (:value (:type RuntimeExpr) (:required true))))))

(define-form ontology-ir-query-preset
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name QueryPresetIR)
      (:fields
        (:kind (:kind literal) (:values [QueryPreset]) (:required true))
        (:name (:type string) (:required true))
        (:queryRef (:type QueryRefIR) (:required true))
        (:defaults (:kind array) (:item QueryPresetParamIR))
        (:mergePolicy (:kind literal) (:values [caller-overrides preset-overrides]))))))

(define-form ontology-ir-identity-declaration
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name IdentityDeclarationIR)
      (:fields
        (:kind (:kind literal) (:values [IdentityDeclaration]) (:required true))
        (:identityKind (:type IdentityKindIR) (:required true))
        (:name (:type string) (:required true))
        (:description (:type string))
        (:principal (:type string))
        (:member (:type string))
        (:group (:type string))
        (:resource (:type string))
        (:resolver (:type ExecutableRuntimeExpr))))))

(define-form ontology-ir-permission-declaration
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name PermissionDeclarationIR)
      (:fields
        (:kind (:kind literal) (:values [PermissionDeclaration]) (:required true))
        (:name (:type string) (:required true))
        (:principal (:type string) (:required true))
        (:action (:type string) (:required true))
        (:resource (:type string) (:required true))
        (:effect (:kind literal) (:values [allow deny]))
        (:condition (:type ExecutableRuntimeExpr))
        (:description (:type string))))))

(define-form ontology-ir-view
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ViewIR)
      (:fields
        (:kind (:kind literal) (:values [View]) (:required true))
        (:name (:type string) (:required true))
        (:doc (:type string))
        (:query (:type string))
        (:title (:type string))
        (:subject (:type string))
        (:mode (:type string))
        (:emptyState (:type string))
        (:where (:type RuntimeExpr))
        (:defaultSort (:type ViewSortIR))
        (:rowAction (:type RuntimeExpr))
        (:columns (:kind array) (:item ViewColumnIR))
        (:state (:type unknown))
        (:input (:type unknown))
        (:queries (:type unknown))
        (:layout (:type unknown))))))

(define-form ontology-ir-action
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ActionIR)
      (:fields
        (:kind (:kind literal) (:values [Action]) (:required true))
        (:name (:type string) (:required true))
        (:doc (:type string))
        (:inputs (:kind array) (:item ActionInputIR) (:required true))
        (:do (:type ExecutableRuntimeExpr))
        (:returns (:type string))))))

(define-form ontology-ir-mutation
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name MutationIR)
      (:fields
        (:kind (:kind literal) (:values [Mutation]) (:required true))
        (:name (:type string) (:required true))
        (:doc (:type string))
        (:inputs (:kind array) (:item ActionInputIR) (:required true))
        (:do (:type ExecutableRuntimeExpr))
        (:returns (:type string))))))

(define-form ontology-ir-constraint-task-assignment
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ConstraintTaskAssignmentIR)
      (:fields
        (:role (:type string) (:required true))
        (:priority (:type string))
        (:title (:type RuntimeExpr))
        (:body (:type RuntimeExpr))))))

(define-form ontology-ir-constraint
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ConstraintIR)
      (:fields
        (:kind (:kind literal) (:values [Constraint]) (:required true))
        (:name (:type string) (:required true))
        (:doc (:type string))
        (:entity (:type string) (:required true))
        (:severity (:type string) (:required true))
        (:description (:type string))
        (:category (:type string))
        (:when (:type RuntimeExpr))
        (:message (:type ExecutableRuntimeExpr))
        (:taskAssignments (:kind array) (:item ConstraintTaskAssignmentIR))
        (:resolutions (:kind array) (:item ResolutionIR))))))

(define-form ontology-ir-process
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name ProcessIR)
      (:fields
        (:kind (:kind literal) (:values [Process]) (:required true))
        (:name (:type string) (:required true))
        (:description (:type string))
        (:trigger (:type TriggerIR))
        (:nodes (:kind array) (:item ProcessNodeIR))
        (:edges (:kind array) (:item ProcessEdgeIR))))))

(define-form ontology-ir-task-input-definition
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name TaskInputDefinitionIR)
      (:fields
        (:name (:type string) (:required true))
        (:type (:type RuntimeExpr))
        (:required (:kind union) (:variants [boolean string]))))))

(define-form ontology-ir-document-ref
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name DocumentRefIR)
      (:fields
        (:kind (:type string) (:required true))
        (:name (:type string) (:required true))))))

(define-form ontology-ir-task-definition
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name TaskDefinitionIR)
      (:fields
        (:kind (:kind literal) (:values [TaskDefinition]) (:required true))
        (:name (:type string) (:required true))
        (:title (:type string) (:required true))
        (:description (:type string))
        (:documentRef (:type DocumentRefIR))
        (:sectionRefs (:kind array) (:item string))
        (:defaultAssignee (:type unknown))
        (:guidanceRef (:type string))
        (:inputs (:kind array) (:item TaskInputDefinitionIR))
        (:scope (:type unknown))))))

(define-form ontology-ir-document
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name DocumentIR)
      (:fields
        (:kind (:kind literal) (:values [Document]) (:required true))
        (:name (:type string) (:required true))
        (:description (:type string))
        (:pages (:kind array) (:item DocumentPageIR))))))

(define-form ontology-ir-document-locale
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name DocumentLocaleIR)
      (:fields
        (:kind (:kind literal) (:values [DocumentLocale]) (:required true))
        (:documentName (:type string))
        (:documentRef (:type RuntimeExpr))
        (:locale (:type string))
        (:roles (:kind array) (:item DocumentRoleLocaleIR))
        (:sections (:kind array) (:item DocumentSectionLocaleIR))
        (:fields (:kind array) (:item DocumentFieldLocaleIR))))))

(define-form ontology-ir-document-localized
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name DocumentLocalizedIR)
      (:fields
        (:kind (:kind literal) (:values [DocumentLocalized]) (:required true))
        (:documentName (:type string))
        (:documentRef (:type RuntimeExpr))
        (:locales (:kind array) (:item string))
        (:defaultLocale (:type string))))))

(define-form ontology-ir-pdf-mapping
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name PdfMappingIR)
      (:fields
        (:kind (:kind literal) (:values [PdfMapping]) (:required true))
        (:name (:type string) (:required true))
        (:displayName (:type string))
        (:description (:type string))
        (:templateBlob (:type string))
        (:documentName (:type string))
        (:documentRef (:type RuntimeExpr))
        (:mappings (:kind array) (:item PdfMappingEntryIR))))))

(define-form ontology-ir-workspace
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name WorkspaceIR)
      (:fields
        (:kind (:kind literal) (:values [Workspace]) (:required true))
        (:name (:type string) (:required true))
        (:title (:type string))
        (:persona (:type string))
        (:subject (:type string))
        (:home (:type string))
        (:views (:kind array) (:item string))))))

(define-form ontology-ir-canonical-ir
  (:phase meta)
  (:extensions
    (:protocol/union
      (:name CanonicalIR)
      (:schema-name CanonicalIRSchema)
      (:members
        (:system-attribute (:ref SystemAttributeIR))
        (:entity (:ref EntityIR))
        (:meta-entity (:ref MetaEntityIR))
        (:relation (:ref RelationIR))
        (:record (:ref RecordIR))
        (:link (:ref LinkIR))
        (:query (:ref QueryIR))
        (:query-preset (:ref QueryPresetIR))
        (:identity-declaration (:ref IdentityDeclarationIR))
        (:permission-declaration (:ref PermissionDeclarationIR))
        (:view (:ref ViewIR))
        (:action (:ref ActionIR))
        (:mutation (:ref MutationIR))
        (:constraint (:ref ConstraintIR))
        (:process (:ref ProcessIR))
        (:task-definition (:ref TaskDefinitionIR))
        (:document (:ref DocumentIR))
        (:document-locale (:ref DocumentLocaleIR))
        (:document-localized (:ref DocumentLocalizedIR))
        (:pdf-mapping (:ref PdfMappingIR))
        (:workspace (:ref WorkspaceIR))))))

(define-form ontology-ir-compiled-declarations
  (:phase meta)
  (:extensions
    (:protocol/object
      (:name CompiledDeclarations)
      (:fields
        (:systemAttributes (:kind array) (:item SystemAttributeIR) (:required true))
        (:entities (:kind array) (:item EntityIR) (:required true))
        (:metaEntities (:kind array) (:item MetaEntityIR) (:required true))
        (:relations (:kind array) (:item RelationIR) (:required true))
        (:records (:kind array) (:item RecordIR) (:required true))
        (:links (:kind array) (:item LinkIR) (:required true))
        (:queries (:kind array) (:item QueryIR) (:required true))
        (:queryPresets (:kind array) (:item QueryPresetIR) (:required true))
        (:identityDeclarations (:kind array) (:item IdentityDeclarationIR) (:required true))
        (:permissionDeclarations (:kind array) (:item PermissionDeclarationIR) (:required true))
        (:views (:kind array) (:item ViewIR) (:required true))
        (:actions (:kind array) (:item ActionIR) (:required true))
        (:mutations (:kind array) (:item MutationIR) (:required true))
        (:constraints (:kind array) (:item ConstraintIR) (:required true))
        (:processes (:kind array) (:item ProcessIR) (:required true))
        (:taskDefinitions (:kind array) (:item TaskDefinitionIR) (:required true))
        (:documents (:kind array) (:item DocumentIR) (:required true))
        (:documentLocales (:kind array) (:item DocumentLocaleIR) (:required true))
        (:documentLocalized (:kind array) (:item DocumentLocalizedIR) (:required true))
        (:pdfMappings (:kind array) (:item PdfMappingIR) (:required true))
        (:workspaces (:kind array) (:item WorkspaceIR) (:required true))))))

(define-form ontology-ir-protocol-module
  (:phase meta)
  (:extensions
    (:protocol/module
      (:name OntologyIR)
      (:imports [
        [CanonicalRuntimeExpr from CanonicalRuntime CanonicalRuntimeExpr]
      ])
      (:objects [
        EntityFieldIR
        ActionInputIR
        ViewColumnIR
        ViewSortIR
        ResolutionInputIR
        ResolutionIR
        TriggerIR
        ProcessNodeInputIR
        ProcessNodeIR
        ProcessGuardIR
        ProcessEdgeIR
        DocumentCompletionIR
        DocumentPageIR
        AttributeBindingIR
        DocumentFieldOptionIR
        DocumentFieldIR
        DocumentRoleLocaleIR
        DocumentSectionLocaleIR
        DocumentFieldLocaleIR
        PdfDirectMappingIR
        PdfComputedMappingIR
        PdfSwitchAssignmentIR
        PdfSwitchCaseIR
        PdfSwitchMappingIR
        SystemAttributeIR
        EntityIR
        MetaEntityIR
        RelationIR
        RecordIR
        LinkFieldIR
        LinkIR
        QueryIR
        QueryRefIR
        QueryPresetParamIR
        QueryPresetIR
        IdentityDeclarationIR
        PermissionDeclarationIR
        ViewIR
        ActionIR
        MutationIR
        ConstraintTaskAssignmentIR
        ConstraintIR
        ProcessIR
        TaskInputDefinitionIR
        DocumentRefIR
        TaskDefinitionIR
        DocumentIR
        DocumentLocaleIR
        DocumentLocalizedIR
        PdfMappingIR
        WorkspaceIR
        CompiledDeclarations
      ])
      (:unions [PdfMappingEntryIR CanonicalIR])
      (:literals [
        {:name AttributeBindingTransformIR
         :values [identity string number boolean date datetime json ref]
         :description "Document attribute binding transform."}
        {:name AttributeBindingCardinalityIR
         :values [one many]
         :description "Document attribute binding cardinality."}
        {:name IdentityKindIR
         :values [role group membership contextual-role]
         :description "Canonical identity declaration kind."}
      ]))))

(define-form canonical-ir-declaration-catalog
  (:phase meta)
  (:extensions
    (:protocol/catalog
      (:name CanonicalIRDeclarations)
      (:entries [
        {:kind SystemAttribute
         :schema SystemAttributeIRSchema
         :collection systemAttributes
         :flatten-order 10
         :index-order 10
         :index-name name}
        {:kind Entity
         :schema EntityIRSchema
         :collection entities
         :flatten-order 30
         :index-order 20
         :index-name name}
        {:kind MetaEntity
         :schema MetaEntityIRSchema
         :collection metaEntities
         :flatten-order 20
         :index-order 30
         :index-name name}
        {:kind Relation
         :schema RelationIRSchema
         :collection relations
         :flatten-order 40
         :index-order 40
         :index-name name}
        {:kind Record
         :schema RecordIRSchema
         :collection records
         :flatten-order 50
         :index-order 50
         :index-name id}
        {:kind Link
         :schema LinkIRSchema
         :collection links
         :flatten-order 60
         :index-order 60
         :index-name link}
        {:kind Query
         :schema QueryIRSchema
         :collection queries
         :flatten-order 70
         :index-order 70
         :index-name name}
        {:kind QueryPreset
         :schema QueryPresetIRSchema
         :collection queryPresets
         :flatten-order 80
         :index-order 80
         :index-name name}
        {:kind IdentityDeclaration
         :schema IdentityDeclarationIRSchema
         :collection identityDeclarations
         :flatten-order 90
         :index-order 90
         :index-name name}
        {:kind PermissionDeclaration
         :schema PermissionDeclarationIRSchema
         :collection permissionDeclarations
         :flatten-order 100
         :index-order 100
         :index-name name}
        {:kind View
         :schema ViewIRSchema
         :collection views
         :flatten-order 110
         :index-order 110
         :index-name name}
        {:kind Action
         :schema ActionIRSchema
         :collection actions
         :flatten-order 120
         :index-order 120
         :index-name name}
        {:kind Mutation
         :schema MutationIRSchema
         :collection mutations
         :flatten-order 130
         :index-order 130
         :index-name name}
        {:kind Constraint
         :schema ConstraintIRSchema
         :collection constraints
         :flatten-order 140
         :index-order 140
         :index-name name}
        {:kind Process
         :schema ProcessIRSchema
         :collection processes
         :flatten-order 150
         :index-order 150
         :index-name name}
        {:kind TaskDefinition
         :schema TaskDefinitionIRSchema
         :collection taskDefinitions
         :flatten-order 160
         :index-order 160
         :index-name name}
        {:kind Document
         :schema DocumentIRSchema
         :collection documents
         :flatten-order 170
         :index-order 170
         :index-name name}
        {:kind DocumentLocale
         :schema DocumentLocaleIRSchema
         :collection documentLocales
         :flatten-order 180
         :index-order 180
         :index-name document-locale}
        {:kind DocumentLocalized
         :schema DocumentLocalizedIRSchema
         :collection documentLocalized
         :flatten-order 190
         :index-order 190
         :index-name document-localized}
        {:kind PdfMapping
         :schema PdfMappingIRSchema
         :collection pdfMappings
         :flatten-order 200
         :index-order 200
         :index-name name}
        {:kind Workspace
         :schema WorkspaceIRSchema
         :collection workspaces
         :flatten-order 210
         :index-order 210
         :index-name name}
      ]))))
