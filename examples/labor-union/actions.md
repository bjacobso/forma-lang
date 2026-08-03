# Actions

```lisp
(export create-covered-placement sync-employee-cba-attribute start-union-authorization-card collect-form submit-union-authorization-card emit-card-completed-webhook mark-document-routed flag-rehire-review)

;; =============================================================================
;; Labor Relations Ontology - Actions
;; =============================================================================

(define-action create-covered-placement
  (:input [employer Employer])
  (:returns Boolean)
  (:do
    (do
      (let [employee-id (create! "Employee"
                          :employee/first-name (get $input :firstName)
                          :employee/last-name (get $input :lastName)
                          :employee/email (get $input :email)
                          :employee/phone (get $input :phone)
                          :employee/status "preboarding"
                          :employee/global-hr-id (get $input :globalHrId)
                          :employee/hire-event-id (get $input :hireEventId)
                          :employee/rehire-indicator false
                          :employee/address (get $input :address)
                          :employee/union-card-signed false)
            placement-id (create! "Placement"
                           :placement/start-date (get $input :startDate)
                           :placement/status "covered-pending-card"
                           :placement/source-system "Enterprise HRIS"
                           :placement/cba-id (get $input :cbaId)
                           :placement/employee employee-id
                           :placement/position (get $input :positionId)
                           :placement/employer $entity)
            link-id (link! "placed-in" employee-id placement-id)]
        true))))

(define-action sync-employee-cba-attribute
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (set-field employee :employee/cba-id (get $input :cbaId))
      (= (get employee :employee/cba-id) (get $input :cbaId)))))

(define-action start-union-authorization-card
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (let [instance-id (create-document-instance!
                          "union-authorization-card"
                          {:entity-id $entity :entity-type "Employee"})
            task-id (create-task!
                      {:title "Complete Union Authorization Card"
                       :type "data-entry"
                       :priority "critical"
                       :entity-id $entity
                       :entity-type "Employee"
                       :document-ref "union-authorization-card"
                       :document-instance-ref instance-id
                       :section-refs ["employee-authorization"]
                       :assignee-role "employee"})
            auth-task-id (create! "UnionAuthorizationTask"
                           :unionauthtask/title "Complete Union Authorization Card"
                           :unionauthtask/status "pending"
                           :unionauthtask/priority "critical"
                           :unionauthtask/assignee-role "employee"
                           :unionauthtask/delivery-channel "Candidate Messaging"
                           :unionauthtask/due-date (get $input :dueDate)
                           :unionauthtask/template-version (get $input :templateVersion)
                           :unionauthtask/runtime-task-id task-id
                           :unionauthtask/document-instance-id instance-id
                           :unionauthtask/employee $entity
                           :unionauthtask/placement (get $input :placementId)
                           :unionauthtask/cba (get $input :cbaId))]
        true))))

(define-action collect-form
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (emit "collect-form")
      true)))

(define-action submit-union-authorization-card
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (set-field employee :employee/union-card-signed true)
      (let [document-id (create! "ExecutedAuthorizationDocument"
                          :executeddocument/name "Completed Union Authorization Card"
                          :executeddocument/status "available"
                          :executeddocument/signed-at (now)
                          :executeddocument/template-version "submitted"
                          :executeddocument/pdf-reference "api://documents/submitted-union-card/pdf"
                          :executeddocument/structured-data-reference "api://documents/submitted-union-card/data"
                          :executeddocument/routing-status "ready"
                          :executeddocument/employee $entity)]
        true))))

(define-action emit-card-completed-webhook
  (:input [document ExecutedAuthorizationDocument])
  (:returns Boolean)
  (:do
    (do
      (let [event-id (create! "IntegrationEvent"
                       :integrationevent/event-type "task_updated"
                       :integrationevent/status "pending"
                       :integrationevent/target-system "Associate Digital File"
                       :integrationevent/emitted-at (now)
                       :integrationevent/payload-summary "Authorization card completed; PDF and structured data are available for retrieval."
                       :integrationevent/document $entity)]
        true))))

(define-action mark-document-routed
  (:input [document ExecutedAuthorizationDocument])
  (:returns Boolean)
  (:do
    (do
      (set-field document :executeddocument/routing-status "routed")
      (= (get document :executeddocument/routing-status) "routed"))))

(define-action flag-rehire-review
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (emit "flag-rehire-review")
      (= (get employee :employee/rehire-indicator) true))))
```
