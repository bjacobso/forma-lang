# Documents

```lisp
(export i-9-employment-eligibility w-4-federal-tax-withholding employee-handbook-acknowledgement direct-deposit-authorization state-tax-withholding background-check-consent identity-document-verification)

;; =============================================================================
;; I-9 Employment Eligibility Verification - Canonical Document
;; =============================================================================

(define-document i-9-employment-eligibility
  (:description "Verify identity and employment authorization of new employees")

  (:page
    (page
      (:section-id "employee-information")
      (:assignee employee)
      (:completion-action (completion-action "start-i9-section-2" "Employee"))
      (:description "Employee Information and Attestation")
      (:field
        (field content :i9.section1_intro
          (:content "# Section 1: Employee Information and Attestation\n\n**Employees must complete and sign Section 1 no later than the first day of employment.**\n\nEnter your full legal name and other information exactly as it appears on your identity and employment authorization documents. You may use a preparer/translator to assist you.\n\n---")))
      (:field
        (field text :i9.last_name
          (:label "Last Name")
          (:required true)
          (:bind :employee/last-name)))
      (:field
        (field text :i9.first_name
          (:label "First Name")
          (:required true)
          (:bind :employee/first-name)))
      (:field (field text :i9.middle_initial (:label "Middle Initial")))
      (:field (field text :i9.other_last_names (:label "Other Last Names Used")))
      (:field (field text :i9.address (:label "Address") (:required true)))
      (:field
        (field date :i9.date_of_birth
          (:label "Date of Birth")
          (:required true)
          (:bind :employee/date-of-birth :transform string)))
      (:field
        (field text :i9.ssn
          (:label "Social Security Number")
          (:required true)
          (:bind :employee/ssn)))
      (:field
        (field text :i9.email
          (:label "Email Address")
          (:required true)
          (:bind :employee/email)))
      (:field
        (field text :i9.phone
          (:label "Phone Number")
          (:bind :employee/phone)))
      (:field
        (field content :i9.citizenship_intro
          (:content "## Citizenship/Immigration Status\n\nCheck one of the following boxes to attest to your citizenship or immigration status:")))
      (:field
        (field select :i9.citizenship_status
          (:label "Citizenship Status")
          (:required true)
          (:bind :employee/i9-citizenship-status)
          (:option (option "citizen" "A citizen of the United States"))
          (:option (option "noncitizen_national" "A noncitizen national of the United States"))
          (:option (option "permanent_resident" "A lawful permanent resident"))
          (:option (option "authorized_alien" "An alien authorized to work"))))
      (:field
        (field text :i9.alien_number
          (:label "Alien Registration Number/USCIS Number")))
      (:field (field text :i9.i94_number (:label "Form I-94 Admission Number")))
      (:field
        (field date :i9.work_auth_expiry
          (:label "Work Authorization Expiration Date")))
      (:field
        (field content :i9.attestation_notice
          (:content "## Attestation\n\nBy signing below, you attest under penalty of perjury that:\n- You are aware that federal law provides for imprisonment and/or fines for false statements\n- All information provided is true and correct\n- You are authorized to work in the United States")))
      (:field
        (field boolean :i9.employee_signature
          (:label "Employee Signature")
          (:required true)
          (:bind :employee/i9-section-1-signed)))))

  (:page
    (page
      (:section-id "employer-review")
      (:assignee employer)
      (:depends-on "employee-information")
      (:completion-action (completion-action "generate-i9-pdf" "Employee"))
      (:description "Employer Review and Verification")
      (:field
        (field content :i9.section2_intro
          (:content "# Section 2: Employer Review and Verification\n\n**Employers must complete Section 2 within 3 business days of the employee's first day of employment.**\n\nExamine one document from **List A** (which establishes both identity and employment authorization) OR examine one document from **List B** (identity) AND one from **List C** (employment authorization).\n\n---\n\n## Acceptable Documents\n\n### List A (Identity AND Employment Authorization)\n- U.S. Passport or U.S. Passport Card\n- Permanent Resident Card (Form I-551)\n- Foreign passport with Form I-94 and endorsement\n- Employment Authorization Document (Form I-766)\n\n### List B (Identity Only)\n- Driver's license or state ID card\n- School ID card with photograph\n- Voter registration card\n- U.S. military card or draft record\n\n### List C (Employment Authorization Only)\n- Social Security card (unrestricted)\n- Birth certificate\n- U.S. Citizen ID Card (Form I-197)\n- Native American tribal document\n\n---")))
      (:field
        (field content :i9.list_a_header
          (:content "## List A Document\n*Complete this section if the employee presented a List A document.*")))
      (:field (field text :i9.list_a_document (:label "List A Document Title")))
      (:field (field text :i9.list_a_doc_number (:label "Document Number")))
      (:field (field date :i9.list_a_expiry (:label "Expiration Date")))
      (:field
        (field text :i9.list_a_issuing_authority
          (:label "Issuing Authority")))
      (:field
        (field content :i9.list_bc_header
          (:content "## List B + List C Documents\n*Complete this section if the employee did NOT present a List A document.*")))
      (:field (field text :i9.list_b_document (:label "List B Document Title")))
      (:field (field text :i9.list_b_doc_number (:label "Document Number")))
      (:field (field date :i9.list_b_expiry (:label "Expiration Date")))
      (:field
        (field text :i9.list_b_issuing_authority
          (:label "Issuing Authority")))
      (:field (field text :i9.list_c_document (:label "List C Document Title")))
      (:field (field text :i9.list_c_doc_number (:label "Document Number")))
      (:field (field date :i9.list_c_expiry (:label "Expiration Date")))
      (:field
        (field text :i9.list_c_issuing_authority
          (:label "Issuing Authority")))
      (:field
        (field content :i9.employer_certification
          (:content "---\n\n## Employer Certification\n\nBy signing below, you certify that:\n- You have examined the documents presented by the employee\n- The documents appear to be genuine and relate to the employee\n- The employee is authorized to work in the United States")))
      (:field
        (field date :i9.employee_first_day
          (:label "Employee's First Day of Employment")
          (:required true)))
      (:field
        (field boolean :i9.employer_signature
          (:label "Employer Signature")
          (:required true)))
      (:field
        (field text :i9.employer_name
          (:label "Name of Employer or Authorized Representative")
          (:required true)))
      (:field (field text :i9.employer_title (:label "Title") (:required true)))
      (:field
        (field text :i9.employer_org_name
          (:label "Employer's Business or Organization Name")
          (:required true)))
      (:field
        (field text :i9.employer_org_address
          (:label "Employer's Business Address")
          (:required true))))))
```

