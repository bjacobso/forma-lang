# Documents

```lisp
(export client-intake-form engagement-letter)

;; =============================================================================
;; Client Intake Form
;; =============================================================================
;;
;; A multi-party intake form. The client contact provides background,
;; counterparties, and goals. The firm completes risk, conflict, and engagement
;; routing fields before a matter is opened.
;;

(define-document client-intake-form
  (:description "Collect prospective client background, adverse parties, deadlines, and routing information")

  (:page
    (page
      (:section-id "client-background")
      (:assignee client-contact)
      (:completion-action (completion-action "submit-intake-packet" "Client"))
      (:description "Client Background")
      (:field
        (field content :intake.background_intro
          (:content "# Client Intake\n\nPlease provide the information the firm needs to evaluate representation, run conflicts, and prepare an engagement letter.\n\n---")))
      (:field (field text :intake.client_name (:label "Client Legal Name") (:required true) (:bind :client/name)))
      (:field
        (field select :intake.client_type
          (:label "Client Type")
          (:required true)
          (:bind :client/type)
          (:option (option "business" "Business"))
          (:option (option "individual" "Individual"))
          (:option (option "nonprofit" "Nonprofit"))
          (:option (option "government" "Government"))))
      (:field (field text :intake.industry (:label "Industry or Context") (:bind :client/industry)))
      (:field (field text :intake.primary_contact_name (:label "Primary Contact Name") (:required true)))
      (:field (field text :intake.primary_contact_title (:label "Primary Contact Title")))
      (:field (field text :intake.primary_contact_email (:label "Primary Contact Email") (:required true) (:bind :client/email)))
      (:field (field text :intake.primary_contact_phone (:label "Primary Contact Phone") (:bind :client/phone)))
      (:field
        (field content :intake.matter_intro
          (:content "---\n\n## Legal Need\n\nDescribe the legal work requested and any deadlines or counterparties the firm should know about.")))
      (:field
        (field select :intake.practice_area
          (:label "Likely Practice Area")
          (:required true)
          (:option (option "corporate" "Corporate"))
          (:option (option "employment" "Employment"))
          (:option (option "litigation" "Litigation"))
          (:option (option "real-estate" "Real Estate"))
          (:option (option "estate-planning" "Estate Planning"))
          (:option (option "other" "Other"))))
      (:field (field textarea :intake.matter_summary (:label "Matter Summary") (:required true)))
      (:field (field textarea :intake.adverse_parties (:label "Known Adverse Parties or Related Parties") (:required true)))
      (:field (field date :intake.next_deadline (:label "Next Known Deadline")))
      (:field (field textarea :intake.documents_available (:label "Documents Already Available")))))

  (:page
    (page
      (:section-id "firm-review")
      (:assignee firm-staff)
      (:depends-on "client-background")
      (:completion-action (completion-action "complete-firm-review" "Client"))
      (:description "Firm Review")
      (:field
        (field content :intake.review_intro
          (:content "# Firm Review\n\nComplete internal routing before representation begins.\n\n---")))
      (:field
        (field select :intake.conflict_status
          (:label "Conflict Check Status")
          (:required true)
          (:option (option "pending" "Pending"))
          (:option (option "cleared" "Cleared"))
          (:option (option "needs-review" "Needs Attorney Review"))
          (:option (option "blocked" "Blocked"))))
      (:field
        (field select :intake.risk_level
          (:label "Client Risk Level")
          (:required true)
          (:bind :client/risk-level)
          (:option (option "low" "Low"))
          (:option (option "medium" "Medium"))
          (:option (option "high" "High"))))
      (:field
        (field select :intake.fee_arrangement
          (:label "Fee Arrangement")
          (:required true)
          (:option (option "hourly" "Hourly"))
          (:option (option "flat-fee" "Flat Fee"))
          (:option (option "retainer" "Monthly Retainer"))
          (:option (option "contingency" "Contingency"))))
      (:field (field number :intake.initial_budget (:label "Initial Budget")))
      (:field (field textarea :intake.scope_notes (:label "Scope Notes") (:required true)))
      (:field
        (field boolean :intake.approved_for_engagement
          (:label "Approved for Engagement Letter")
          (:required true))))))
```

