# Constraints

```lisp
(export employee-email-required placement-missing-employer placement-missing-client onboarding-employee-no-placement onboarding-no-tasks onboarding-missing-i9 employee-missing-bgc all-tasks-complete onboarding-overdue-critical onboarding-overdue-standard expired-documents)

;; =============================================================================
;; Staffing Agency Ontology - Canonical Constraints
;; =============================================================================
;;
;; Canonical constraint declarations preserve the current staffing constraint set while
;; moving the surface into noun documents and nested resolution objects.
;;

(define-constraint employee-email-required
  (:entity Employee)
  (:severity error)
  (:description "All employees must have an email address")
  (:category "data-quality")
  (:violation-query
    (find ?emp ?firstName ?lastName)
    (where
      [?emp :_schema/type "Employee"]
      [?emp :employee/first-name ?firstName]
      [?emp :employee/last-name ?lastName]
      [not [?emp :employee/email ?email]]))
  (:message (format "Employee {} {} is missing an email address" ?firstName ?lastName)))

(define-constraint placement-missing-employer
  (:entity Placement)
  (:severity warning)
  (:description "Active or pending placements should have an employer assigned")
  (:category "staffing")
  (:violation-query
    (find ?placement ?status)
    (where
      [?placement :_schema/type "Placement"]
      [?placement :placement/status ?status]
      [not [?placement :placement/employer ?employer]]))
  (:message (format "Placement ({}) has no employer assigned" ?status)))

(define-constraint placement-missing-client
  (:entity Placement)
  (:severity warning)
  (:description "Active placements should have a client assigned")
  (:category "staffing")
  (:violation-query
    (find ?placement)
    (where
      [?placement :_schema/type "Placement"]
      [?placement :placement/status "active"]
      [not [?placement :placement/client ?client]]))
  (:message "Active placement has no client assigned"))

(define-constraint onboarding-employee-no-placement
  (:entity Employee)
  (:severity info)
  (:description "Onboarding employees should have at least a pending placement")
  (:category "onboarding")
  (:violation-query
    (find ?emp ?firstName ?lastName)
    (where
      [?emp :_schema/type "Employee"]
      [?emp :employee/status "onboarding"]
      [?emp :employee/first-name ?firstName]
      [?emp :employee/last-name ?lastName]
      [not [?placement :placement/employee ?emp]]))
  (:message (format "Onboarding employee {} {} has no placement record" ?firstName ?lastName)))

(define-constraint onboarding-no-tasks
  (:entity Employee)
  (:severity warning)
  (:description "Onboarding employees should have at least one compliance task")
  (:category "onboarding")
  (:violation-query
    (find ?emp ?firstName ?lastName)
    (where
      [?emp :_schema/type "Employee"]
      [?emp :employee/status "onboarding"]
      [?emp :employee/first-name ?firstName]
      [?emp :employee/last-name ?lastName]
      [not [?task :task/entity-id ?emp]]))
  (:message
    (format "Onboarding employee {} {} has no compliance tasks assigned" ?firstName ?lastName)))

(define-constraint onboarding-missing-i9
  (:entity Employee)
  (:severity error)
  (:description "Onboarding employees with placements need I-9 verification")
  (:category "compliance")
  (:violation-query
    (find ?emp ?firstName ?lastName ?employer)
    (where
      [?emp :_schema/type "Employee"]
      [?emp :employee/status "onboarding"]
      [?emp :employee/first-name ?firstName]
      [?emp :employee/last-name ?lastName]
      [?placement :placement/employee ?emp]
      [?placement :placement/employer ?employer]
      [not [?i9task :task/entity-id ?emp]
           [?i9task :task/completion-document-ref "i-9-employment-eligibility"]]))
  (:message (format "{} {} needs I-9 verification" ?firstName ?lastName))
  (:resolution
    (resolution
      (:label "Start I-9 Verification")
      (:action start-i9)
      (:auto true)
      (:input [employer (path bindings "?employer")]))))

(define-constraint employee-missing-bgc
  (:entity Employee)
  (:severity warning)
  (:description "Onboarding employees should have a background check task")
  (:category "compliance")
  (:violation-query
    (find ?emp ?firstName ?lastName)
    (where
      [?emp :_schema/type "Employee"]
      [?emp :employee/status "onboarding"]
      [?emp :employee/first-name ?firstName]
      [?emp :employee/last-name ?lastName]
      [?anyTask :task/entity-id ?emp]
      [not [?bgcTask :task/entity-id ?emp]
           [?bgcTask :task/completion-document-ref "background-check-consent"]]))
  (:message (format "{} {} is missing a background check task" ?firstName ?lastName))
  (:resolution
    (resolution
      (:label "Create Background Check Task")
      (:action create-bgc-task)
      (:auto true)
      (:input [employeeId (path violation "entityId")]))))

(define-constraint all-tasks-complete
  (:entity Employee)
  (:severity info)
  (:description "Onboarding employees with all tasks submitted should be activated")
  (:category "onboarding")
  (:violation-query
    (find ?emp ?firstName ?lastName)
    (where
      [?emp :_schema/type "Employee"]
      [?emp :employee/status "onboarding"]
      [?emp :employee/first-name ?firstName]
      [?emp :employee/last-name ?lastName]
      [?anyTask :onboardingtask/employee ?emp]
      [not [?pendingTask :onboardingtask/employee ?emp]
           [?pendingTask :onboardingtask/status "pending"]]
      [not [?ipTask :onboardingtask/employee ?emp]
           [?ipTask :onboardingtask/status "in-progress"]]))
  (:message
    (format
      "{} {} has completed all onboarding tasks and is ready for activation"
      ?firstName
      ?lastName))
  (:resolution
    (resolution
      (:label "Activate Employee")
      (:action complete-onboarding)
      (:auto true))))

(define-constraint onboarding-overdue-critical
  (:entity OnboardingTask)
  (:severity error)
  (:description "Critical onboarding tasks (I-9) must not exceed their due date per federal regulations")
  (:category "compliance")
  (:violation-query
    (find ?task ?title ?dueDate)
    (where
      [?task :_schema/type "OnboardingTask"]
      [?task :onboardingtask/due-date ?dueDate]
      [< ?dueDate "$now"]
      [?task :onboardingtask/status ?status]
      [!= ?status "approved"]
      [!= ?status "submitted"]
      [?task :onboardingtask/priority "critical"]
      [?task :onboardingtask/title ?title]))
  (:message (format "Critical task \"{}\" is overdue (federal compliance deadline exceeded)" ?title)))

(define-constraint onboarding-overdue-standard
  (:entity OnboardingTask)
  (:severity warning)
  (:description "Non-critical onboarding tasks should be completed before their due date")
  (:category "onboarding")
  (:violation-query
    (find ?task ?title ?dueDate)
    (where
      [?task :_schema/type "OnboardingTask"]
      [?task :onboardingtask/due-date ?dueDate]
      [< ?dueDate "$now"]
      [?task :onboardingtask/status ?status]
      [!= ?status "approved"]
      [!= ?status "submitted"]
      [?task :onboardingtask/priority ?priority]
      [!= ?priority "critical"]
      [?task :onboardingtask/title ?title]))
  (:message (format "Task \"{}\" is overdue" ?title)))

(define-constraint expired-documents
  (:entity Document)
  (:severity error)
  (:description "Documents should not remain in expired status")
  (:category "compliance")
  (:violation-query
    (find ?doc ?docName ?docType)
    (where
      [?doc :_schema/type "Document"]
      [?doc :document/name ?docName]
      [?doc :document/type ?docType]
      [?doc :document/status "expired"]))
  (:message (format "Document {} ({}) has expired" ?docName ?docType)))
```
