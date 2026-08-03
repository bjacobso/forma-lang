# Queries

```lisp
(export onboarding-employees active-employees active-placements profitable-placements policy-coverage active-clients employees-rest-resource clients-rest-resource employer-review-tasks generated-documents pending-documents employer-pending-tasks onboarding-with-ids onboarding-metrics open-runtime-tasks active-violations resolved-violations)

;; =============================================================================
;; Staffing Agency Ontology - Canonical Queries
;; =============================================================================
;;
;; Canonical noun-form queries derived from the staffing example, limited to the
;; current compiler's single-entity query surface.
;;

(define-query onboarding-employees
  (:from Employee)
  (:where (= (get it :employee/status) "onboarding"))
  (:select [employee/first-name employee/last-name employee/hire-date]))

(define-query active-employees
  (:from Employee)
  (:where (= (get it :employee/status) "active"))
  (:select [employee/first-name employee/last-name employee/hire-date]))

(define-query active-placements
  (:from Placement)
  (:where (= (get it :placement/status) "active"))
  (:select [placement/pay-rate placement/bill-rate placement/status]))

(define-query profitable-placements
  (:from Placement)
  (:where
    (and
      (= (get it :placement/status) "active")
      (> (get it :placement/bill-rate) (get it :placement/pay-rate))))
  (:select [placement/pay-rate placement/bill-rate placement/status]))

(define-query policy-coverage
  (:from Policy)
  (:where (= (get it :policy/status) "active"))
  (:select [policy/name policy/status]))

(define-query active-clients
  (:from Client)
  (:where (= (get it :client/status) "active"))
  (:select [client/name client/industry client/email client/status]))

(define-query employees-rest-resource
  (:from Employee)
  (:select [employee/first-name employee/last-name employee/email employee/status employee/hire-date]))

(define-query clients-rest-resource
  (:from Client)
  (:select [client/name client/industry client/email client/status]))

(define-query employer-review-tasks
  (:from Task)
  (:where
    (and
      (= (get it :task/assigned-role) "employer")
      (= (get it :task/entity-type) "Employee")
      (= (get it :task/status) "pending")))
  (:select
    [task/title
     task/priority
     task/status
     task/due-date
     task/completion-document-ref]))

(define-query generated-documents
  (:from Document)
  (:where (= (get it :document/status) "generated"))
  (:select [document/name document/type document/status document/created-at]))

(define-query pending-documents
  (:from Document)
  (:where (= (get it :document/status) "pending"))
  (:select [document/name document/type document/status document/created-at]))

(define-query employer-pending-tasks
  (:from Task)
  (:where
    (and
      (= (get it :task/assigned-role) "employer")
      (= (get it :task/entity-type) "Employee")
      (= (get it :task/status) "pending")))
  (:select
    [task/title
     task/status
     task/priority
     task/due-date
     task/completion-document-ref]))

(define-query onboarding-with-ids
  (:from Employee)
  (:where (= (get it :employee/status) "onboarding"))
  (:select [employee/first-name employee/last-name employee/hire-date employee/status]))

(define-query onboarding-metrics
  (:from Employee)
  (:where (= (get it :employee/status) "onboarding"))
  (:select [employee/first-name employee/last-name employee/status]))

(define-query open-runtime-tasks
  (:from Task)
  (:where
    (and
      (= (get it :task/status) "pending")
      (= (get it :task/entity-type) "Employee")))
  (:select
    [task/title
     task/status
     task/priority
     task/entity-id
     task/completion-document-ref
     task/due-date]))

(define-query active-violations
  (:from Violation)
  (:where (= (get it :violation/status) "open"))
  (:select
    [violation/constraint-name
     violation/severity
     violation/message
     violation/entity-id
     violation/task-id
     violation/detected-at]))

(define-query resolved-violations
  (:from Violation)
  (:where (= (get it :violation/status) "resolved"))
  (:select
    [violation/constraint-name
     violation/severity
     violation/message
     violation/entity-id
     violation/task-id
     violation/detected-at
     violation/status-changed-at
     violation/status-changed-by]))
```