```lisp
;; =============================================================================
;; I-9 Employment Eligibility - English Locale
;; =============================================================================

(define-document-locale i-9-employment-eligibility-en
    (:document i-9-employment-eligibility)
    (:locale en)
  (:role
    (role "employee"
      (:label "Employee")
      (:description "The new hire completing Section 1")))
  (:role
    (role "employer"
      (:label "Employer/Authorized Representative")
      (:description "Reviews identity and employment authorization documents")))

  (:section
    (section "employee-information"
      (:label "Employee Information and Attestation")))
  (:section
    (section "employer-review"
      (:label "Employer or Authorized Representative Review")))

  (:field (locale-field :i9.last_name (:label "Last Name")))
  (:field (locale-field :i9.first_name (:label "First Name")))
  (:field (locale-field :i9.middle_initial (:label "Middle Initial")))
  (:field (locale-field :i9.other_last_names (:label "Other Last Names Used")))
  (:field (locale-field :i9.address (:label "Address")))
  (:field (locale-field :i9.date_of_birth (:label "Date of Birth")))
  (:field (locale-field :i9.ssn (:label "Social Security Number")))
  (:field (locale-field :i9.email (:label "Email Address")))
  (:field (locale-field :i9.phone (:label "Phone Number")))
  (:field
    (locale-field :i9.citizenship_status
      (:label "Citizenship Status")
      (:option (option "citizen" "A citizen of the United States"))
      (:option (option "noncitizen_national" "A noncitizen national of the United States"))
      (:option (option "permanent_resident" "A lawful permanent resident"))
      (:option (option "authorized_alien" "An alien authorized to work"))))
  (:field
    (locale-field :i9.alien_number
      (:label "Alien Registration Number/USCIS Number")
      (:description "Required for permanent residents and authorized aliens")))
  (:field
    (locale-field :i9.i94_number
      (:label "Form I-94 Admission Number")
      (:description "Required for certain authorized aliens")))
  (:field
    (locale-field :i9.work_auth_expiry
      (:label "Work Authorization Expiration Date")
      (:description "Required for authorized aliens")))
  (:field
    (locale-field :i9.employee_signature
      (:label "Employee Signature")
      (:description "I attest, under penalty of perjury, that the information provided is true and correct")))
  (:field
    (locale-field :i9.list_a_document
      (:label "List A Document Title")
      (:description "e.g., U.S. Passport, Permanent Resident Card")))
  (:field (locale-field :i9.list_a_doc_number (:label "Document Number")))
  (:field (locale-field :i9.list_a_expiry (:label "Expiration Date")))
  (:field (locale-field :i9.list_a_issuing_authority (:label "Issuing Authority")))
  (:field
    (locale-field :i9.list_b_document
      (:label "List B Document Title (Identity)")
      (:description "e.g., Driver's License, State ID")))
  (:field (locale-field :i9.list_b_doc_number (:label "Document Number")))
  (:field (locale-field :i9.list_b_expiry (:label "Expiration Date")))
  (:field (locale-field :i9.list_b_issuing_authority (:label "Issuing Authority")))
  (:field
    (locale-field :i9.list_c_document
      (:label "List C Document Title (Employment)")
      (:description "e.g., Social Security Card, Birth Certificate")))
  (:field (locale-field :i9.list_c_doc_number (:label "Document Number")))
  (:field (locale-field :i9.list_c_expiry (:label "Expiration Date")))
  (:field (locale-field :i9.list_c_issuing_authority (:label "Issuing Authority")))
  (:field
    (locale-field :i9.employee_first_day
      (:label "Employee's First Day of Employment")))
  (:field
    (locale-field :i9.employer_signature
      (:label "Employer Signature")
      (:description "I attest that I have examined the documents and they appear genuine")))
  (:field
    (locale-field :i9.employer_name
      (:label "Name of Employer or Authorized Representative")))
  (:field (locale-field :i9.employer_title (:label "Title")))
  (:field
    (locale-field :i9.employer_org_name
      (:label "Employer's Business or Organization Name")))
  (:field
    (locale-field :i9.employer_org_address
      (:label "Employer's Business Address"))))
```

