# Actions

```lisp
(export hire-employee hire-existing-employee generate-onboarding-tasks start-i9 create-bgc-task complete-onboarding collect-form evaluate-condition send-notification generate-i9-pdf start-i9-section-2 complete-w4-task complete-bgc-task complete-direct-deposit-task complete-handbook-task complete-state-tax-task complete-idv-task mark-compliant)

;; =============================================================================
;; Staffing Agency Ontology - Canonical Actions
;; =============================================================================
;;
;; Canonical actions use a single Lisp do body instead of a separate effects
;; language. These examples also exercise HM checking over actual (do ...)
;; blocks, not just single expressions.
;;

(define-action hire-employee
  (:input [employer Employer])
  (:returns Boolean)
  (:do
    (do
      (let [hire-date (now)
            emp-id (create! "Employee"
                     :employee/first-name (get $input :firstName)
                     :employee/last-name (get $input :lastName)
                     :employee/email (get $input :email)
                     :employee/status "onboarding"
                     :employee/hire-date hire-date)
            plc-id (create! "Placement"
                     :placement/employee emp-id
                     :placement/employer $entity
                     :placement/status "active"
                     :placement/start-date hire-date)
            link-id (link! "works-at" emp-id $entity
                      :works-at/start-date hire-date
                      :works-at/status "active")]
        true))))

(define-action hire-existing-employee
  (:input [employer Employer])
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (let [hire-date (now)
            employee-id (id employee)
            plc-id (create! "Placement"
                     :placement/employee employee-id
                     :placement/employer $entity
                     :placement/status "active"
                     :placement/start-date hire-date)
            link-id (link! "works-at" employee-id $entity
                      :works-at/start-date hire-date
                      :works-at/status "active")]
        (set-field employee :employee/status "onboarding")
        (set-field employee :employee/hire-date hire-date)
        true))))

(define-action generate-onboarding-tasks
  (:input [employee Employee])
  (:input [employer Employer])
  (:returns Boolean)
  (:do
    (do
      (emit "generate-onboarding-tasks")
      (set-field employee :employee/status "pending")
      (and
        (= (get employee :employee/status) "onboarding")
        (= (get employer :employer/status) "active")))))

(define-action start-i9
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (let [instance-id (create-document-instance!
                           "i-9-employment-eligibility"
                           {:entity-id $entity :entity-type "Employee"})
            task-id (create-task!
                      {:title "I-9 Section 1 — Employee Information"
                       :type "data-entry"
                       :priority "critical"
                       :entity-id $entity
                       :entity-type "Employee"
                       :document-ref "i-9-employment-eligibility"
                       :document-instance-ref instance-id
                       :section-refs ["employee-information"]
                       :assignee-role "employee"})]
        true))))

(define-action create-bgc-task
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (emit "create-bgc-task")
      (= (get employee :employee/status) "onboarding"))))

(define-action complete-onboarding
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (set-field employee :employee/status "active")
      (= (get employee :employee/status) "active"))))

(define-action collect-form
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (emit "collect-form")
      true)))

(define-action evaluate-condition
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (emit "evaluate-condition")
      (= (get employee :employee/status) "active"))))

(define-action send-notification
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (emit "send-notification")
      true)))

(define-action generate-i9-pdf
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (emit "generate-i9-pdf")
      true)))

(define-action start-i9-section-2
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (let [task-id (create-task!
                      {:title "I-9 Section 2 — Employer Review"
                       :type "data-entry"
                       :priority "critical"
                       :entity-id $entity
                       :entity-type "Employee"
                       :document-ref "i-9-employment-eligibility"
                       :document-instance-ref (get $input :__documentInstanceId)
                       :section-refs ["employer-review"]
                       :assignee-role "employer"})]
        true))))

(define-action complete-w4-task
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (emit "complete-w4-task")
      true)))

(define-action complete-bgc-task
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (emit "complete-bgc-task")
      true)))

(define-action complete-direct-deposit-task
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (emit "complete-direct-deposit-task")
      true)))

(define-action complete-handbook-task
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (emit "complete-handbook-task")
      true)))

(define-action complete-state-tax-task
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (emit "complete-state-tax-task")
      true)))

(define-action complete-idv-task
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (emit "complete-idv-task")
      true)))

(define-action mark-compliant
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (set-field employee :employee/status "active")
      (= (get employee :employee/status) "active"))))
```
