; system.lisp
; -----------------------------------------------------------------------------
; Unified platform self-description.
;
; This file is the canonical intrinsic catalog for cross-cutting system
; attributes, bootstrap schema entities, platform metadata entities, and
; runtime-owned record types.
; -----------------------------------------------------------------------------

; =============================================================================
; SECTION 1 — SYSTEM ATTRIBUTES
; =============================================================================

(define-system-attribute _schema/type
  (:doc "Entity type discriminant for platform-owned entities.")
  (:value-type String)
  (:required true))

(define-system-attribute _schema/created-at
  (:doc "Creation timestamp in epoch milliseconds.")
  (:value-type Number))

(define-system-attribute _schema/updated-at
  (:doc "Last update timestamp in epoch milliseconds.")
  (:value-type Number))

(define-system-attribute _schema/created-by
  (:doc "Actor or principal responsible for creation.")
  (:value-type String))

(define-system-attribute _schema/version
  (:doc "Version marker for versioned system definitions.")
  (:value-type Number))

(define-system-attribute _schema/enabled
  (:doc "Soft-delete / enablement flag for platform-owned entities.")
  (:value-type Boolean))

(define-system-attribute _meta/role
  (:doc "Architectural role of a platform-owned entity.")
  (:value-type String)
  (:required true)
  (:enum ["schema-definition" "system-metadata" "runtime-record"]))

; =============================================================================
; SECTION 2 — META-SCHEMA
; =============================================================================

(define-meta-entity EntityType
  (:doc "Decomposed entity type definition stored as first-class triples.")
  (:role "schema-definition")
  (:id-pattern "_schema/entity-type/{name}/v{version}")
  (:field [_type/name String {:required true :indexed true}])
  (:field [_type/version Number {:required true :indexed true}])
  (:field [_type/description String])
  (:field [_type/plural String]))

(define-meta-entity AttributeDefinition
  (:doc "Attribute definition belonging to an EntityType.")
  (:role "schema-definition")
  (:id-pattern "{parent}/attr/{name}")
  (:field [_attr/name String {:required true}])
  (:field [_attr/value-type String {:required true}])
  (:field [_attr/required Boolean])
  (:field [_attr/indexed Boolean])
  (:field [_attr/unique Boolean])
  (:field [_attr/default String])
  (:field [_attr/description String])
  (:field [_attr/belongs-to String {:required true :indexed true}])
  (:field [_attr/validation-min Number])
  (:field [_attr/validation-max Number])
  (:field [_attr/validation-pattern String])
  (:field [_attr/validation-format String])
  (:field [_attr/validation-enum Json])
  (:field [_attr/validation-message String]))

(define-meta-entity RelationshipDefinition
  (:doc "Relationship definition belonging to an EntityType.")
  (:role "schema-definition")
  (:id-pattern "{parent}/rel/{name}")
  (:field [_rel/name String {:required true}])
  (:field [_rel/target-type String {:required true}])
  (:field [_rel/cardinality String])
  (:field [_rel/required Boolean])
  (:field [_rel/description String])
  (:field [_rel/inverse String])
  (:field [_rel/belongs-to String {:required true :indexed true}]))

; =============================================================================
; SECTION 3 — SCHEMA / SYSTEM METADATA ENTITY TYPES
; =============================================================================

(define-entity AttributeType
  (:doc "Registry entry describing a known attribute name and its metadata.")
  (:role "schema-definition")
  (:id-pattern "_meta/attribute:{attributeName}")
  (:field [_meta/attribute-name String {:required true :indexed true}])
  (:field [_meta/display-name String])
  (:field [_meta/value-type String {:required true}])
  (:field [_meta/category String {:required true}])
  (:field [_meta/description String])
  (:field [_meta/validation Json])
  (:field [_meta/deprecated Boolean])
  (:field [_meta/deprecated-at Number]))

