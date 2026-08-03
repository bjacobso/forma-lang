# Processes

```lisp
(export union-authorization-workflow)

;; =============================================================================
;; Labor Relations Ontology - Process
;; =============================================================================

(define-process union-authorization-workflow
  (:description "CBA-triggered union authorization card workflow from placement sync to document routing")
  (:trigger (trigger on-create Placement))
  (:node
    (node evaluate-cba-context
      (:action start-union-authorization-card)
      (:input [placement-id (-> context (get :entityId))])))
  (:node
    (node employee-card
      (:action collect-form)
      (:input [section-ids "employee-authorization"])
      (:input [assignee-type "entity"])))
  (:node
    (node create-executed-document
      (:action submit-union-authorization-card)))
  (:node
    (node downstream-webhook
      (:action emit-card-completed-webhook)))
  (:node
    (node route-document
      (:action mark-document-routed)))
  (:edge (edge evaluate-cba-context employee-card))
  (:edge (edge employee-card create-executed-document))
  (:edge (edge create-executed-document downstream-webhook))
  (:edge (edge downstream-webhook route-document)))
```
