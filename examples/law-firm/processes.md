# Processes

```lisp
(export client-onboarding matter-opening document-follow-up)

;; =============================================================================
;; Law Firm Backoffice Ontology - Processes
;; =============================================================================

;; ---------------------------------------------------------------------------
;; Client Onboarding Process
;; ---------------------------------------------------------------------------
;; When a new client is created, collect intake, run conflicts, prepare the
;; engagement letter, and open the matter only after the preconditions clear.

(define-process client-onboarding
  (:description "New client onboarding: intake packet, conflict check, engagement letter, and matter opening")
  (:trigger (trigger on-create Client))
  (:node
    (node create-intake
      (:action create-intake-packet)
      (:input [entity-id (-> context (get :entityId))])))
  (:node
    (node run-conflicts
      (:action run-conflict-check)
      (:input [entity-id (-> context (get :entityId))])))
  (:node
    (node notify-attorney
      (:action send-notification)
      (:input [to (-> context (get :attorneyEmail))])
      (:input [subject "New client intake is ready for conflict review"])))
  (:node
    (node open-matter-shell
      (:action open-matter)
      (:input [entity-id (-> context (get :entityId))])))
  (:edge (edge create-intake run-conflicts))
  (:edge (edge run-conflicts notify-attorney))
  (:edge (edge notify-attorney open-matter-shell)))

;; ---------------------------------------------------------------------------
;; Matter Opening Process
;; ---------------------------------------------------------------------------
;; When a matter opens, create the engagement letter, assign opening tasks,
;; and request the client's initial documents.

(define-process matter-opening
  (:description "Matter opening: engagement letter, opening task, and initial document request")
  (:trigger (trigger on-create Matter))
  (:node
    (node engagement-letter
      (:action generate-engagement-letter)
      (:input [entity-id (-> context (get :entityId))])))
  (:node
    (node opening-task
      (:action add-case-task)
      (:input [entity-id (-> context (get :entityId))])))
  (:node
    (node initial-documents
      (:action request-documents)
      (:input [entity-id (-> context (get :entityId))])))
  (:node
    (node activate
      (:action activate-matter)
      (:input [entity-id (-> context (get :entityId))])))
  (:edge (edge engagement-letter opening-task))
  (:edge (edge opening-task initial-documents))
  (:edge (edge initial-documents activate)))

;; ---------------------------------------------------------------------------
;; Document Follow-Up Process
;; ---------------------------------------------------------------------------
;; Overdue document requests create a structured escalation path so the firm can
;; separate routine reminders from attorney intervention.

(define-process document-follow-up
  (:description "Overdue document request follow-up and attorney escalation")
  (:trigger (trigger on-create DocumentRequest))
  (:node
    (node reminder
      (:action send-notification)
      (:input [subject "Document request reminder"])))
  (:node
    (node escalation-check
      (:action escalate-to-attorney)
      (:fan-out first)))
  (:edge (edge reminder escalation-check)))
```