(define-entity RelationshipType
  (:doc "Versioned relationship type definition stored by the runtime registry.")
  (:role "schema-definition")
  (:id-pattern "_schema/relationship-type/{name}/v{version}")
  (:field [_schema/relationship-type-name String {:required true :indexed true}])
  (:field [_meta/version Number {:required true :indexed true}])
  (:field [_meta/source-type String {:required true}])
  (:field [_meta/target-type String {:required true}])
  (:field [_meta/definition Json {:required true}]))

(define-entity SavedQuery
  (:doc "Versioned saved Datalog query definition.")
  (:role "system-metadata")
  (:id-pattern "_schema/query/{name}/v{version}")
  (:field [_schema/query-name String {:required true :indexed true}])
  (:field [_meta/version Number {:required true :indexed true}])
  (:field [_meta/display-name String {:required true}])
  (:field [_meta/definition Json {:required true}])
  (:field [_meta/tags Json]))

(define-entity View
  (:doc "Persisted declarative UI view definition.")
  (:role "system-metadata")
  (:id-pattern "_schema/view/{name}")
  (:field [view:name String {:required true :indexed true}])
  (:field [view:definition Json {:required true}]))

(define-entity Workspace
  (:doc "Named operational workspace definition.")
  (:role "system-metadata")
  (:id-pattern "_schema/workspace/{name}")
  (:field [workspace:name String {:required true :indexed true}])
  (:field [workspace:definition Json {:required true}]))

(define-entity Constraint
  (:doc "Stored constraint definition plus queryable selectors.")
  (:role "system-metadata")
  (:id-pattern "_schema/constraint/{ulid}")
  (:field [_schema/constraint-name String {:required true :indexed true}])
  (:field [_meta/entity-type String {:required true :indexed true}])
  (:field [_meta/severity String {:required true :indexed true}])
  (:field [_meta/category String])
  (:field [_schema/constraint Json {:required true}]))

(define-entity ActionDefinition
  (:doc "Versioned action definition available to processes and UI.")
  (:role "system-metadata")
  (:id-pattern "_action/{entityType}/{name}/v{version}")
  (:field [action/name String {:required true :indexed true}])
  (:field [action/object-type String {:required true :indexed true}])
  (:field [action/version Number {:required true :indexed true}])
  (:field [action/definition Json {:required true}]))

(define-entity DocumentDefinition
  (:doc "Structured document template definition.")
  (:role "system-metadata")
  (:id-pattern "document-definition:{ulid}")
  (:field [document-definition:name String {:required true :indexed true}])
  (:field [document-definition:definition Json {:required true}])
  (:field [document-definition:translations Json])
  (:field [document-definition:source-ir Json]))

(define-entity Process
  (:doc "Versioned workflow/process definition.")
  (:role "system-metadata")
  (:id-pattern "_process/{name}/v{version}")
  (:field [process/name String {:required true :indexed true}])
  (:field [process/version Number {:required true :indexed true}])
  (:field [process/definition Json {:required true}]))

(define-entity TaskDefinition
  (:doc "Reusable ontology-authored task definition.")
  (:role "system-metadata")
  (:id-pattern "_task-definition/{name}/v{version}")
  (:field [task-definition/name String {:required true :indexed true}])
  (:field [task-definition/title String {:required true}])
  (:field [task-definition/description String])
  (:field [task-definition/document-ref String])
  (:field [task-definition/section-refs Json])
  (:field [task-definition/default-assignee Json])
  (:field [task-definition/guidance-ref String])
  (:field [task-definition/inputs Json])
  (:field [task-definition/scope Json])
  (:field [task-definition/version Number {:required true :indexed true}]))

(define-entity PdfMapping
  (:doc "Named PDF field-mapping definition.")
  (:role "system-metadata")
  (:id-pattern "pdf-mapping:{name}")
  (:field [pdf-mapping/name String {:required true :indexed true}])
  (:field [pdf-mapping/definition Json {:required true}]))

; =============================================================================
; SECTION 4 — RUNTIME RECORDS
; =============================================================================

