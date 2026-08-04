# Workspaces

```lisp
(export intake-coordinator managing-attorney)

;; =============================================================================
;; Law Firm Backoffice Ontology - Workspaces
;; =============================================================================

(define-workspace intake-coordinator
  (:title "Intake Coordinator")
  (:persona "Intake Coordinator")
  (:subject session)
  (:home backoffice-dashboard)
  (:view backoffice-dashboard)
  (:view client-onboarding-view)
  (:view matter-management-view)
  (:view document-requests-view)
  (:view billing-review-view)
  (:view runtime-task-detail-native))

(define-workspace managing-attorney
  (:title "Managing Attorney")
  (:persona "Attorney")
  (:subject optional)
  (:home managing-partner-summary)
  (:view managing-partner-summary)
  (:view client-portfolio-view)
  (:view high-risk-clients-view)
  (:view matter-management-view))
```
