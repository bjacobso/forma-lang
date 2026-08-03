# Actions

```lisp
(export create-client create-intake-packet submit-intake-packet complete-firm-review run-conflict-check approve-conflict-check escalate-conflict-check generate-engagement-letter complete-engagement-letter open-matter activate-matter add-case-task complete-case-task request-documents mark-documents-received approve-invoice flag-client-risk send-notification escalate-to-attorney)

;; =============================================================================
;; Law Firm Backoffice Ontology - Actions
;; =============================================================================

;; ---------------------------------------------------------------------------
;; Client Intake
;; ---------------------------------------------------------------------------

(define-action create-client
  (:input [attorney Attorney])
  (:returns Boolean)
  (:do
    (do
      (let [client-id (create! "Client"
                        :client/name (get $input :name)
                        :client/type (get $input :type)
                        :client/industry (get $input :industry)
                        :client/email (get $input :email)
                        :client/status "onboarding"
                        :client/risk-level "medium"
                        :client/source (get $input :source))
            intake-id (create! "IntakePacket"
                        :intakepacket/status "draft"
                        :intakepacket/notes "Created during client intake")
            conflict-id (create! "ConflictCheck"
                          :conflictcheck/status "pending"
                          :conflictcheck/search-terms (get $input :name)
                          :conflictcheck/notes "Initial conflicts search queued")
            link1 (link! "intake-for" intake-id client-id)
            link2 (link! "conflict-for" conflict-id client-id)
            link3 (link! "represents" $entity client-id
                    :represents/since (now)
                    :represents/role "prospective-lead")]
        true))))

(define-action create-intake-packet
  (:input [client Client])
  (:returns Boolean)
  (:do
    (do
      (let [instance-id (create-document-instance!
                          "client-intake-form"
                          {:entity-id $entity :entity-type "Client"})
            intake-id (create! "IntakePacket"
                        :intakepacket/status "draft"
                        :intakepacket/notes "Client intake packet opened")
            conflict-id (create! "ConflictCheck"
                          :conflictcheck/status "pending"
                          :conflictcheck/search-terms (get client :client/name)
                          :conflictcheck/result "not-run"
                          :conflictcheck/notes "Initial conflicts search queued")
            task-id (create-task!
                      {:title "Complete Client Intake Packet"
                       :type "data-entry"
                       :priority "high"
                       :entity-id $entity
                       :entity-type "Client"
                       :document-ref "client-intake-form"
                       :document-instance-ref instance-id
                       :section-refs ["client-background"]
                       :assignee-role "client-contact"})
            link1 (link! "intake-for" intake-id $entity)
            link2 (link! "conflict-for" conflict-id $entity)]
        true))))

(define-action submit-intake-packet
  (:input [client Client])
  (:returns Boolean)
  (:do
    (do
      (let [packet-id (create! "IntakePacket"
                        :intakepacket/status "submitted"
                        :intakepacket/submitted-at (now)
                        :intakepacket/notes "Client-submitted background, matter summary, and related parties")
            link-id (link! "intake-for" packet-id $entity)]
        true))))

(define-action complete-firm-review
  (:input [client Client])
  (:returns Boolean)
  (:do
    (do
      (let [check-id (create! "ConflictCheck"
                       :conflictcheck/status "cleared"
                       :conflictcheck/search-terms (get client :client/name)
                       :conflictcheck/result "clear"
                       :conflictcheck/reviewed-by "Nora Kim"
                       :conflictcheck/reviewed-at (now)
                       :conflictcheck/notes "Firm review cleared the client for engagement")
            link-id (link! "conflict-for" check-id $entity)]
        true))))

(define-action run-conflict-check
  (:input [client Client])
  (:returns Boolean)
  (:do
    (do
      (let [check-id (create! "ConflictCheck"
                       :conflictcheck/status "pending"
                       :conflictcheck/search-terms (get client :client/name)
                       :conflictcheck/result "not-run"
                       :conflictcheck/notes "Backoffice conflicts search started")
            link-id (link! "conflict-for" check-id $entity)]
        true))))

(define-action approve-conflict-check
  (:input [check ConflictCheck])
  (:returns Boolean)
  (:do
    (do
      (set-field check :conflictcheck/status "cleared")
      (set-field check :conflictcheck/result "clear")
      (set-field check :conflictcheck/reviewed-at (now))
      (= (get check :conflictcheck/status) "cleared"))))

(define-action escalate-conflict-check
  (:input [check ConflictCheck])
  (:returns Boolean)
  (:do
    (do
      (set-field check :conflictcheck/status "needs-review")
      (emit "escalate-conflict-check")
      true)))

;; ---------------------------------------------------------------------------
;; Engagement and Matter Opening
;; ---------------------------------------------------------------------------

(define-action generate-engagement-letter
  (:input [matter Matter])
  (:returns Boolean)
  (:do
    (do
      (let [letter-id (create! "EngagementLetter"
                        :engagementletter/status "sent"
                        :engagementletter/sent-at (now)
                        :engagementletter/fee-type (get matter :matter/fee-type)
                        :engagementletter/scope-summary (get matter :matter/summary))
            instance-id (create-document-instance!
                          "engagement-letter"
                          {:entity-id letter-id :entity-type "EngagementLetter"})
            task-id (create-task!
                      {:title "Review and Sign Engagement Letter"
                       :type "approval"
                       :priority "high"
                       :entity-id letter-id
                       :entity-type "EngagementLetter"
                       :document-ref "engagement-letter"
                       :document-instance-ref instance-id
                       :section-refs ["client-acceptance"]
                       :assignee-role "client-contact"})
            link-id (link! "engagement-letter-for" letter-id $entity)]
        true))))

(define-action complete-engagement-letter
  (:input [letter EngagementLetter])
  (:returns Boolean)
  (:do
    (do
      (set-field letter :engagementletter/status "signed")
      (set-field letter :engagementletter/signed-at (now))
      (= (get letter :engagementletter/status) "signed"))))

(define-action open-matter
  (:input [client Client])
  (:returns Boolean)
  (:do
    (do
      (set-field client :client/status "active")
      (let [matter-id (create! "Matter"
                        :matter/title (get $input :title)
                        :matter/practice-area (get $input :practiceArea)
                        :matter/status "opening"
                        :matter/opened-date (now)
                        :matter/next-deadline (get $input :nextDeadline)
                        :matter/budget (get $input :budget)
                        :matter/fee-type (get $input :feeType)
                        :matter/summary (get $input :summary))
            link-id (link! "matter-for" matter-id $entity)]
        true))))

(define-action activate-matter
  (:input [matter Matter])
  (:returns Boolean)
  (:do
    (do
      (set-field matter :matter/status "active")
      (= (get matter :matter/status) "active"))))

;; ---------------------------------------------------------------------------
;; Matter Operations
;; ---------------------------------------------------------------------------

(define-action add-case-task
  (:input [matter Matter])
  (:returns Boolean)
  (:do
    (do
      (let [task-id (create! "CaseTask"
                      :casetask/title (get $input :title)
                      :casetask/type (get $input :type)
                      :casetask/priority (get $input :priority)
                      :casetask/status "pending"
                      :casetask/due-date (get $input :dueDate)
                      :casetask/assignee-role (get $input :assigneeRole)
                      :casetask/notes (get $input :notes))
            link-id (link! "task-for-matter" task-id $entity)]
        true))))

(define-action complete-case-task
  (:input [task CaseTask])
  (:returns Boolean)
  (:do
    (do
      (set-field task :casetask/status "completed")
      (set-field task :casetask/completed-at (now))
      (= (get task :casetask/status) "completed"))))

(define-action request-documents
  (:input [matter Matter])
  (:returns Boolean)
  (:do
    (do
      (let [request-id (create! "DocumentRequest"
                         :documentrequest/title (get $input :title)
                         :documentrequest/status "requested"
                         :documentrequest/due-date (get $input :dueDate)
                         :documentrequest/requested-from (get $input :requestedFrom)
                         :documentrequest/notes (get $input :notes))
            link-id (link! "document-request-for" request-id $entity)]
        true))))

(define-action mark-documents-received
  (:input [request DocumentRequest])
  (:returns Boolean)
  (:do
    (do
      (set-field request :documentrequest/status "received")
      (set-field request :documentrequest/received-at (now))
      (= (get request :documentrequest/status) "received"))))

;; ---------------------------------------------------------------------------
;; Billing and Notifications
;; ---------------------------------------------------------------------------

(define-action approve-invoice
  (:input [invoice Invoice])
  (:returns Boolean)
  (:do
    (do
      (set-field invoice :invoice/needs-review false)
      (set-field invoice :invoice/status "approved")
      (= (get invoice :invoice/status) "approved"))))

(define-action flag-client-risk
  (:input [client Client])
  (:returns Boolean)
  (:do
    (do
      (set-field client :client/risk-level (get $input :riskLevel))
      (= (get client :client/risk-level) (get $input :riskLevel)))))

(define-action send-notification
  (:input [client Client])
  (:returns Boolean)
  (:do
    (do
      (emit "send-notification")
      true)))

(define-action escalate-to-attorney
  (:input [matter Matter])
  (:returns Boolean)
  (:do
    (do
      (emit "escalate-to-attorney")
      true)))
```