```lisp
;; =============================================================================
;; I-9 Employment Eligibility - Spanish Locale
;; =============================================================================

(define-document-locale i-9-employment-eligibility-es
    (:document i-9-employment-eligibility)
    (:locale es)
  (:role
    (role "employee"
      (:label "Empleado")
      (:description "El nuevo empleado que completa la Seccion 1")))
  (:role
    (role "employer"
      (:label "Empleador/Representante Autorizado")
      (:description "Revisa documentos de identidad y autorizacion de empleo")))

  (:section
    (section "employee-information"
      (:label "Informacion del Empleado y Declaracion")))
  (:section
    (section "employer-review"
      (:label "Revision del Empleador o Representante Autorizado")))

  (:field (locale-field :i9.last_name (:label "Apellido")))
  (:field (locale-field :i9.first_name (:label "Nombre")))
  (:field (locale-field :i9.middle_initial (:label "Inicial del Segundo Nombre")))
  (:field (locale-field :i9.other_last_names (:label "Otros Apellidos Usados")))
  (:field (locale-field :i9.address (:label "Direccion")))
  (:field (locale-field :i9.date_of_birth (:label "Fecha de Nacimiento")))
  (:field (locale-field :i9.ssn (:label "Numero de Seguro Social")))
  (:field (locale-field :i9.email (:label "Correo Electronico")))
  (:field (locale-field :i9.phone (:label "Numero de Telefono")))
  (:field
    (locale-field :i9.citizenship_status
      (:label "Estado de Ciudadania")
      (:option (option "citizen" "Ciudadano de los Estados Unidos"))
      (:option (option "noncitizen_national" "Nacional no ciudadano de los Estados Unidos"))
      (:option (option "permanent_resident" "Residente permanente legal"))
      (:option (option "authorized_alien" "Extranjero autorizado para trabajar"))))
  (:field
    (locale-field :i9.alien_number
      (:label "Numero de Registro de Extranjero/USCIS")
      (:description "Requerido para residentes permanentes y extranjeros autorizados")))
  (:field
    (locale-field :i9.i94_number
      (:label "Numero de Admision del Formulario I-94")
      (:description "Requerido para ciertos extranjeros autorizados")))
  (:field
    (locale-field :i9.work_auth_expiry
      (:label "Fecha de Vencimiento de Autorizacion de Trabajo")
      (:description "Requerido para extranjeros autorizados")))
  (:field
    (locale-field :i9.employee_signature
      (:label "Firma del Empleado")
      (:description "Declaro, bajo pena de perjurio, que la informacion proporcionada es verdadera y correcta")))
  (:field
    (locale-field :i9.list_a_document
      (:label "Titulo del Documento de Lista A")
      (:description "ej., Pasaporte de EE.UU., Tarjeta de Residente Permanente")))
  (:field (locale-field :i9.list_a_doc_number (:label "Numero de Documento")))
  (:field (locale-field :i9.list_a_expiry (:label "Fecha de Vencimiento")))
  (:field (locale-field :i9.list_a_issuing_authority (:label "Autoridad Emisora")))
  (:field
    (locale-field :i9.list_b_document
      (:label "Titulo del Documento de Lista B (Identidad)")
      (:description "ej., Licencia de Conducir, Identificacion Estatal")))
  (:field (locale-field :i9.list_b_doc_number (:label "Numero de Documento")))
  (:field (locale-field :i9.list_b_expiry (:label "Fecha de Vencimiento")))
  (:field (locale-field :i9.list_b_issuing_authority (:label "Autoridad Emisora")))
  (:field
    (locale-field :i9.list_c_document
      (:label "Titulo del Documento de Lista C (Empleo)")
      (:description "ej., Tarjeta de Seguro Social, Certificado de Nacimiento")))
  (:field (locale-field :i9.list_c_doc_number (:label "Numero de Documento")))
  (:field (locale-field :i9.list_c_expiry (:label "Fecha de Vencimiento")))
  (:field (locale-field :i9.list_c_issuing_authority (:label "Autoridad Emisora")))
  (:field
    (locale-field :i9.employee_first_day
      (:label "Primer Dia de Trabajo del Empleado")))
  (:field
    (locale-field :i9.employer_signature
      (:label "Firma del Empleador")
      (:description "Certifico que he examinado los documentos y parecen ser genuinos")))
  (:field
    (locale-field :i9.employer_name
      (:label "Nombre del Empleador o Representante Autorizado")))
  (:field (locale-field :i9.employer_title (:label "Titulo")))
  (:field
    (locale-field :i9.employer_org_name
      (:label "Nombre de la Empresa u Organizacion del Empleador")))
  (:field
    (locale-field :i9.employer_org_address
      (:label "Direccion de la Empresa del Empleador"))))

(define-document-localized i-9-employment-eligibility-localized
    (:document i-9-employment-eligibility)
  (:locales en es)
  (:default-locale en))
```

