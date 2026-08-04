# Queries

```lisp
(export covered-placements pending-authorization-tasks completed-authorization-documents active-cba-templates all-cba-templates cbas-needing-review rehire-review-cases integration-events routing-exceptions employees-in-preboarding)

;; =============================================================================
;; Labor Relations Ontology - Queries
;; =============================================================================

(define-query covered-placements
  (:from Placement)
  (:where
    (and
      (!= (get it :placement/status) "cancelled")
      (!= (get it :placement/cba-id) "")))
  (:select [placement/start-date placement/status placement/source-system placement/cba-id placement/employee placement/position]))

(define-query pending-authorization-tasks
  (:from UnionAuthorizationTask)
  (:where
    (and
      (!= (get it :unionauthtask/status) "completed")
      (!= (get it :unionauthtask/status) "cancelled")))
  (:select [unionauthtask/title unionauthtask/status unionauthtask/priority unionauthtask/assignee-role unionauthtask/due-date unionauthtask/template-version]))

(define-query completed-authorization-documents
  (:from ExecutedAuthorizationDocument)
  (:where (= (get it :executeddocument/status) "available"))
  (:select [executeddocument/name executeddocument/signed-at executeddocument/template-version executeddocument/routing-status executeddocument/pdf-reference]))

(define-query active-cba-templates
  (:from AuthorizationCardTemplate)
  (:where (= (get it :authcardtemplate/status) "active"))
  (:select [authcardtemplate/template-id authcardtemplate/name authcardtemplate/version authcardtemplate/source-system authcardtemplate/form-mode]))

(define-query all-cba-templates
  (:from AuthorizationCardTemplate)
  (:select [authcardtemplate/template-id authcardtemplate/name authcardtemplate/version authcardtemplate/status authcardtemplate/form-mode]))

(define-query cbas-needing-review
  (:from CollectiveBargainingAgreement)
  (:where (!= (get it :cba/status) "active"))
  (:select [cba/identifier cba/union-name cba/local-label cba/status cba/geographic-scope]))

(define-query rehire-review-cases
  (:from Employee)
  (:where (= (get it :employee/cba-id) "CBA-HSP-311-2026"))
  (:select [employee/first-name employee/last-name employee/status employee/global-hr-id employee/cba-id employee/union-card-signed]))

(define-query integration-events
  (:from IntegrationEvent)
  (:select [integrationevent/event-type integrationevent/status integrationevent/target-system integrationevent/emitted-at integrationevent/payload-summary]))

(define-query routing-exceptions
  (:from ExecutedAuthorizationDocument)
  (:where (!= (get it :executeddocument/routing-status) "routed"))
  (:select [executeddocument/name executeddocument/status executeddocument/routing-status executeddocument/pdf-reference]))

(define-query employees-in-preboarding
  (:from Employee)
  (:where (= (get it :employee/status) "preboarding"))
  (:select [employee/first-name employee/last-name employee/email employee/global-hr-id employee/cba-id employee/rehire-indicator]))
```
