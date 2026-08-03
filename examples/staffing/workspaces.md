# Workspaces

```lisp
(export onboarding-operations account-portfolio employee-profile staffing-api-access)

;; =============================================================================
;; Staffing Agency Ontology - Workspaces
;; =============================================================================
;;
;; Flat workspace declarations. The runtime auto-generates navigation from the
;; workspace view list using each view's title as the nav label.
;;

(define-workspace onboarding-operations
  (:title "Onboarding Operations")
  (:persona "Onboarding Coordinator")
  (:subject session)
  (:home onboarding-dashboard)
  (:view onboarding-dashboard)
  (:view onboarding-tracker)
  (:view employer-inbox)
  (:view runtime-task-queue-view)
  (:view onboarding-workers-view)
  (:view employer-review-queue-view)
  (:view active-violations-view)
  (:view resolved-violations-view)
  (:view i9-submission-mapping-view)
  (:view runtime-task-detail-native)
  (:view violation-detail-native)
  (:view generated-documents-view)
  (:view pending-documents-view))

(define-workspace account-portfolio
  (:title "Account Portfolio")
  (:persona "Account Manager")
  (:subject optional)
  (:home active-client-portfolio-view)
  (:view active-client-portfolio-view)
  (:view profitable-active-placements))

(define-workspace employee-profile
  (:title "Employee Profile")
  (:persona "Employee")
  (:subject required)
  (:home employee-profile-dashboard)
  (:view employee-profile-dashboard))

(define-workspace staffing-api-access
  (:title "Staffing API Access")
  (:persona "Integration Developer")
  (:subject session)
  (:home employees-rest-resource-view)
  (:view employees-rest-resource-view)
  (:view clients-rest-resource-view))
```