```lisp
;; =============================================================================
;; W-4 Federal Tax Withholding - Canonical Form
;; =============================================================================

(define-document w-4-federal-tax-withholding
  (:description "Complete this form to determine federal income tax withholding")

  (:page
    (page
      (:section-id "personal-information")
      (:assignee employee)
      (:description "Personal Information")
      (:field
        (field content :w4.intro
          (:content "# Form W-4: Employee's Withholding Certificate\n\nComplete this form so your employer can withhold the correct federal income tax from your pay.\n\n---\n\n## Step 1: Personal Information")))
      (:field (field text :w4.first_name (:label "First Name") (:required true)))
      (:field (field text :w4.last_name (:label "Last Name") (:required true)))
      (:field
        (field text :w4.ssn
          (:label "Social Security Number")
          (:required true)))
      (:field (field text :w4.address (:label "Home Address") (:required true)))
      (:field
        (field select :w4.filing_status
          (:label "Filing Status")
          (:required true)
          (:option (option "single" "Single or Married filing separately"))
          (:option
            (option "married" "Married filing jointly or Qualifying surviving spouse"))
          (:option (option "head_of_household" "Head of household"))))))

  (:page
    (page
      (:section-id "multiple-jobs")
      (:assignee employee)
      (:description "Multiple Jobs or Spouse Works")
      (:field
        (field content :w4.step2_intro
          (:content "## Step 2: Multiple Jobs or Spouse Works\n\nComplete this step if you:\n- Hold more than one job at a time, **OR**\n- Are married filing jointly and your spouse also works")))
      (:field
        (field boolean :w4.multiple_jobs_checkbox
          (:label "Multiple jobs checkbox")))))

  (:page
    (page
      (:section-id "claim-dependents")
      (:assignee employee)
      (:description "Claim Dependents")
      (:field
        (field content :w4.step3_intro
          (:content "## Step 3: Claim Dependents\n\nIf your total income will be $200,000 or less ($400,000 or less if married filing jointly), you may claim dependents.")))
      (:field
        (field text :w4.qualifying_children
          (:label "Number of qualifying children under age 17")))
      (:field
        (field text :w4.other_dependents
          (:label "Number of other dependents")))
      (:field
        (field text :w4.total_dependents_credit
          (:label "Total amount for dependents")))))

  (:page
    (page
      (:section-id "other-adjustments")
      (:assignee employee)
      (:description "Other Adjustments")
      (:field
        (field content :w4.step4_intro
          (:content "## Step 4: Other Adjustments (Optional)\n\nUse this section for more accurate withholding or if you prefer to have more or less tax withheld.")))
      (:field (field text :w4.other_income (:label "Other income")))
      (:field (field text :w4.deductions (:label "Deductions")))
      (:field
        (field text :w4.extra_withholding
          (:label "Extra withholding per pay period")))))

  (:page
    (page
      (:section-id "sign-here")
      (:assignee employee)
      (:completion-action (completion-action "complete-w4-task" "Employee"))
      (:description "Sign Here")
      (:field
        (field content :w4.step5_intro
          (:content "## Step 5: Sign Here\n\nUnder penalties of perjury, I declare that this certificate, to the best of my knowledge and belief, is true, correct, and complete.")))
      (:field
        (field boolean :w4.signature
          (:label "Employee Signature")
          (:required true))))))

(define-document-locale w-4-federal-tax-withholding-en
    (:document w-4-federal-tax-withholding)
    (:locale en)
  (:role (role "employee" (:label "Employee")))
  (:section (section "personal-information" (:label "Personal Information")))
  (:section (section "multiple-jobs" (:label "Multiple Jobs or Spouse Works")))
  (:section (section "claim-dependents" (:label "Claim Dependents")))
  (:section (section "other-adjustments" (:label "Other Adjustments")))
  (:section (section "sign-here" (:label "Sign Here")))
  (:field (locale-field :w4.first_name (:label "First Name and Middle Initial")))
  (:field (locale-field :w4.last_name (:label "Last Name")))
  (:field (locale-field :w4.ssn (:label "Social Security Number")))
  (:field
    (locale-field :w4.address
      (:label "Home Address (number, street, apt. no.)")))
  (:field
    (locale-field :w4.filing_status
      (:label "Filing Status")
      (:option (option "single" "Single or Married filing separately"))
      (:option
        (option "married" "Married filing jointly or Qualifying surviving spouse"))
      (:option (option "head_of_household" "Head of household"))))
  (:field
    (locale-field :w4.multiple_jobs_checkbox
      (:label "Check here if: You hold more than one job, OR you are married filing jointly and your spouse also works")
      (:description "Only check this box if there are only two jobs total.")))
  (:field
    (locale-field :w4.qualifying_children
      (:label "Number of qualifying children under age 17")
      (:description "Multiply by $2,000")))
  (:field
    (locale-field :w4.other_dependents
      (:label "Number of other dependents")
      (:description "Multiply by $500")))
  (:field
    (locale-field :w4.total_dependents_credit
      (:label "Total amount for dependents")
      (:description "Add qualifying children amount plus other dependents amount")))
  (:field
    (locale-field :w4.other_income
      (:label "Other income (not from jobs)")
      (:description "Income from interest, dividends, retirement, etc.")))
  (:field
    (locale-field :w4.deductions
      (:label "Deductions")
      (:description "Estimated deductions other than the standard deduction")))
  (:field
    (locale-field :w4.extra_withholding
      (:label "Extra withholding per pay period")
      (:description "Any additional tax you want withheld each pay period")))
  (:field
    (locale-field :w4.signature
      (:label "Employee Signature")
      (:description "Under penalties of perjury, I declare that this certificate is complete and correct"))))

(define-document-localized w-4-federal-tax-withholding-localized
    (:document w-4-federal-tax-withholding)
  (:locales en)
  (:default-locale en))
```

