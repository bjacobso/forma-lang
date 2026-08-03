# Documents

```lisp
(export union-authorization-card)

;; =============================================================================
;; Union Authorization Card
;; =============================================================================

(define-document union-authorization-card
  (:description "Collect employee acknowledgement, dues authorization, and electronic signature for a covered CBA placement")

  (:page
    (page
      (:section-id "employee-authorization")
      (:assignee employee)
      (:completion-action (completion-action "submit-union-authorization-card" "Employee"))
      (:description "Employee Authorization")
      (:field
        (field content :unionauth.intro
          (:content "# Union Authorization Card\n\nReview the covered position, bargaining unit, and authorization language. Confirm your information and sign electronically to complete this required labor-relations task.\n\n---")))
      (:field (field text :unionauth.employee_name (:label "Employee Name") (:required true)))
      (:field (field text :unionauth.employee_email (:label "Employee Email") (:bind :employee/email)))
      (:field (field text :unionauth.employee_phone (:label "Employee Phone") (:bind :employee/phone)))
      (:field (field textarea :unionauth.employee_address (:label "Employee Address") (:required true) (:bind :employee/address)))
      (:field (field text :unionauth.global_hr_id (:label "Global HR ID") (:bind :employee/global-hr-id)))
      (:field (field text :unionauth.cba_identifier (:label "CBA Identifier") (:bind :employee/cba-id)))
      (:field
        (field content :unionauth.authorization_text
          (:content "## Authorization\n\nI acknowledge that my position is covered by a collective bargaining agreement. I authorize the employer to process the applicable union authorization and dues deduction according to the active agreement, payroll policy, and any legally required notices.\n\nThis demonstration text is representative and client-neutral; production implementations use the approved language for the applicable CBA and card template version.")))
      (:field
        (field boolean :unionauth.acknowledgement
          (:label "I have reviewed the CBA authorization information")
          (:required true)))
      (:field
        (field boolean :unionauth.dues_authorization
          (:label "I authorize applicable union dues deduction for the covered bargaining unit")
          (:required true)))
      (:field
        (field boolean :unionauth.employee_signature
          (:label "Electronic Signature")
          (:required true)
          (:bind :employee/union-card-signed)))
      (:field (field date :unionauth.signature_date (:label "Signature Date") (:required true))))))

(define-document-locale union-authorization-card-en
    (:document union-authorization-card)
    (:locale en)
  (:role
    (role "employee"
      (:label "Employee")
      (:description "The worker completing the union authorization card")))
  (:section
    (section "employee-authorization"
      (:label "Employee Authorization")))
  (:field (locale-field :unionauth.employee_name (:label "Employee Name")))
  (:field (locale-field :unionauth.employee_email (:label "Employee Email")))
  (:field (locale-field :unionauth.employee_phone (:label "Employee Phone")))
  (:field (locale-field :unionauth.employee_address (:label "Employee Address")))
  (:field (locale-field :unionauth.global_hr_id (:label "Global HR ID")))
  (:field (locale-field :unionauth.cba_identifier (:label "CBA Identifier")))
  (:field (locale-field :unionauth.acknowledgement (:label "Acknowledgement")))
  (:field (locale-field :unionauth.dues_authorization (:label "Dues Authorization")))
  (:field (locale-field :unionauth.employee_signature (:label "Electronic Signature")))
  (:field (locale-field :unionauth.signature_date (:label "Signature Date"))))
```
