# Workspaces

```lisp
(export labor-relations-operations employee-card-experience integration-monitor)

;; =============================================================================
;; Labor Relations Ontology - Workspaces
;; =============================================================================

(define-workspace labor-relations-operations
  (:title "Labor Relations Operations")
  (:persona "Labor Relations Coordinator")
  (:subject session)
  (:home lr-dashboard)
  (:view lr-dashboard)
  (:view covered-placement-queue)
  (:view authorization-task-queue)
  (:view cba-template-library)
  (:view rehire-review)
  (:view document-routing-monitor)
  (:view integration-events-view))

(define-workspace employee-card-experience
  (:title "Employee Card Experience")
  (:persona "Employee")
  (:subject required)
  (:home employee-card-dashboard)
  (:view employee-card-dashboard))

(define-workspace integration-monitor
  (:title "Integration Monitor")
  (:persona "Integration Operator")
  (:subject session)
  (:home integration-events-view)
  (:view integration-events-view)
  (:view document-routing-monitor)
  (:view cba-template-library))
```