```lisp
;; =============================================================================
;; Employee Handbook Acknowledgement - Canonical Form
;; =============================================================================

(define-document employee-handbook-acknowledgement
  (:description "Confirm you have received and reviewed the employee handbook")
  (:page
    (page
      (:section-id "handbook-acknowledgement")
      (:assignee employee)
      (:completion-action (completion-action "complete-handbook-task" "Employee"))
      (:description "Handbook Acknowledgement")
      (:field
        (field content :handbook.intro
          (:content "# Employee Handbook Acknowledgement\n\nWelcome to the team! As part of your onboarding process, please review and acknowledge receipt of the Employee Handbook.\n\nThe Employee Handbook contains important information about:\n\n- **Company Policies** - Workplace conduct, dress code, attendance\n- **Benefits** - Health insurance, PTO, retirement plans\n- **Safety Procedures** - Emergency protocols, reporting incidents\n- **Employment Terms** - At-will employment, termination procedures\n\nPlease read the handbook carefully before completing this acknowledgement.\n\n---\n\n## Acknowledgements\n\nPlease check each box to confirm your understanding:")))
      (:field
        (field boolean :handbook.received
          (:label "I have received the employee handbook")
          (:required true)))
      (:field
        (field boolean :handbook.read
          (:label "I have read the employee handbook")
          (:required true)))
      (:field
        (field boolean :handbook.agree_to_comply
          (:label "I agree to comply with handbook policies")
          (:required true)))
      (:field
        (field content :handbook.at_will_notice
          (:content "---\n\n## Important Notice\n\n> **At-Will Employment:** Your employment with the company is at-will. This means that either you or the company may terminate the employment relationship at any time, with or without cause, and with or without notice.\n>\n> The Employee Handbook is not an employment contract and does not guarantee employment for any specific period of time.")))
      (:field
        (field boolean :handbook.understand_at_will
          (:label "I understand the at-will employment notice")
          (:required true)))
      (:field
        (field boolean :handbook.understand_changes
          (:label "I understand the handbook may be updated")
          (:required true)))
      (:field
        (field content :handbook.questions_section
          (:content "---\n\n## Questions?\n\nIf you have any questions about the handbook or company policies, please note them below or contact Human Resources directly.")))
      (:field (field text :handbook.questions (:label "Questions")))
      (:field
        (field content :handbook.signature_section
          (:content "---\n\n## Signature\n\nBy signing below, you confirm all of the acknowledgements above.")))
      (:field
        (field boolean :handbook.signature
          (:label "Employee Signature")
          (:required true))))))

(define-document-locale employee-handbook-acknowledgement-en
    (:document employee-handbook-acknowledgement)
    (:locale en)
  (:role (role "employee" (:label "Employee")))
  (:section (section "handbook-acknowledgement" (:label "Handbook Acknowledgement")))
  (:field
    (locale-field :handbook.received
      (:label "I have received a copy of the Employee Handbook")))
  (:field
    (locale-field :handbook.read
      (:label "I have read and understand the Employee Handbook")))
  (:field
    (locale-field :handbook.agree_to_comply
      (:label "I agree to comply with all policies in the Employee Handbook")))
  (:field
    (locale-field :handbook.understand_at_will
      (:label "I understand the at-will employment relationship")))
  (:field
    (locale-field :handbook.understand_changes
      (:label "I understand the handbook may be changed at any time at the company's discretion")))
  (:field
    (locale-field :handbook.questions
      (:label "Questions or Comments")))
  (:field
    (locale-field :handbook.signature
      (:label "Employee Signature")
      (:description "By signing, you confirm all of the acknowledgements above"))))

(define-document-localized employee-handbook-acknowledgement-localized
    (:document employee-handbook-acknowledgement)
  (:locales en)
  (:default-locale en))
```

