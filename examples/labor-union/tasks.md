# Tasks

```lisp
;; =============================================================================
;; Labor Relations Ontology - Task Definitions
;; =============================================================================

(define-task complete-union-authorization-card
  (:title "Complete Union Authorization Card")
  (:description "Employee reviews prefilled CBA context, acknowledges authorization language, and signs the card.")
  (:document union-authorization-card)
  (:section employee-authorization)
  (:assignee employee)
  (:scope Employee)
  (:input employee Employee (:required true)))

(define-task review-rehire-authorization-policy
  (:title "Review Rehire Authorization Policy")
  (:description "Labor relations reviews whether an existing signed card can be reused or a new card must be executed.")
  (:assignee labor-relations)
  (:scope Employee)
  (:input employee Employee (:required true)))
```