(define-entity Task
  (:role "runtime-record")
  (:id-pattern "_task/{ulid}")
  (:field [task/title String {:required true}])
  (:field [task/description String])
  (:field [task/type String {:required true}])
  (:field [task/status String {:required true}])
  (:field [task/priority String {:required true}])
  (:field [task/due-date Number])
  (:field [task/reminder-date Number])
  (:field [task/tags Json])
  (:field [task/metadata Json])
  (:field [task/version Number])
  (:field [task/created-at Number])
  (:field [task/created-by String])
  (:field [task/updated-at Number])
  (:field [task/completed-at Number])
  (:field [task/completed-by String])
  (:field [task/resolution String])
  (:field [task/assigned-to String])
  (:field [task/assigned-role String])
  (:field [task/assigned-team String])
  (:field [task/assigned-at Number])
  (:field [task/assigned-by String])
  (:field [task/entity-id String])
  (:field [task/entity-type String])
  (:field [task/violation-id String])
  (:field [task/constraint-id String])
  (:field [task/parent-task-id String])
  (:field [task/related-task-ids Json])
  (:field [task/completion-type String])
  (:field [task/completion-document-ref String])
  (:field [task/completion-document-instance-ref String])
  (:field [task/completion-section-refs Json])
  (:field [task/completion-outcomes Json])
  (:field [task/completion-view-spec Json]))

(define-entity EffectExecution
  (:doc "Audit receipt for a host-executed runtime effect.")
  (:role "runtime-record")
  (:id-pattern "_effect-execution/{ulid}")
  (:field [effect-execution/effect-kind String {:required true :indexed true}])
  (:field [effect-execution/owner-kind String {:required true :indexed true}])
  (:field [effect-execution/owner-id String {:required true :indexed true}])
  (:field [effect-execution/status String {:required true :indexed true}])
  (:field [effect-execution/input Json])
  (:field [effect-execution/output Json])
  (:field [effect-execution/error Json])
  (:field [effect-execution/started-at Number {:required true :indexed true}])
  (:field [effect-execution/completed-at Number {:indexed true}]))

(define-entity Violation
  (:role "runtime-record")
  (:id-pattern "_violation/{ulid}")
  (:field [violation/constraint-id String {:required true}])
  (:field [violation/constraint-name String {:required true}])
  (:field [violation/entity-id String {:required true}])
  (:field [violation/entity-type String {:required true}])
  (:field [violation/severity String {:required true}])
  (:field [violation/message String {:required true}])
  (:field [violation/status String {:required true}])
  (:field [violation/detected-at Number {:required true}])
  (:field [violation/status-changed-at Number])
  (:field [violation/status-changed-by String])
  (:field [violation/notes String])
  (:field [violation/resolution-action-id String])
  (:field [violation/task-id String])
  (:field [violation/bindings Json]))

(define-entity DocumentInstance
  (:role "runtime-record")
  (:id-pattern "document-instance:{ulid}")
  (:field [document-instance/document-id String {:required true}])
  (:field [document-instance/entity-id String {:required true}])
  (:field [document-instance/entity-type String {:required true}])
  (:field [document-instance/status String {:required true}])
  (:field [document-instance/due-date Number])
  (:field [document-instance/completed-at Number])
  (:field [document-instance/completed-sections Json])
  (:field [document-instance/data Json])
  (:field [document-instance/context Json])
  (:field [document-instance/assignments Json])
  (:field [document-instance/created-at Number {:required true}]))

(define-entity SectionSubmission
  (:role "runtime-record")
  (:id-pattern "document-submission:{ulid}")
  (:field [document-section-submission/instance-id String {:required true}])
  (:field [document-section-submission/section-id String {:required true}])
  (:field [document-section-submission/submitted-by String {:required true}])
  (:field [document-section-submission/submitted-at Number {:required true}])
  (:field [document-section-submission/data Json {:required true}])
  (:field [document-section-submission/signature String]))