```lisp
;; =============================================================================
;; Direct Deposit Authorization - Canonical Form
;; =============================================================================

(define-document direct-deposit-authorization
  (:description "Authorize direct deposit of payroll funds to employee bank account")

  (:page
    (page
      (:section-id "bank-information")
      (:assignee employee)
      (:description "Bank Information")
      (:field
        (field content :dd.intro
          (:content "# Direct Deposit Authorization\n\nPlease provide your bank account information below to set up direct deposit for your payroll. Your information is encrypted and stored securely.\n\n---")))
      (:field (field text :dd.bank_name (:label "Bank Name") (:required true)))
      (:field
        (field text :dd.routing_number
          (:label "Routing Number")
          (:required true)))
      (:field
        (field text :dd.account_number
          (:label "Account Number")
          (:required true)))
      (:field
        (field select :dd.account_type
          (:label "Account Type")
          (:required true)
          (:option (option "checking" "Checking"))
          (:option (option "savings" "Savings"))))
      (:field
        (field content :dd.authorization_notice
          (:content "---\n\n## Authorization\n\nBy signing below, I authorize my employer to deposit my pay directly into the bank account specified above. I understand that this authorization will remain in effect until I provide written notice of cancellation.")))
      (:field
        (field boolean :dd.employee_signature
          (:label "Employee Signature")
          (:required true)))))

  (:page
    (page
      (:section-id "employer-verification")
      (:assignee employer)
      (:depends-on "bank-information")
      (:completion-action (completion-action "complete-direct-deposit-task" "Employee"))
      (:description "Employer Verification")
      (:field
        (field content :dd.verification_intro
          (:content "# Employer Verification\n\nVerify the employee's bank information and confirm prenote status.\n\n---")))
      (:field (field text :dd.verified_by (:label "Verified By") (:required true)))
      (:field
        (field date :dd.verification_date
          (:label "Verification Date")
          (:required true)))
      (:field
        (field select :dd.prenote_status
          (:label "Prenote Status")
          (:required true)
          (:option (option "pending" "Pending"))
          (:option (option "verified" "Verified"))
          (:option (option "failed" "Failed"))))
      (:field (field text :dd.notes (:label "Notes"))))))

(define-document-locale direct-deposit-authorization-en
    (:document direct-deposit-authorization)
    (:locale en)
  (:role (role "employee" (:label "Employee")))
  (:role (role "employer" (:label "Employer/Payroll")))
  (:section (section "bank-information" (:label "Bank Information")))
  (:section (section "employer-verification" (:label "Employer Verification")))
  (:field
    (locale-field :dd.bank_name
      (:label "Bank or Financial Institution Name")))
  (:field
    (locale-field :dd.routing_number
      (:label "Routing Number (9 digits)")))
  (:field (locale-field :dd.account_number (:label "Account Number")))
  (:field
    (locale-field :dd.account_type
      (:label "Account Type")
      (:option (option "checking" "Checking Account"))
      (:option (option "savings" "Savings Account"))))
  (:field
    (locale-field :dd.employee_signature
      (:label "Employee Signature")
      (:description "I authorize direct deposit to the account specified above")))
  (:field (locale-field :dd.verified_by (:label "Verified By")))
  (:field (locale-field :dd.verification_date (:label "Verification Date")))
  (:field
    (locale-field :dd.prenote_status
      (:label "Prenote Status")
      (:option (option "pending" "Pending Verification"))
      (:option (option "verified" "Verified"))
      (:option (option "failed" "Verification Failed"))))
  (:field (locale-field :dd.notes (:label "Notes"))))

(define-document-localized direct-deposit-authorization-localized
    (:document direct-deposit-authorization)
  (:locales en)
  (:default-locale en))
```