```lisp
;; =============================================================================
;; Engagement Letter
;; =============================================================================
;;
;; A lightweight engagement letter artifact that captures scope, fee structure,
;; conflict acknowledgement, and client acceptance.
;;

(define-document engagement-letter
  (:description "Confirm scope, fees, responsibilities, and client acceptance for a matter")

  (:page
    (page
      (:section-id "client-acceptance")
      (:assignee client-contact)
      (:completion-action (completion-action "complete-engagement-letter" "EngagementLetter"))
      (:description "Client Acceptance")
      (:field
        (field content :engagement.intro
          (:content "# Engagement Letter\n\nReview the proposed scope, fee terms, and responsibilities. Signing confirms that the client authorizes the firm to begin work on the matter.\n\n---")))
      (:field (field text :engagement.client_name (:label "Client Name") (:required true)))
      (:field (field text :engagement.matter_title (:label "Matter Title") (:required true)))
      (:field (field textarea :engagement.scope_summary (:label "Scope of Work") (:required true) (:bind :engagementletter/scope-summary)))
      (:field
        (field select :engagement.fee_type
          (:label "Fee Type")
          (:required true)
          (:bind :engagementletter/fee-type)
          (:option (option "hourly" "Hourly"))
          (:option (option "flat-fee" "Flat Fee"))
          (:option (option "retainer" "Monthly Retainer"))
          (:option (option "contingency" "Contingency"))))
      (:field (field number :engagement.budget (:label "Estimated Budget")))
      (:field
        (field boolean :engagement.conflict_acknowledgement
          (:label "I acknowledge that representation begins only after conflict clearance and firm acceptance")
          (:required true)))
      (:field
        (field boolean :engagement.client_signature
          (:label "Client Signature")
          (:required true))))))
```

```lisp
;; =============================================================================
;; Law Firm Documents - English Locale
;; =============================================================================

(define-document-locale client-intake-form-en
    (:document client-intake-form)
    (:locale en)
  (:role
    (role "client-contact"
      (:label "Client Contact")
      (:description "The client representative completing intake")))
  (:role
    (role "firm-staff"
      (:label "Firm Staff")
      (:description "The intake coordinator or attorney reviewing the packet")))
  (:section
    (section "client-background"
      (:label "Client Background")))
  (:section
    (section "firm-review"
      (:label "Firm Review")))
  (:field (locale-field :intake.client_name (:label "Client Legal Name")))
  (:field (locale-field :intake.client_type (:label "Client Type")))
  (:field (locale-field :intake.industry (:label "Industry or Context")))
  (:field (locale-field :intake.primary_contact_name (:label "Primary Contact Name")))
  (:field (locale-field :intake.primary_contact_title (:label "Primary Contact Title")))
  (:field (locale-field :intake.primary_contact_email (:label "Primary Contact Email")))
  (:field (locale-field :intake.primary_contact_phone (:label "Primary Contact Phone")))
  (:field (locale-field :intake.practice_area (:label "Likely Practice Area")))
  (:field (locale-field :intake.matter_summary (:label "Matter Summary")))
  (:field (locale-field :intake.adverse_parties (:label "Known Adverse Parties or Related Parties")))
  (:field (locale-field :intake.next_deadline (:label "Next Known Deadline")))
  (:field (locale-field :intake.documents_available (:label "Documents Already Available")))
  (:field (locale-field :intake.conflict_status (:label "Conflict Check Status")))
  (:field (locale-field :intake.risk_level (:label "Client Risk Level")))
  (:field (locale-field :intake.fee_arrangement (:label "Fee Arrangement")))
  (:field (locale-field :intake.initial_budget (:label "Initial Budget")))
  (:field (locale-field :intake.scope_notes (:label "Scope Notes")))
  (:field (locale-field :intake.approved_for_engagement (:label "Approved for Engagement Letter"))))

(define-document-locale engagement-letter-en
    (:document engagement-letter)
    (:locale en)
  (:role
    (role "client-contact"
      (:label "Client Contact")
      (:description "The person authorized to accept the engagement")))
  (:section
    (section "client-acceptance"
      (:label "Client Acceptance")))
  (:field (locale-field :engagement.client_name (:label "Client Name")))
  (:field (locale-field :engagement.matter_title (:label "Matter Title")))
  (:field (locale-field :engagement.scope_summary (:label "Scope of Work")))
  (:field (locale-field :engagement.fee_type (:label "Fee Type")))
  (:field (locale-field :engagement.budget (:label "Estimated Budget")))
  (:field (locale-field :engagement.conflict_acknowledgement (:label "Conflict Acknowledgement")))
  (:field (locale-field :engagement.client_signature (:label "Client Signature"))))
```