(define-entity PendingSection
  (:role "runtime-record")
  (:id-pattern "pending-section:{instanceId}:{sectionId}")
  (:field [pending-section/instance-id String {:required true}])
  (:field [pending-section/section-id String {:required true}])
  (:field [pending-section/section-title String {:required true}])
  (:field [pending-section/document-name String {:required true}])
  (:field [pending-section/document-id String {:required true}])
  (:field [pending-section/entity-id String {:required true}])
  (:field [pending-section/entity-type String {:required true}])
  (:field [pending-section/assigned-entity-id String])
  (:field [pending-section/assigned-entity-type String])
  (:field [pending-section/role String])
  (:field [pending-section/due-date Number])
  (:field [pending-section/is-blocked Boolean {:required true}])
  (:field [pending-section/blocked-by String])
  (:field [pending-section/status String {:required true}]))

(define-entity ActionExecution
  (:role "runtime-record")
  (:id-pattern "_action-exec:{ulid}")
  (:field [exec/action-id String {:required true}])
  (:field [exec/action-name String {:required true}])
  (:field [exec/action-version Number {:required true}])
  (:field [exec/entity-type String {:required true}])
  (:field [exec/target-entity String {:required true}])
  (:field [exec/parameters Json {:required true}])
  (:field [exec/status String {:required true}])
  (:field [exec/task-id String])
  (:field [exec/result Json])
  (:field [exec/created-by String])
  (:field [exec/created-at Number])
  (:field [exec/completed-at Number])
  (:field [exec/completed-by String])
  (:field [exec/rejection-reason String]))

(define-entity ProcessRun
  (:role "runtime-record")
  (:id-pattern "_process-inst:{ulid}")
  (:field [process-instance/definition-id String {:required true}])
  (:field [process-instance/status String {:required true}])
  (:field [process-instance/triggered-at Number {:required true}])
  (:field [process-instance/triggered-by String {:required true}])
  (:field [process-instance/entity-id String])
  (:field [process-instance/entity-type String])
  (:field [process-instance/context Json])
  (:field [process-instance/completed-at Number])
  (:field [process-instance/error String]))

(define-entity NodeExecution
  (:role "runtime-record")
  (:id-pattern "_node-exec:{instanceId}:{nodeId}")
  (:field [node-exec/instance-id String {:required true}])
  (:field [node-exec/node-id String {:required true}])
  (:field [node-exec/status String {:required true}])
  (:field [node-exec/started-at Number])
  (:field [node-exec/completed-at Number])
  (:field [node-exec/output Json])
  (:field [node-exec/error String])
  (:field [node-exec/wake-at Number])
  (:field [node-exec/task-ref String]))

(define-entity IntegrationResult
  (:role "runtime-record")
  (:id-pattern "integration:{ulid}")
  (:field [integration/document-instance-id String {:required true :indexed true}])
  (:field [integration/section-id String {:required true :indexed true}])
  (:field [integration/adapter-type String {:required true}])
  (:field [integration/status String {:required true :indexed true}])
  (:field [integration/request-id String])
  (:field [integration/result Json])
  (:field [integration/error String])
  (:field [integration/definition Json {:required true}]))

(define-entity Notification
  (:role "runtime-record")
  (:id-pattern "_notif:{ulid}")
  (:field [notification/handler String {:required true}])
  (:field [notification/status String {:required true}])
  (:field [notification/entity String])
  (:field [notification/input Json]))

(define-entity PdfFillResult
  (:role "runtime-record")
  (:id-pattern "pdf-fill/{ulid}")
  (:field [pdf-fill/mapping-name String {:required true}])
  (:field [pdf-fill/document-submission-id String])
  (:field [pdf-fill/entity-id String])
  (:field [pdf-fill/output-blob-hash String {:required true}])
  (:field [pdf-fill/output-filename String {:required true}])
  (:field [pdf-fill/filled-at Number {:required true}])
  (:field [pdf-fill/unmapped-fields Json]))