```lisp
;; =============================================================================
;; State Tax Withholding - Canonical Form
;; =============================================================================

(define-document state-tax-withholding
  (:description "Employee state income tax withholding elections")
  (:page
    (page
      (:section-id "state-tax-info")
      (:assignee employee)
      (:completion-action (completion-action "complete-state-tax-task" "Employee"))
      (:description "State Tax Information")
      (:field
        (field content :st.intro
          (:content "# State Tax Withholding\n\nComplete this form to indicate your state income tax withholding preferences. This information will be used to calculate state tax deductions from your paycheck.\n\n---")))
      (:field
        (field select :st.state
          (:label "State")
          (:required true)
          (:option (option "AL" "Alabama"))
          (:option (option "AK" "Alaska"))
          (:option (option "AZ" "Arizona"))
          (:option (option "AR" "Arkansas"))
          (:option (option "CA" "California"))
          (:option (option "CO" "Colorado"))
          (:option (option "CT" "Connecticut"))
          (:option (option "DE" "Delaware"))
          (:option (option "FL" "Florida"))
          (:option (option "GA" "Georgia"))
          (:option (option "HI" "Hawaii"))
          (:option (option "ID" "Idaho"))
          (:option (option "IL" "Illinois"))
          (:option (option "IN" "Indiana"))
          (:option (option "IA" "Iowa"))
          (:option (option "KS" "Kansas"))
          (:option (option "KY" "Kentucky"))
          (:option (option "LA" "Louisiana"))
          (:option (option "ME" "Maine"))
          (:option (option "MD" "Maryland"))
          (:option (option "MA" "Massachusetts"))
          (:option (option "MI" "Michigan"))
          (:option (option "MN" "Minnesota"))
          (:option (option "MS" "Mississippi"))
          (:option (option "MO" "Missouri"))
          (:option (option "MT" "Montana"))
          (:option (option "NE" "Nebraska"))
          (:option (option "NV" "Nevada"))
          (:option (option "NH" "New Hampshire"))
          (:option (option "NJ" "New Jersey"))
          (:option (option "NM" "New Mexico"))
          (:option (option "NY" "New York"))
          (:option (option "NC" "North Carolina"))
          (:option (option "ND" "North Dakota"))
          (:option (option "OH" "Ohio"))
          (:option (option "OK" "Oklahoma"))
          (:option (option "OR" "Oregon"))
          (:option (option "PA" "Pennsylvania"))
          (:option (option "RI" "Rhode Island"))
          (:option (option "SC" "South Carolina"))
          (:option (option "SD" "South Dakota"))
          (:option (option "TN" "Tennessee"))
          (:option (option "TX" "Texas"))
          (:option (option "UT" "Utah"))
          (:option (option "VT" "Vermont"))
          (:option (option "VA" "Virginia"))
          (:option (option "WA" "Washington"))
          (:option (option "WV" "West Virginia"))
          (:option (option "WI" "Wisconsin"))
          (:option (option "WY" "Wyoming"))))
      (:field
        (field select :st.filing_status
          (:label "Filing Status")
          (:required true)
          (:option (option "single" "Single"))
          (:option (option "married" "Married"))
          (:option (option "married_separate" "Married Filing Separately"))
          (:option (option "head_of_household" "Head of Household"))))
      (:field
        (field text :st.allowances
          (:label "Number of Allowances")
          (:required true)))
      (:field
        (field text :st.additional_withholding
          (:label "Additional Withholding")))
      (:field
        (field boolean :st.exempt
          (:label "Exempt from state withholding")))
      (:field
        (field content :st.certification_notice
          (:content "---\n\n## Certification\n\nUnder penalties of perjury, I certify that the information on this form is true, correct, and complete.")))
      (:field
        (field boolean :st.employee_signature
          (:label "Employee Signature")
          (:required true))))))

(define-document-locale state-tax-withholding-en
    (:document state-tax-withholding)
    (:locale en)
  (:role (role "employee" (:label "Employee")))
  (:section (section "state-tax-info" (:label "State Tax Information")))
  (:field (locale-field :st.state (:label "Work State")))
  (:field
    (locale-field :st.filing_status
      (:label "State Filing Status")
      (:option (option "single" "Single"))
      (:option (option "married" "Married Filing Jointly"))
      (:option (option "married_separate" "Married Filing Separately"))
      (:option (option "head_of_household" "Head of Household"))))
  (:field
    (locale-field :st.allowances
      (:label "Number of Allowances")
      (:description "Enter the number of withholding allowances")))
  (:field
    (locale-field :st.additional_withholding
      (:label "Additional Withholding Amount")
      (:description "Additional amount to withhold per pay period")))
  (:field
    (locale-field :st.exempt
      (:label "Claim Exemption")
      (:description "Check if you are exempt from state income tax withholding")))
  (:field
    (locale-field :st.employee_signature
      (:label "Employee Signature")
      (:description "Under penalties of perjury, I certify this information is correct"))))

(define-document-localized state-tax-withholding-localized
    (:document state-tax-withholding)
  (:locales en)
  (:default-locale en))
```

