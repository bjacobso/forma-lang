# Schema

```lisp
(export Attorney Paralegal Client Contact Matter IntakePacket ConflictCheck EngagementLetter CaseTask DocumentRequest Invoice represents contact-at intake-for conflict-for matter-for matter-managed-by matter-supported-by engagement-letter-for task-for-matter document-request-for invoice-for)

;; =============================================================================
;; Law Firm Backoffice Ontology - Schema
;; =============================================================================
;;
;; Models a general law firm backoffice focused on client onboarding, conflict
;; checks, engagement letters, matter management, document requests, and billing.
;;

;; ---------------------------------------------------------------------------
;; Entity Types
;; ---------------------------------------------------------------------------

(define-entity Attorney
  (:field [attorney/first-name String {:required true}])
  (:field [attorney/last-name String {:required true}])
  (:field [attorney/email String {:required true}])
  (:field [attorney/phone String])
  (:field [attorney/bar-number String {:required true}])
  (:field [attorney/practice-area String])
  (:field [attorney/status String {:required true}]))

(define-entity Paralegal
  (:field [paralegal/first-name String {:required true}])
  (:field [paralegal/last-name String {:required true}])
  (:field [paralegal/email String {:required true}])
  (:field [paralegal/team String])
  (:field [paralegal/status String {:required true}]))

(define-entity Client
  (:field [client/name String {:required true}])
  (:field [client/type String {:required true}])
  (:field [client/industry String])
  (:field [client/phone String])
  (:field [client/email String])
  (:field [client/status String {:required true}])
  (:field [client/risk-level String])
  (:field [client/source String]))

(define-entity Contact
  (:field [contact/name String {:required true}])
  (:field [contact/title String])
  (:field [contact/email String {:required true}])
  (:field [contact/phone String])
  (:field [contact/role String {:required true}]))

(define-entity Matter
  (:field [matter/title String {:required true}])
  (:field [matter/practice-area String {:required true}])
  (:field [matter/status String {:required true}])
  (:field [matter/opened-date Number])
  (:field [matter/next-deadline Number])
  (:field [matter/budget Number])
  (:field [matter/fee-type String])
  (:field [matter/summary String]))

(define-entity IntakePacket
  (:field [intakepacket/status String {:required true}])
  (:field [intakepacket/submitted-at Number])
  (:field [intakepacket/reviewed-at Number])
  (:field [intakepacket/notes String]))

(define-entity ConflictCheck
  (:field [conflictcheck/status String {:required true}])
  (:field [conflictcheck/search-terms String])
  (:field [conflictcheck/result String])
  (:field [conflictcheck/reviewed-by String])
  (:field [conflictcheck/reviewed-at Number])
  (:field [conflictcheck/notes String]))

(define-entity EngagementLetter
  (:field [engagementletter/status String {:required true}])
  (:field [engagementletter/sent-at Number])
  (:field [engagementletter/signed-at Number])
  (:field [engagementletter/fee-type String])
  (:field [engagementletter/scope-summary String]))

(define-entity CaseTask
  (:field [casetask/title String {:required true}])
  (:field [casetask/type String {:required true}])
  (:field [casetask/priority String {:required true}])
  (:field [casetask/status String {:required true}])
  (:field [casetask/due-date Number])
  (:field [casetask/completed-at Number])
  (:field [casetask/assignee-role String {:required true}])
  (:field [casetask/notes String]))

(define-entity DocumentRequest
  (:field [documentrequest/title String {:required true}])
  (:field [documentrequest/status String {:required true}])
  (:field [documentrequest/due-date Number])
  (:field [documentrequest/received-at Number])
  (:field [documentrequest/requested-from String])
  (:field [documentrequest/notes String]))

(define-entity Invoice
  (:field [invoice/number String {:required true}])
  (:field [invoice/status String {:required true}])
  (:field [invoice/amount Number {:required true}])
  (:field [invoice/issued-at Number])
  (:field [invoice/due-date Number])
  (:field [invoice/needs-review Boolean]))

;; ---------------------------------------------------------------------------
;; Relations
;; ---------------------------------------------------------------------------

(define-relation represents Attorney Client
  (:field [represents/since Number])
  (:field [represents/role String]))

(define-relation contact-at Contact Client
  (:field [contact-at/primary Boolean]))

(define-relation intake-for IntakePacket Client)

(define-relation conflict-for ConflictCheck Client)

(define-relation matter-for Matter Client)

(define-relation matter-managed-by Matter Attorney)

(define-relation matter-supported-by Matter Paralegal)

(define-relation engagement-letter-for EngagementLetter Matter)

(define-relation task-for-matter CaseTask Matter)

(define-relation document-request-for DocumentRequest Matter)

(define-relation invoice-for Invoice Matter)
```
