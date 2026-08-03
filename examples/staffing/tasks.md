# Tasks

```lisp
;; =============================================================================
;; Staffing Agency Ontology - Reusable Task Definitions
;; =============================================================================
;;
;; These task definitions mirror the runtime I-9 tasks created by the onboarding
;; actions. They give the ontology catalog a stable task-definition surface while
;; the existing action flow continues to create concrete task instances.
;;

(define-task collect-i9-section-1
  (:title "I-9 Section 1 - Employee Information")
  (:description "Employee completes identity, contact, and work authorization information.")
  (:document i-9-employment-eligibility)
  (:section employee-information)
  (:assignee employee)
  (:scope Employee)
  (:input employee Employee (:required true)))

(define-task review-i9-section-2
  (:title "I-9 Section 2 - Employer Review")
  (:description "Employer reviews identity and work authorization documents.")
  (:document i-9-employment-eligibility)
  (:section employer-review)
  (:assignee employer)
  (:scope Employee)
  (:input employee Employee (:required true)))
```