```lisp
;; =============================================================================
;; Background Check Consent - Canonical Form
;; =============================================================================

(define-document background-check-consent
  (:description "Employee authorization for background check verification")
  (:page
    (page
      (:section-id "consent-and-authorization")
      (:assignee employee)
      (:completion-action (completion-action "complete-bgc-task" "Employee"))
      (:description "Consent and Authorization")
      (:field
        (field text :bgc.full_name
          (:label "Full Legal Name")
          (:required true)))
      (:field (field text :bgc.email (:label "Email Address") (:required true)))
      (:field
        (field boolean :bgc.consent_acknowledgment
          (:label "I consent to a background check being performed")
          (:required true)))
      (:field
        (field boolean :bgc.fcra_acknowledgment
          (:label "I acknowledge my rights under the FCRA")
          (:required true)))
      (:field (field boolean :bgc.signature (:label "Signature") (:required true))))))

(define-document-locale background-check-consent-en
    (:document background-check-consent)
    (:locale en)
  (:section (section "consent-and-authorization" (:label "Consent and Authorization")))
  (:field (locale-field :bgc.full_name (:label "Full Legal Name")))
  (:field (locale-field :bgc.email (:label "Email Address")))
  (:field
    (locale-field :bgc.consent_acknowledgment
      (:label "I consent to a background check being performed")))
  (:field
    (locale-field :bgc.fcra_acknowledgment
      (:label "I acknowledge my rights under the Fair Credit Reporting Act (FCRA)")))
  (:field (locale-field :bgc.signature (:label "Signature"))))

(define-document-localized background-check-consent-localized
    (:document background-check-consent)
  (:locales en)
  (:default-locale en))
```

```lisp
;; =============================================================================
;; Identity Document Verification - Canonical Form
;; =============================================================================

(define-document identity-document-verification
  (:description "Upload and verify identity documents with HR review")

  (:page
    (page
      (:section-id "document-upload")
      (:assignee employee)
      (:description "Document Upload")
      (:field
        (field select :idv.primary_doc_type
          (:label "Primary Document Type")
          (:required true)
          (:option (option "passport" "Passport"))
          (:option (option "drivers_license" "Driver's License"))
          (:option (option "state_id" "State ID"))
          (:option (option "national_id" "National ID"))))
      (:field
        (field text :idv.primary_doc_file
          (:label "Primary Document Upload")
          (:required true)))
      (:field
        (field select :idv.secondary_doc_type
          (:label "Secondary Document Type")
          (:option (option "utility_bill" "Utility Bill"))
          (:option (option "bank_statement" "Bank Statement"))
          (:option (option "tax_document" "Tax Document"))))
      (:field
        (field text :idv.secondary_doc_file
          (:label "Secondary Document Upload")))))

  (:page
    (page
      (:section-id "verification-results")
      (:assignee system)
      (:depends-on "document-upload")
      (:description "Verification Results")
      (:field
        (field text :idv.verification_status
          (:label "Verification Status")))
      (:field
        (field text :idv.confidence_score
          (:label "Confidence Score")))
      (:field
        (field text :idv.verification_details
          (:label "Verification Details")))))

  (:page
    (page
      (:section-id "hr-review")
      (:assignee hr-admin)
      (:depends-on "verification-results")
      (:completion-action (completion-action "complete-idv-task" "Employee"))
      (:description "HR Review")
      (:field
        (field select :idv.review_decision
          (:label "Review Decision")
          (:required true)
          (:option (option "approved" "Approved"))
          (:option (option "rejected" "Rejected"))
          (:option (option "additional_docs_required" "Additional Documents Required"))))
      (:field (field text :idv.review_notes (:label "Review Notes"))))))

(define-document-locale identity-document-verification-en
    (:document identity-document-verification)
    (:locale en)
  (:section (section "document-upload" (:label "Document Upload")))
  (:section (section "verification-results" (:label "Verification Results")))
  (:section (section "hr-review" (:label "HR Review")))
  (:field
    (locale-field :idv.primary_doc_type
      (:label "Primary Document Type")
      (:option (option "passport" "Passport"))
      (:option (option "drivers_license" "Driver's License"))
      (:option (option "state_id" "State ID"))
      (:option (option "national_id" "National ID"))))
  (:field
    (locale-field :idv.primary_doc_file
      (:label "Primary Document Upload")))
  (:field
    (locale-field :idv.secondary_doc_type
      (:label "Secondary Document Type")
      (:option (option "utility_bill" "Utility Bill"))
      (:option (option "bank_statement" "Bank Statement"))
      (:option (option "tax_document" "Tax Document"))))
  (:field
    (locale-field :idv.secondary_doc_file
      (:label "Secondary Document Upload")))
  (:field
    (locale-field :idv.verification_status
      (:label "Verification Status")))
  (:field
    (locale-field :idv.confidence_score
      (:label "Confidence Score")))
  (:field
    (locale-field :idv.verification_details
      (:label "Verification Details")))
  (:field
    (locale-field :idv.review_decision
      (:label "Review Decision")
      (:option (option "approved" "Approved"))
      (:option (option "rejected" "Rejected"))
      (:option (option "additional_docs_required" "Additional Documents Required"))))
  (:field (locale-field :idv.review_notes (:label "Review Notes"))))

(define-document-localized identity-document-verification-localized
    (:document identity-document-verification)
  (:locales en)
  (:default-locale en))
```

```lisp
;; =============================================================================
;; PDF Mapping Definitions - Canonical Form
;; =============================================================================

```
