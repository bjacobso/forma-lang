# Constraints

```lisp
(export onboarding-client-needs-conflict-check conflict-needs-attorney-review active-client-needs-attorney matter-needs-signed-engagement-letter active-matter-needs-attorney urgent-task-needs-owner overdue-document-request invoice-needs-review-before-sending high-risk-client-review)

;; =============================================================================
;; Law Firm Backoffice Ontology - Constraints
;; =============================================================================
;;
;; These constraints encode backoffice operating rules for a general law firm:
;; conflicts must clear before work begins, engagement letters must be signed,
;; matter tasks need owners, document requests need follow-up, and billing cannot
;; go out before attorney review.
;;

;; ---------------------------------------------------------------------------
;; Client Onboarding Governance
;; ---------------------------------------------------------------------------

(define-constraint onboarding-client-needs-conflict-check
  (:entity Client)
  (:severity error)
  (:description "Every onboarding client must have a conflict check")
  (:category "client-onboarding")
  (:violation-query
    (find ?client ?clientName)
    (where
      [?client :_schema/type "Client"]
      [?client :client/status "onboarding"]
      [?client :client/name ?clientName]
      [not [?check :conflict-for/client ?client]]))
  (:message (format "Client {} is onboarding without a conflict check" ?clientName))
  (:resolution
    (resolution
      (:label "Run Conflict Check")
      (:action run-conflict-check)
      (:auto true))))

(define-constraint conflict-needs-attorney-review
  (:entity ConflictCheck)
  (:severity warning)
  (:description "Potential conflicts require attorney review before representation")
  (:category "conflicts")
  (:violation-query
    (find ?check ?terms ?result)
    (where
      [?check :_schema/type "ConflictCheck"]
      [?check :conflictcheck/status "needs-review"]
      [?check :conflictcheck/search-terms ?terms]
      [?check :conflictcheck/result ?result]))
  (:message (format "Conflict check for {} requires attorney review: {}" ?terms ?result))
  (:resolution
    (resolution
      (:label "Escalate Conflict")
      (:action escalate-conflict-check)
      (:auto true))))

(define-constraint active-client-needs-attorney
  (:entity Client)
  (:severity warning)
  (:description "Active clients should have at least one responsible attorney")
  (:category "practice-management")
  (:violation-query
    (find ?client ?clientName)
    (where
      [?client :_schema/type "Client"]
      [?client :client/status "active"]
      [?client :client/name ?clientName]
      [not [?rep :represents/client ?client]]))
  (:message (format "Client {} has no attorney assigned" ?clientName)))

;; ---------------------------------------------------------------------------
;; Matter Governance
;; ---------------------------------------------------------------------------

(define-constraint matter-needs-signed-engagement-letter
  (:entity Matter)
  (:severity error)
  (:description "A matter should not become active without a signed engagement letter")
  (:category "matter-opening")
  (:violation-query
    (find ?matter ?title)
    (where
      [?matter :_schema/type "Matter"]
      [?matter :matter/status "active"]
      [?matter :matter/title ?title]
      [not [?letter :engagement-letter-for/matter ?matter]]))
  (:message (format "Matter \"{}\" is active without a linked engagement letter" ?title))
  (:resolution
    (resolution
      (:label "Generate Engagement Letter")
      (:action generate-engagement-letter)
      (:auto true))))

(define-constraint active-matter-needs-attorney
  (:entity Matter)
  (:severity warning)
  (:description "Active matters must have a managing attorney")
  (:category "practice-management")
  (:violation-query
    (find ?matter ?title)
    (where
      [?matter :_schema/type "Matter"]
      [?matter :matter/status "active"]
      [?matter :matter/title ?title]
      [not [?mgmt :matter-managed-by/matter ?matter]]))
  (:message (format "Matter \"{}\" has no managing attorney" ?title)))

(define-constraint urgent-task-needs-owner
  (:entity CaseTask)
  (:severity error)
  (:description "Urgent case tasks must have an assignee role")
  (:category "task-management")
  (:violation-query
    (find ?task ?title)
    (where
      [?task :_schema/type "CaseTask"]
      [?task :casetask/priority "urgent"]
      [?task :casetask/title ?title]
      [not [?task :casetask/assignee-role ?role]]))
  (:message (format "Urgent task \"{}\" has no assignee role" ?title)))

(define-constraint overdue-document-request
  (:entity DocumentRequest)
  (:severity warning)
  (:description "Overdue document requests need client follow-up")
  (:category "document-chasing")
  (:violation-query
    (find ?request ?title ?from)
    (where
      [?request :_schema/type "DocumentRequest"]
      [?request :documentrequest/status "overdue"]
      [?request :documentrequest/title ?title]
      [?request :documentrequest/requested-from ?from]))
  (:message (format "Document request \"{}\" from {} is overdue" ?title ?from)))

;; ---------------------------------------------------------------------------
;; Billing Governance
;; ---------------------------------------------------------------------------

(define-constraint invoice-needs-review-before-sending
  (:entity Invoice)
  (:severity warning)
  (:description "Invoices flagged for review should not be sent until approved")
  (:category "billing")
  (:violation-query
    (find ?invoice ?number ?amount)
    (where
      [?invoice :_schema/type "Invoice"]
      [?invoice :invoice/needs-review true]
      [?invoice :invoice/number ?number]
      [?invoice :invoice/amount ?amount]))
  (:message (format "Invoice {} for {} needs attorney review before sending" ?number ?amount))
  (:resolution
    (resolution
      (:label "Approve Invoice")
      (:action approve-invoice)
      (:auto false))))

(define-constraint high-risk-client-review
  (:entity Client)
  (:severity info)
  (:description "High-risk clients should receive periodic attorney review")
  (:category "practice-management")
  (:violation-query
    (find ?client ?clientName ?industry)
    (where
      [?client :_schema/type "Client"]
      [?client :client/risk-level "high"]
      [?client :client/status "active"]
      [?client :client/name ?clientName]
      [?client :client/industry ?industry]))
  (:message (format "{} ({}): High-risk client - ensure attorney review is scheduled" ?clientName ?industry)))
```
