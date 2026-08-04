# Process

```lisp
(export employee-onboarding)

;; =============================================================================
;; Staffing Agency Ontology - Canonical Process
;; =============================================================================
;;
;; Canonical process form for the employee onboarding DAG.
;;

(define-process employee-onboarding
  (:description "Full onboarding compliance process: parallel document collection, employer review, background check, and activation")
  (:trigger (trigger on-create Employee))
  (:node
    (node generate-tasks
      (:action generate-onboarding-tasks)
      (:input [entity-id (-> context (get :entityId))])))
  (:node
    (node employee-documents-start))
  (:node
    (node i9-section-1
      (:action collect-form)
      (:input [section-ids "employee-information"])
      (:input [assignee-type "entity"])))
  (:node
    (node w4-form
      (:action collect-form)
      (:input [section-ids "employee-tax-info"])
      (:input [assignee-type "entity"])))
  (:node
    (node direct-deposit
      (:action collect-form)
      (:input [section-ids "bank-information"])
      (:input [assignee-type "entity"])))
  (:node
    (node handbook-ack
      (:action collect-form)
      (:input [section-ids "handbook-acknowledgment"])
      (:input [assignee-type "entity"])))
  (:node
    (node employee-documents-end
      (:join all)))
  (:node
    (node employer-review-start))
  (:node
    (node i9-section-2
      (:action collect-form)
      (:input [section-ids "employer-review"])
      (:input [assignee-type "role"])
      (:input [assignee-role "hr-verifier"])))
  (:node
    (node initiate-bgc
      (:action create-bgc-task)
      (:input [entity-id (-> context (get :entityId))])))
  (:node
    (node generate-i9-pdf
      (:action generate-i9-pdf)
      (:input [entity-id (-> context (get :entityId))])))
  (:node
    (node employer-review-end
      (:join all)))
  (:node
    (node all-complete
      (:action evaluate-condition)
      (:fan-out first)))
  (:node
    (node activate-employee
      (:action mark-compliant)
      (:input [entity-id (-> context (get :entityId))])))
  (:node
    (node send-reminder
      (:action send-notification)
      (:input [to (-> context (get :employeeEmail))])
      (:input [subject "Onboarding reminder: please complete your remaining tasks"])))
  (:edge (edge generate-tasks employee-documents-start))
  (:edge (edge employee-documents-start i9-section-1))
  (:edge (edge employee-documents-start w4-form))
  (:edge (edge employee-documents-start direct-deposit))
  (:edge (edge employee-documents-start handbook-ack))
  (:edge (edge i9-section-1 employee-documents-end))
  (:edge (edge w4-form employee-documents-end))
  (:edge (edge direct-deposit employee-documents-end))
  (:edge (edge handbook-ack employee-documents-end))
  (:edge (edge employee-documents-end employer-review-start))
  (:edge (edge employer-review-start i9-section-2))
  (:edge (edge employer-review-start initiate-bgc))
  (:edge (edge i9-section-2 generate-i9-pdf))
  (:edge (edge generate-i9-pdf employer-review-end))
  (:edge (edge initiate-bgc employer-review-end))
  (:edge (edge employer-review-end all-complete))
  (:edge
    (edge all-complete activate-employee
      (:guard (guard expr (-> outputs (get :all-complete) (get :action))))))
  (:edge
    (edge all-complete send-reminder
      (:guard (guard not-expr (-> outputs (get :all-complete) (get :action)))))))
```
