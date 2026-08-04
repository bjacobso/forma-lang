# Queries

```lisp
(export onboarding-clients active-clients high-risk-clients active-matters matters-opening intake-packets-needing-review pending-conflict-checks conflicts-needing-attorney-review engagement-letters-outstanding open-case-tasks urgent-case-tasks overdue-document-requests open-document-requests invoices-needing-review active-violations)

;; =============================================================================
;; Law Firm Backoffice Ontology - Queries
;; =============================================================================

(define-query onboarding-clients
  (:from Client)
  (:where (= (get it :client/status) "onboarding"))
  (:select [client/name client/type client/industry client/risk-level client/email]))

(define-query active-clients
  (:from Client)
  (:where (= (get it :client/status) "active"))
  (:select [client/name client/type client/industry client/risk-level client/email]))

(define-query high-risk-clients
  (:from Client)
  (:where (= (get it :client/risk-level) "high"))
  (:select [client/name client/type client/industry client/status client/email]))

(define-query active-matters
  (:from Matter)
  (:where (= (get it :matter/status) "active"))
  (:select [matter/title matter/practice-area matter/fee-type matter/next-deadline matter/budget]))

(define-query matters-opening
  (:from Matter)
  (:where (= (get it :matter/status) "opening"))
  (:select [matter/title matter/practice-area matter/fee-type matter/opened-date matter/summary]))

(define-query intake-packets-needing-review
  (:from IntakePacket)
  (:where (= (get it :intakepacket/status) "submitted"))
  (:select [intakepacket/status intakepacket/submitted-at intakepacket/notes]))

(define-query pending-conflict-checks
  (:from ConflictCheck)
  (:where (= (get it :conflictcheck/status) "pending"))
  (:select [conflictcheck/status conflictcheck/search-terms conflictcheck/result conflictcheck/notes]))

(define-query conflicts-needing-attorney-review
  (:from ConflictCheck)
  (:where (= (get it :conflictcheck/status) "needs-review"))
  (:select [conflictcheck/status conflictcheck/search-terms conflictcheck/result conflictcheck/notes]))

(define-query engagement-letters-outstanding
  (:from EngagementLetter)
  (:where
    (and
      (!= (get it :engagementletter/status) "signed")
      (!= (get it :engagementletter/status) "declined")))
  (:select [engagementletter/status engagementletter/sent-at engagementletter/fee-type engagementletter/scope-summary]))

(define-query open-case-tasks
  (:from CaseTask)
  (:where
    (and
      (!= (get it :casetask/status) "completed")
      (!= (get it :casetask/status) "cancelled")))
  (:select [casetask/title casetask/type casetask/priority casetask/status casetask/due-date casetask/assignee-role]))

(define-query urgent-case-tasks
  (:from CaseTask)
  (:where
    (and
      (= (get it :casetask/priority) "urgent")
      (!= (get it :casetask/status) "completed")))
  (:select [casetask/title casetask/type casetask/status casetask/due-date casetask/assignee-role]))

(define-query overdue-document-requests
  (:from DocumentRequest)
  (:where (= (get it :documentrequest/status) "overdue"))
  (:select [documentrequest/title documentrequest/requested-from documentrequest/due-date documentrequest/notes]))

(define-query open-document-requests
  (:from DocumentRequest)
  (:where
    (and
      (!= (get it :documentrequest/status) "received")
      (!= (get it :documentrequest/status) "cancelled")))
  (:select [documentrequest/title documentrequest/status documentrequest/requested-from documentrequest/due-date]))

(define-query invoices-needing-review
  (:from Invoice)
  (:where (= (get it :invoice/status) "draft"))
  (:select [invoice/number invoice/status invoice/amount invoice/issued-at invoice/due-date]))

(define-query active-violations
  (:from Violation)
  (:where (= (get it :violation/status) "open"))
  (:select
    [violation/constraint-name
     violation/severity
     violation/message
     violation/entity-id
     violation/task-id
     violation/detected-at]))
```
