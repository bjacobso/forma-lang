# Seed Data

```lisp
(export represents contact-at intake-for conflict-for matter-for matter-managed-by matter-supported-by engagement-letter-for task-for-matter document-request-for invoice-for)

;; =============================================================================
;; Law Firm Backoffice Ontology - Seed Data
;; =============================================================================
;;
;; Demo narrative: Hale & Rivera LLP manages a mixed client portfolio. The firm
;; is onboarding a startup, clearing an employment matter, responding to a
;; litigation deadline, and chasing estate-planning documents.
;;

;; ---------------------------------------------------------------------------
;; Firm Staff
;; ---------------------------------------------------------------------------

(define-record "atty:amelia" Attorney
  (:field [attorney/first-name "Amelia"])
  (:field [attorney/last-name "Hale"])
  (:field [attorney/email "ahale@halerivera.law"])
  (:field [attorney/phone "+1-312-555-0101"])
  (:field [attorney/bar-number "IL-448291"])
  (:field [attorney/practice-area "corporate"])
  (:field [attorney/status "active"]))

(define-record "atty:marco" Attorney
  (:field [attorney/first-name "Marco"])
  (:field [attorney/last-name "Rivera"])
  (:field [attorney/email "mrivera@halerivera.law"])
  (:field [attorney/phone "+1-312-555-0102"])
  (:field [attorney/bar-number "IL-451037"])
  (:field [attorney/practice-area "litigation"])
  (:field [attorney/status "active"]))

(define-record "para:nora" Paralegal
  (:field [paralegal/first-name "Nora"])
  (:field [paralegal/last-name "Kim"])
  (:field [paralegal/email "nkim@halerivera.law"])
  (:field [paralegal/team "intake"])
  (:field [paralegal/status "active"]))

(define-record "para:eli" Paralegal
  (:field [paralegal/first-name "Eli"])
  (:field [paralegal/last-name "Brooks"])
  (:field [paralegal/email "ebrooks@halerivera.law"])
  (:field [paralegal/team "matters"])
  (:field [paralegal/status "active"]))

;; ---------------------------------------------------------------------------
;; Clients
;; ---------------------------------------------------------------------------

(define-record "client:northstar" Client
  (:field [client/name "Northstar Robotics"])
  (:field [client/type "business"])
  (:field [client/industry "Technology"])
  (:field [client/phone "+1-312-555-1100"])
  (:field [client/email "legal@northstarrobotics.com"])
  (:field [client/status "onboarding"])
  (:field [client/risk-level "medium"])
  (:field [client/source "founder-referral"]))

(define-record "client:brightpath" Client
  (:field [client/name "BrightPath Education"])
  (:field [client/type "nonprofit"])
  (:field [client/industry "Education"])
  (:field [client/phone "+1-312-555-1200"])
  (:field [client/email "ops@brightpath.org"])
  (:field [client/status "active"])
  (:field [client/risk-level "low"])
  (:field [client/source "existing-client"]))

(define-record "client:lakeside" Client
  (:field [client/name "Lakeside Foods"])
  (:field [client/type "business"])
  (:field [client/industry "Food Distribution"])
  (:field [client/phone "+1-312-555-1300"])
  (:field [client/email "gc@lakesidefoods.com"])
  (:field [client/status "active"])
  (:field [client/risk-level "high"])
  (:field [client/source "urgent-litigation"]))

(define-record "client:carter" Client
  (:field [client/name "Dana Carter"])
  (:field [client/type "individual"])
  (:field [client/industry "Estate Planning"])
  (:field [client/phone "+1-312-555-1400"])
  (:field [client/email "dana.carter@example.com"])
  (:field [client/status "active"])
  (:field [client/risk-level "medium"])
  (:field [client/source "website"]))

;; ---------------------------------------------------------------------------
;; Contacts
;; ---------------------------------------------------------------------------

(define-record "contact:maya" Contact
  (:field [contact/name "Maya Singh"])
  (:field [contact/title "Founder"])
  (:field [contact/email "maya@northstarrobotics.com"])
  (:field [contact/phone "+1-312-555-1101"])
  (:field [contact/role "decision-maker"]))

(define-record "contact:owen" Contact
  (:field [contact/name "Owen Brooks"])
  (:field [contact/title "Operations Director"])
  (:field [contact/email "owen@brightpath.org"])
  (:field [contact/phone "+1-312-555-1201"])
  (:field [contact/role "operations"]))

(define-record "contact:sofia" Contact
  (:field [contact/name "Sofia Morales"])
  (:field [contact/title "General Counsel"])
  (:field [contact/email "sofia@lakesidefoods.com"])
  (:field [contact/phone "+1-312-555-1301"])
  (:field [contact/role "legal"]))

(define-record "contact:dana" Contact
  (:field [contact/name "Dana Carter"])
  (:field [contact/title "Client"])
  (:field [contact/email "dana.carter@example.com"])
  (:field [contact/phone "+1-312-555-1400"])
  (:field [contact/role "client"]))

;; ---------------------------------------------------------------------------
;; Intake and Conflicts
;; ---------------------------------------------------------------------------

(define-record "intake:northstar" IntakePacket
  (:field [intakepacket/status "submitted"])
  (:field [intakepacket/submitted-at 1711929600000])
  (:field [intakepacket/notes "Founder requests formation cleanup, commercial contract templates, and first financing readiness."]))

(define-record "intake:carter" IntakePacket
  (:field [intakepacket/status "reviewed"])
  (:field [intakepacket/submitted-at 1709251200000])
  (:field [intakepacket/reviewed-at 1709337600000])
  (:field [intakepacket/notes "Estate plan intake complete. Waiting on financial account list."]))

(define-record "conflict:northstar" ConflictCheck
  (:field [conflictcheck/status "pending"])
  (:field [conflictcheck/search-terms "Northstar Robotics; Maya Singh; Apex Components"])
  (:field [conflictcheck/result "not-run"])
  (:field [conflictcheck/notes "Counterparty list supplied by founder. Search queued."]))

(define-record "conflict:lakeside" ConflictCheck
  (:field [conflictcheck/status "needs-review"])
  (:field [conflictcheck/search-terms "Lakeside Foods; Beacon Packaging; Sofia Morales"])
  (:field [conflictcheck/result "possible-prior-consult"])
  (:field [conflictcheck/reviewed-by "Nora Kim"])
  (:field [conflictcheck/reviewed-at 1710115200000])
  (:field [conflictcheck/notes "Beacon Packaging appeared in a prior declined consultation. Attorney review required."]))

(define-record "conflict:brightpath" ConflictCheck
  (:field [conflictcheck/status "cleared"])
  (:field [conflictcheck/search-terms "BrightPath Education; Owen Brooks"])
  (:field [conflictcheck/result "clear"])
  (:field [conflictcheck/reviewed-by "Nora Kim"])
  (:field [conflictcheck/reviewed-at 1706745600000]))

(define-record "conflict:carter" ConflictCheck
  (:field [conflictcheck/status "cleared"])
  (:field [conflictcheck/search-terms "Dana Carter; Riley Carter"])
  (:field [conflictcheck/result "clear"])
  (:field [conflictcheck/reviewed-by "Nora Kim"])
  (:field [conflictcheck/reviewed-at 1709337600000]))

;; ---------------------------------------------------------------------------
;; Matters
;; ---------------------------------------------------------------------------

(define-record "matter:northstar-general" Matter
  (:field [matter/title "Northstar General Counsel Setup"])
  (:field [matter/practice-area "corporate"])
  (:field [matter/status "opening"])
  (:field [matter/opened-date 1712016000000])
  (:field [matter/next-deadline 1712620800000])
  (:field [matter/budget 8500])
  (:field [matter/fee-type "retainer"])
  (:field [matter/summary "Set up outside general counsel workflow, contract templates, and financing readiness checklist."]))

(define-record "matter:brightpath-handbook" Matter
  (:field [matter/title "BrightPath Handbook Refresh"])
  (:field [matter/practice-area "employment"])
  (:field [matter/status "active"])
  (:field [matter/opened-date 1706745600000])
  (:field [matter/next-deadline 1712880000000])
  (:field [matter/budget 6000])
  (:field [matter/fee-type "flat-fee"])
  (:field [matter/summary "Update employee handbook, leave policies, and contractor classification guidance."]))

(define-record "matter:lakeside-litigation" Matter
  (:field [matter/title "Lakeside Supplier Dispute"])
  (:field [matter/practice-area "litigation"])
  (:field [matter/status "active"])
  (:field [matter/opened-date 1710115200000])
  (:field [matter/next-deadline 1710806400000])
  (:field [matter/budget 25000])
  (:field [matter/fee-type "hourly"])
  (:field [matter/summary "Respond to supplier demand letter and preserve documents for threatened commercial litigation."]))

(define-record "matter:carter-estate" Matter
  (:field [matter/title "Dana Carter Estate Plan"])
  (:field [matter/practice-area "estate-planning"])
  (:field [matter/status "active"])
  (:field [matter/opened-date 1709510400000])
  (:field [matter/next-deadline 1713484800000])
  (:field [matter/budget 4200])
  (:field [matter/fee-type "flat-fee"])
  (:field [matter/summary "Prepare will, trust, healthcare directive, and durable power of attorney."]))

;; ---------------------------------------------------------------------------
;; Engagement Letters
;; ---------------------------------------------------------------------------

(define-record "letter:northstar" EngagementLetter
  (:field [engagementletter/status "sent"])
  (:field [engagementletter/sent-at 1712016000000])
  (:field [engagementletter/fee-type "retainer"])
  (:field [engagementletter/scope-summary "Outside general counsel setup and corporate housekeeping."]))

(define-record "letter:brightpath" EngagementLetter
  (:field [engagementletter/status "signed"])
  (:field [engagementletter/sent-at 1706745600000])
  (:field [engagementletter/signed-at 1706832000000])
  (:field [engagementletter/fee-type "flat-fee"])
  (:field [engagementletter/scope-summary "Employment handbook refresh."]))

(define-record "letter:lakeside" EngagementLetter
  (:field [engagementletter/status "signed"])
  (:field [engagementletter/sent-at 1710115200000])
  (:field [engagementletter/signed-at 1710201600000])
  (:field [engagementletter/fee-type "hourly"])
  (:field [engagementletter/scope-summary "Commercial dispute response and document preservation."]))

(define-record "letter:carter" EngagementLetter
  (:field [engagementletter/status "signed"])
  (:field [engagementletter/sent-at 1709510400000])
  (:field [engagementletter/signed-at 1709596800000])
  (:field [engagementletter/fee-type "flat-fee"])
  (:field [engagementletter/scope-summary "Estate planning package."]))

;; ---------------------------------------------------------------------------
;; Case Tasks
;; ---------------------------------------------------------------------------

(define-record "task:northstar-conflicts" CaseTask
  (:field [casetask/title "Finish Northstar conflict search"])
  (:field [casetask/type "conflicts"])
  (:field [casetask/priority "high"])
  (:field [casetask/status "pending"])
  (:field [casetask/due-date 1712102400000])
  (:field [casetask/assignee-role "intake-coordinator"])
  (:field [casetask/notes "Search founder, company, investor, and first three counterparties."]))

(define-record "task:northstar-letter" CaseTask
  (:field [casetask/title "Follow up on Northstar engagement letter"])
  (:field [casetask/type "engagement-letter"])
  (:field [casetask/priority "high"])
  (:field [casetask/status "in-progress"])
  (:field [casetask/due-date 1712361600000])
  (:field [casetask/assignee-role "intake-coordinator"])
  (:field [casetask/notes "Founder asked for one scope clarification before signing."]))

(define-record "task:brightpath-policy" CaseTask
  (:field [casetask/title "Attorney review of handbook redline"])
  (:field [casetask/type "legal-review"])
  (:field [casetask/priority "medium"])
  (:field [casetask/status "pending"])
  (:field [casetask/due-date 1712620800000])
  (:field [casetask/assignee-role "attorney"])
  (:field [casetask/notes "Review leave policy changes before client call."]))

(define-record "task:lakeside-preservation" CaseTask
  (:field [casetask/title "Issue litigation hold instructions"])
  (:field [casetask/type "deadline"])
  (:field [casetask/priority "urgent"])
  (:field [casetask/status "in-progress"])
  (:field [casetask/due-date 1710374400000])
  (:field [casetask/assignee-role "attorney"])
  (:field [casetask/notes "Demand letter alleges spoliation risk. Send hold instructions today."]))

(define-record "task:lakeside-demand" CaseTask
  (:field [casetask/title "Draft demand-letter response"])
  (:field [casetask/type "drafting"])
  (:field [casetask/priority "urgent"])
  (:field [casetask/status "pending"])
  (:field [casetask/due-date 1710806400000])
  (:field [casetask/assignee-role "attorney"])
  (:field [casetask/notes "Response deadline is one week from receipt."]))

(define-record "task:carter-draft" CaseTask
  (:field [casetask/title "Prepare Carter estate plan drafts"])
  (:field [casetask/type "drafting"])
  (:field [casetask/priority "medium"])
  (:field [casetask/status "pending"])
  (:field [casetask/due-date 1713225600000])
  (:field [casetask/assignee-role "paralegal"])
  (:field [casetask/notes "Draft after account list and beneficiary updates are received."]))

;; ---------------------------------------------------------------------------
;; Document Requests
;; ---------------------------------------------------------------------------

(define-record "docreq:northstar-cap-table" DocumentRequest
  (:field [documentrequest/title "Current cap table and option plan"])
  (:field [documentrequest/status "requested"])
  (:field [documentrequest/due-date 1712361600000])
  (:field [documentrequest/requested-from "Maya Singh"])
  (:field [documentrequest/notes "Needed before financing-readiness review."]))

(define-record "docreq:brightpath-handbook" DocumentRequest
  (:field [documentrequest/title "Current employee handbook"])
  (:field [documentrequest/status "received"])
  (:field [documentrequest/due-date 1707350400000])
  (:field [documentrequest/received-at 1707264000000])
  (:field [documentrequest/requested-from "Owen Brooks"])
  (:field [documentrequest/notes "Uploaded PDF and editable source."]))

(define-record "docreq:lakeside-contracts" DocumentRequest
  (:field [documentrequest/title "Supplier agreement and correspondence"])
  (:field [documentrequest/status "overdue"])
  (:field [documentrequest/due-date 1710288000000])
  (:field [documentrequest/requested-from "Sofia Morales"])
  (:field [documentrequest/notes "Needed for demand-letter response and hold scope."]))

(define-record "docreq:carter-accounts" DocumentRequest
  (:field [documentrequest/title "Financial account list"])
  (:field [documentrequest/status "overdue"])
  (:field [documentrequest/due-date 1710979200000])
  (:field [documentrequest/requested-from "Dana Carter"])
  (:field [documentrequest/notes "Needed before trust funding memo."]))

;; ---------------------------------------------------------------------------
;; Invoices
;; ---------------------------------------------------------------------------

(define-record "invoice:brightpath-001" Invoice
  (:field [invoice/number "BP-2024-001"])
  (:field [invoice/status "draft"])
  (:field [invoice/amount 3000])
  (:field [invoice/issued-at 1712016000000])
  (:field [invoice/due-date 1714608000000])
  (:field [invoice/needs-review true]))

(define-record "invoice:lakeside-001" Invoice
  (:field [invoice/number "LF-2024-001"])
  (:field [invoice/status "draft"])
  (:field [invoice/amount 7200])
  (:field [invoice/issued-at 1712016000000])
  (:field [invoice/due-date 1714608000000])
  (:field [invoice/needs-review true]))

(define-record "invoice:carter-001" Invoice
  (:field [invoice/number "DC-2024-001"])
  (:field [invoice/status "sent"])
  (:field [invoice/amount 2100])
  (:field [invoice/issued-at 1709596800000])
  (:field [invoice/due-date 1712188800000])
  (:field [invoice/needs-review false]))

;; ---------------------------------------------------------------------------
;; Link Instances
;; ---------------------------------------------------------------------------

;; Attorney-client representation
(define-link represents "atty:amelia" "client:northstar"
  (:field [represents/since 1711929600000])
  (:field [represents/role "prospective-lead"]))

(define-link represents "atty:amelia" "client:brightpath"
  (:field [represents/since 1706745600000])
  (:field [represents/role "lead"]))

(define-link represents "atty:marco" "client:lakeside"
  (:field [represents/since 1710115200000])
  (:field [represents/role "lead"]))

(define-link represents "atty:amelia" "client:carter"
  (:field [represents/since 1709510400000])
  (:field [represents/role "lead"]))

;; Contacts at clients
(define-link contact-at "contact:maya" "client:northstar"
  (:field [contact-at/primary true]))

(define-link contact-at "contact:owen" "client:brightpath"
  (:field [contact-at/primary true]))

(define-link contact-at "contact:sofia" "client:lakeside"
  (:field [contact-at/primary true]))

(define-link contact-at "contact:dana" "client:carter"
  (:field [contact-at/primary true]))

;; Intake and conflicts
(define-link intake-for "intake:northstar" "client:northstar")
(define-link intake-for "intake:carter" "client:carter")
(define-link conflict-for "conflict:northstar" "client:northstar")
(define-link conflict-for "conflict:lakeside" "client:lakeside")
(define-link conflict-for "conflict:brightpath" "client:brightpath")
(define-link conflict-for "conflict:carter" "client:carter")

;; Matters to clients
(define-link matter-for "matter:northstar-general" "client:northstar")
(define-link matter-for "matter:brightpath-handbook" "client:brightpath")
(define-link matter-for "matter:lakeside-litigation" "client:lakeside")
(define-link matter-for "matter:carter-estate" "client:carter")

;; Matter staffing
(define-link matter-managed-by "matter:northstar-general" "atty:amelia")
(define-link matter-managed-by "matter:brightpath-handbook" "atty:amelia")
(define-link matter-managed-by "matter:lakeside-litigation" "atty:marco")
(define-link matter-managed-by "matter:carter-estate" "atty:amelia")

(define-link matter-supported-by "matter:northstar-general" "para:nora")
(define-link matter-supported-by "matter:brightpath-handbook" "para:eli")
(define-link matter-supported-by "matter:lakeside-litigation" "para:eli")
(define-link matter-supported-by "matter:carter-estate" "para:nora")

;; Engagement letters
(define-link engagement-letter-for "letter:northstar" "matter:northstar-general")
(define-link engagement-letter-for "letter:brightpath" "matter:brightpath-handbook")
(define-link engagement-letter-for "letter:lakeside" "matter:lakeside-litigation")
(define-link engagement-letter-for "letter:carter" "matter:carter-estate")

;; Tasks
(define-link task-for-matter "task:northstar-conflicts" "matter:northstar-general")
(define-link task-for-matter "task:northstar-letter" "matter:northstar-general")
(define-link task-for-matter "task:brightpath-policy" "matter:brightpath-handbook")
(define-link task-for-matter "task:lakeside-preservation" "matter:lakeside-litigation")
(define-link task-for-matter "task:lakeside-demand" "matter:lakeside-litigation")
(define-link task-for-matter "task:carter-draft" "matter:carter-estate")

;; Document requests
(define-link document-request-for "docreq:northstar-cap-table" "matter:northstar-general")
(define-link document-request-for "docreq:brightpath-handbook" "matter:brightpath-handbook")
(define-link document-request-for "docreq:lakeside-contracts" "matter:lakeside-litigation")
(define-link document-request-for "docreq:carter-accounts" "matter:carter-estate")

;; Invoices
(define-link invoice-for "invoice:brightpath-001" "matter:brightpath-handbook")
(define-link invoice-for "invoice:lakeside-001" "matter:lakeside-litigation")
(define-link invoice-for "invoice:carter-001" "matter:carter-estate")
```
