# Seed Data

```lisp
(export works-at placed-at serves-client governed-by assigned-task has-document)

;; =============================================================================
;; Staffing Agency Ontology - Entities (Seed Data)
;; =============================================================================
;;
;; 41 record instances + 29 link instances.
;; Timestamps use fixed epoch ms values.
;;

;; ---------------------------------------------------------------------------
;; Addresses
;; ---------------------------------------------------------------------------

(define-record "addr:employer-hq" Address
  (:field [address/street "100 Staffing Plaza"])
  (:field [address/city "Austin"])
  (:field [address/state "TX"])
  (:field [address/zip "78701"])
  (:field [address/country "USA"]))

(define-record "addr:client-techcorp" Address
  (:field [address/street "200 Tech Drive"])
  (:field [address/city "San Francisco"])
  (:field [address/state "CA"])
  (:field [address/zip "94102"])
  (:field [address/country "USA"]))

(define-record "addr:client-retail" Address
  (:field [address/street "300 Commerce Way"])
  (:field [address/city "Dallas"])
  (:field [address/state "TX"])
  (:field [address/zip "75201"])
  (:field [address/country "USA"]))

(define-record "addr:emp-alice" Address
  (:field [address/street "123 Main St"])
  (:field [address/city "Austin"])
  (:field [address/state "TX"])
  (:field [address/zip "78702"])
  (:field [address/country "USA"]))

;; ---------------------------------------------------------------------------
;; Employers (Staffing Agencies)
;; ---------------------------------------------------------------------------

(define-record "employer:acme" Employer
  (:field [employer/name "Acme Staffing"])
  (:field [employer/ein "12-3456789"])
  (:field [employer/phone "+1-512-555-0100"])
  (:field [employer/email "hr@acmestaffing.com"])
  (:field [employer/status "active"])
  (:field [employer/address "addr:employer-hq"]))

(define-record "employer:premier" Employer
  (:field [employer/name "Premier Workforce"])
  (:field [employer/ein "98-7654321"])
  (:field [employer/phone "+1-512-555-0200"])
  (:field [employer/email "hr@premierworkforce.com"])
  (:field [employer/status "active"]))

;; ---------------------------------------------------------------------------
;; Clients (End Employers)
;; ---------------------------------------------------------------------------

(define-record "client:techcorp" Client
  (:field [client/name "TechCorp Industries"])
  (:field [client/industry "Technology"])
  (:field [client/phone "+1-415-555-0100"])
  (:field [client/email "staffing@techcorp.com"])
  (:field [client/status "active"])
  (:field [client/address "addr:client-techcorp"]))

(define-record "client:retail-giant" Client
  (:field [client/name "Retail Giant Inc"])
  (:field [client/industry "Retail"])
  (:field [client/phone "+1-214-555-0100"])
  (:field [client/email "hr@retailgiant.com"])
  (:field [client/status "active"])
  (:field [client/address "addr:client-retail"]))

(define-record "client:healthcare" Client
  (:field [client/name "Healthcare Plus"])
  (:field [client/industry "Healthcare"])
  (:field [client/phone "+1-512-555-0300"])
  (:field [client/email "staffing@healthcareplus.com"])
  (:field [client/status "prospect"]))

;; ---------------------------------------------------------------------------
;; Job Types
;; ---------------------------------------------------------------------------

(define-record "job:software-dev" JobType
  (:field [jobtype/name "Software Developer"])
  (:field [jobtype/description "Full-stack software development"])
  (:field [jobtype/hourly-rate 75])
  (:field [jobtype/bill-rate 125]))

(define-record "job:warehouse" JobType
  (:field [jobtype/name "Warehouse Associate"])
  (:field [jobtype/description "General warehouse operations"])
  (:field [jobtype/hourly-rate 18])
  (:field [jobtype/bill-rate 28]))

(define-record "job:admin" JobType
  (:field [jobtype/name "Administrative Assistant"])
  (:field [jobtype/description "Office administrative support"])
  (:field [jobtype/hourly-rate 22])
  (:field [jobtype/bill-rate 35]))

(define-record "job:nurse" JobType
  (:field [jobtype/name "Registered Nurse"])
  (:field [jobtype/description "Healthcare nursing services"])
  (:field [jobtype/hourly-rate 45])
  (:field [jobtype/bill-rate 75]))

;; ---------------------------------------------------------------------------
;; Employees (Workers)
;; ---------------------------------------------------------------------------

(define-record "emp:alice" Employee
  (:field [employee/first-name "Alice"])
  (:field [employee/last-name "Johnson"])
  (:field [employee/email "alice.johnson@email.com"])
  (:field [employee/phone "+1-512-555-1001"])
  (:field [employee/status "active"])
  (:field [employee/hire-date 1672531200000])
  (:field [employee/address "addr:emp-alice"]))

(define-record "emp:bob" Employee
  (:field [employee/first-name "Bob"])
  (:field [employee/last-name "Williams"])
  (:field [employee/email "bob.williams@email.com"])
  (:field [employee/phone "+1-512-555-1002"])
  (:field [employee/status "active"])
  (:field [employee/hire-date 1688515200000]))

(define-record "emp:carol" Employee
  (:field [employee/first-name "Carol"])
  (:field [employee/last-name "Martinez"])
  (:field [employee/email "carol.martinez@email.com"])
  (:field [employee/phone "+1-512-555-1003"])
  (:field [employee/status "active"])
  (:field [employee/hire-date 1696291200000]))

(define-record "emp:david" Employee
  (:field [employee/first-name "David"])
  (:field [employee/last-name "Chen"])
  (:field [employee/email "david.chen@email.com"])
  (:field [employee/status "onboarding"])
  (:field [employee/hire-date 1704067200000]))

(define-record "emp:emma" Employee
  (:field [employee/first-name "Emma"])
  (:field [employee/last-name "Garcia"])
  (:field [employee/email "emma.garcia@email.com"])
  (:field [employee/status "onboarding"])
  (:field [employee/hire-date 1704240000000]))

(define-record "emp:frank" Employee
  (:field [employee/first-name "Frank"])
  (:field [employee/last-name "Brown"])
  (:field [employee/email "frank.brown@email.com"])
  (:field [employee/status "inactive"])
  (:field [employee/hire-date 1660348800000]))

;; ---------------------------------------------------------------------------
;; Placements
;; ---------------------------------------------------------------------------

(define-record "placement:alice-techcorp" Placement
  (:field [placement/start-date 1672531200000])
  (:field [placement/status "active"])
  (:field [placement/pay-rate 75])
  (:field [placement/bill-rate 125])
  (:field [placement/employee "emp:alice"])
  (:field [placement/employer "employer:acme"])
  (:field [placement/client "client:techcorp"])
  (:field [placement/job-type "job:software-dev"]))

(define-record "placement:bob-retail" Placement
  (:field [placement/start-date 1688515200000])
  (:field [placement/status "active"])
  (:field [placement/pay-rate 18])
  (:field [placement/bill-rate 28])
  (:field [placement/employee "emp:bob"])
  (:field [placement/employer "employer:acme"])
  (:field [placement/client "client:retail-giant"])
  (:field [placement/job-type "job:warehouse"]))

(define-record "placement:carol-techcorp" Placement
  (:field [placement/start-date 1696291200000])
  (:field [placement/status "active"])
  (:field [placement/pay-rate 22])
  (:field [placement/bill-rate 35])
  (:field [placement/employee "emp:carol"])
  (:field [placement/employer "employer:premier"])
  (:field [placement/client "client:techcorp"])
  (:field [placement/job-type "job:admin"]))

(define-record "placement:david-pending" Placement
  (:field [placement/start-date 1704067200000])
  (:field [placement/status "pending"])
  (:field [placement/employee "emp:david"]))

(define-record "placement:emma-acme" Placement
  (:field [placement/start-date 1704240000000])
  (:field [placement/status "active"])
  (:field [placement/pay-rate 22])
  (:field [placement/bill-rate 35])
  (:field [placement/employee "emp:emma"])
  (:field [placement/employer "employer:acme"])
  (:field [placement/client "client:techcorp"])
  (:field [placement/job-type "job:admin"]))

;; ---------------------------------------------------------------------------
;; Policies
;; ---------------------------------------------------------------------------

(define-record "policy:federal-standard" Policy
  (:field [policy/name "Federal Standard Onboarding"])
  (:field [policy/description "Standard federal compliance requirements for all new hires: I-9, W-4, BGC, direct deposit, and employee handbook"])
  (:field [policy/status "active"]))

(define-record "policy:california" Policy
  (:field [policy/name "California Supplement"])
  (:field [policy/description "Additional requirements for employees working in California: state tax withholding and CA-specific notices"])
  (:field [policy/status "active"]))

;; ---------------------------------------------------------------------------
;; Onboarding Tasks - David
;; ---------------------------------------------------------------------------

(define-record "task:david-i9" OnboardingTask
  (:field [onboardingtask/title "I-9 Employment Eligibility"])
  (:field [onboardingtask/document-name "I-9 Employment Eligibility"])
  (:field [onboardingtask/status "submitted"])
  (:field [onboardingtask/priority "critical"])
  (:field [onboardingtask/due-date 1704153600000])
  (:field [onboardingtask/assignee-role "employee"])
  (:field [onboardingtask/employee "emp:david"])
  (:field [onboardingtask/placement "placement:david-pending"])
  (:field [onboardingtask/policy "policy:federal-standard"]))

(define-record "task:david-w4" OnboardingTask
  (:field [onboardingtask/title "W-4 Federal Tax Withholding"])
  (:field [onboardingtask/document-name "W-4 Federal Tax Withholding"])
  (:field [onboardingtask/status "approved"])
  (:field [onboardingtask/priority "high"])
  (:field [onboardingtask/due-date 1704499200000])
  (:field [onboardingtask/completed-at 1703894400000])
  (:field [onboardingtask/assignee-role "employee"])
  (:field [onboardingtask/employee "emp:david"])
  (:field [onboardingtask/placement "placement:david-pending"])
  (:field [onboardingtask/policy "policy:federal-standard"]))

(define-record "task:david-bgc" OnboardingTask
  (:field [onboardingtask/title "Background Check"])
  (:field [onboardingtask/document-name "Background Check Consent"])
  (:field [onboardingtask/status "in-progress"])
  (:field [onboardingtask/priority "high"])
  (:field [onboardingtask/due-date 1704326400000])
  (:field [onboardingtask/assignee-role "system"])
  (:field [onboardingtask/employee "emp:david"])
  (:field [onboardingtask/placement "placement:david-pending"])
  (:field [onboardingtask/policy "policy:federal-standard"]))

(define-record "task:david-dd" OnboardingTask
  (:field [onboardingtask/title "Direct Deposit Setup"])
  (:field [onboardingtask/document-name "Direct Deposit Authorization"])
  (:field [onboardingtask/status "pending"])
  (:field [onboardingtask/priority "medium"])
  (:field [onboardingtask/due-date 1704931200000])
  (:field [onboardingtask/assignee-role "employee"])
  (:field [onboardingtask/employee "emp:david"])
  (:field [onboardingtask/placement "placement:david-pending"])
  (:field [onboardingtask/policy "policy:federal-standard"]))

(define-record "task:david-handbook" OnboardingTask
  (:field [onboardingtask/title "Employee Handbook Acknowledgment"])
  (:field [onboardingtask/document-name "Employee Handbook"])
  (:field [onboardingtask/status "approved"])
  (:field [onboardingtask/priority "medium"])
  (:field [onboardingtask/due-date 1704499200000])
  (:field [onboardingtask/completed-at 1703980800000])
  (:field [onboardingtask/assignee-role "employee"])
  (:field [onboardingtask/employee "emp:david"])
  (:field [onboardingtask/placement "placement:david-pending"])
  (:field [onboardingtask/policy "policy:federal-standard"]))

;; David's I-9 Section 2 requirement record. Runtime employer work still flows
;; through the live Task system, but this ontology record tracks the required
;; onboarding step for coverage and compliance reasoning.
(define-record "task:david-i9-s2" OnboardingTask
  (:field [onboardingtask/title "I-9 Section 2 (Employer Review)"])
  (:field [onboardingtask/document-name "I-9 Employment Eligibility"])
  (:field [onboardingtask/status "pending"])
  (:field [onboardingtask/priority "critical"])
  (:field [onboardingtask/due-date 1704240000000])
  (:field [onboardingtask/assignee-role "employer"])
  (:field [onboardingtask/employee "emp:david"])
  (:field [onboardingtask/placement "placement:david-pending"])
  (:field [onboardingtask/policy "policy:federal-standard"]))

;; ---------------------------------------------------------------------------
;; Onboarding Tasks - Emma
;; ---------------------------------------------------------------------------
;; Emma has NO pre-existing tasks. She is a clean demo subject for the
;; compliance loop: the onboarding-missing-i9 rule fires against her because
;; she has a placement with an employer but no I-9 task.

;; ---------------------------------------------------------------------------
;; Onboarding Tasks - Alice (completed)
;; ---------------------------------------------------------------------------

(define-record "task:alice-i9" OnboardingTask
  (:field [onboardingtask/title "I-9 Employment Eligibility"])
  (:field [onboardingtask/document-name "I-9 Employment Eligibility"])
  (:field [onboardingtask/status "approved"])
  (:field [onboardingtask/priority "critical"])
  (:field [onboardingtask/completed-at 1672099200000])
  (:field [onboardingtask/assignee-role "employee"])
  (:field [onboardingtask/employee "emp:alice"])
  (:field [onboardingtask/placement "placement:alice-techcorp"])
  (:field [onboardingtask/policy "policy:federal-standard"]))

(define-record "task:alice-w4" OnboardingTask
  (:field [onboardingtask/title "W-4 Federal Tax Withholding"])
  (:field [onboardingtask/document-name "W-4 Federal Tax Withholding"])
  (:field [onboardingtask/status "approved"])
  (:field [onboardingtask/priority "high"])
  (:field [onboardingtask/completed-at 1672099200000])
  (:field [onboardingtask/assignee-role "employee"])
  (:field [onboardingtask/employee "emp:alice"])
  (:field [onboardingtask/placement "placement:alice-techcorp"])
  (:field [onboardingtask/policy "policy:federal-standard"]))

(define-record "task:alice-bgc" OnboardingTask
  (:field [onboardingtask/title "Background Check"])
  (:field [onboardingtask/document-name "Background Check Consent"])
  (:field [onboardingtask/status "approved"])
  (:field [onboardingtask/priority "high"])
  (:field [onboardingtask/completed-at 1672272000000])
  (:field [onboardingtask/assignee-role "system"])
  (:field [onboardingtask/employee "emp:alice"])
  (:field [onboardingtask/placement "placement:alice-techcorp"])
  (:field [onboardingtask/policy "policy:federal-standard"]))

;; ---------------------------------------------------------------------------
;; Documents
;; ---------------------------------------------------------------------------

(define-record "doc:alice-i9" Document
  (:field [document/name "Alice Johnson - I-9"])
  (:field [document/type "i9"])
  (:field [document/status "signed"])
  (:field [document/created-at 1671926400000])
  (:field [document/signed-at 1672099200000])
  (:field [document/employee "emp:alice"]))

(define-record "doc:alice-w4" Document
  (:field [document/name "Alice Johnson - W-4"])
  (:field [document/type "w4"])
  (:field [document/status "signed"])
  (:field [document/created-at 1671926400000])
  (:field [document/signed-at 1672099200000])
  (:field [document/employee "emp:alice"]))

(define-record "doc:alice-bgc" Document
  (:field [document/name "Alice Johnson - BGC Consent"])
  (:field [document/type "bgc-consent"])
  (:field [document/status "signed"])
  (:field [document/created-at 1671926400000])
  (:field [document/signed-at 1672272000000])
  (:field [document/employee "emp:alice"]))

(define-record "doc:david-i9" Document
  (:field [document/name "David Chen - I-9"])
  (:field [document/type "i9"])
  (:field [document/status "generated"])
  (:field [document/created-at 1704067200000])
  (:field [document/employee "emp:david"]))

(define-record "doc:david-w4" Document
  (:field [document/name "David Chen - W-4"])
  (:field [document/type "w4"])
  (:field [document/status "signed"])
  (:field [document/created-at 1704067200000])
  (:field [document/signed-at 1703894400000])
  (:field [document/employee "emp:david"]))

(define-record "doc:david-handbook" Document
  (:field [document/name "David Chen - Employee Handbook"])
  (:field [document/type "handbook-ack"])
  (:field [document/status "signed"])
  (:field [document/created-at 1704067200000])
  (:field [document/signed-at 1703980800000])
  (:field [document/employee "emp:david"]))

;; ---------------------------------------------------------------------------
;; Link Instances
;; ---------------------------------------------------------------------------

;; Employment relationships
(define-link works-at "emp:alice" "employer:acme"
  (:field [works-at/start-date 1672531200000])
  (:field [works-at/status "active"]))

(define-link works-at "emp:bob" "employer:acme"
  (:field [works-at/start-date 1688515200000])
  (:field [works-at/status "active"]))

(define-link works-at "emp:carol" "employer:premier"
  (:field [works-at/start-date 1696291200000])
  (:field [works-at/status "active"]))

(define-link works-at "emp:emma" "employer:acme"
  (:field [works-at/start-date 1704240000000])
  (:field [works-at/status "active"]))

(define-link works-at "emp:frank" "employer:acme"
  (:field [works-at/start-date 1660348800000])
  (:field [works-at/end-date 1701475200000])
  (:field [works-at/status "inactive"]))

;; Placements at clients
(define-link placed-at "emp:alice" "client:techcorp"
  (:field [placed-at/start-date 1672531200000])
  (:field [placed-at/employer "employer:acme"])
  (:field [placed-at/jobtype "job:software-dev"])
  (:field [placed-at/status "active"]))

(define-link placed-at "emp:bob" "client:retail-giant"
  (:field [placed-at/start-date 1688515200000])
  (:field [placed-at/employer "employer:acme"])
  (:field [placed-at/jobtype "job:warehouse"])
  (:field [placed-at/status "active"]))

(define-link placed-at "emp:carol" "client:techcorp"
  (:field [placed-at/start-date 1696291200000])
  (:field [placed-at/employer "employer:premier"])
  (:field [placed-at/jobtype "job:admin"])
  (:field [placed-at/status "active"]))

(define-link placed-at "emp:emma" "client:techcorp"
  (:field [placed-at/start-date 1704240000000])
  (:field [placed-at/employer "employer:acme"])
  (:field [placed-at/jobtype "job:admin"])
  (:field [placed-at/status "active"]))

;; Employer-Client relationships
(define-link serves-client "employer:acme" "client:techcorp"
  (:field [serves-client/since 1609459200000])
  (:field [serves-client/contract-type "preferred"]))

(define-link serves-client "employer:acme" "client:retail-giant"
  (:field [serves-client/since 1672531200000])
  (:field [serves-client/contract-type "approved"]))

(define-link serves-client "employer:premier" "client:techcorp"
  (:field [serves-client/since 1688515200000])
  (:field [serves-client/contract-type "approved"]))

;; Policy governance
(define-link governed-by "employer:acme" "policy:federal-standard"
  (:field [governed-by/since 1609459200000])
  (:field [governed-by/overridden false]))

(define-link governed-by "employer:premier" "policy:federal-standard"
  (:field [governed-by/since 1688515200000])
  (:field [governed-by/overridden false]))

;; Task assignments
(define-link assigned-task "emp:david" "task:david-i9"
  (:field [assigned-task/assigned-at 1704067200000]))

(define-link assigned-task "emp:david" "task:david-w4"
  (:field [assigned-task/assigned-at 1704067200000]))

(define-link assigned-task "emp:david" "task:david-bgc"
  (:field [assigned-task/assigned-at 1704067200000]))

(define-link assigned-task "emp:david" "task:david-dd"
  (:field [assigned-task/assigned-at 1704067200000]))

(define-link assigned-task "emp:david" "task:david-handbook"
  (:field [assigned-task/assigned-at 1704067200000]))

(define-link assigned-task "emp:david" "task:david-i9-s2"
  (:field [assigned-task/assigned-at 1704153600000]))

;; Emma has no pre-existing tasks (clean demo subject for compliance loop)

(define-link assigned-task "emp:alice" "task:alice-i9"
  (:field [assigned-task/assigned-at 1671926400000]))

(define-link assigned-task "emp:alice" "task:alice-w4"
  (:field [assigned-task/assigned-at 1671926400000]))

(define-link assigned-task "emp:alice" "task:alice-bgc"
  (:field [assigned-task/assigned-at 1671926400000]))

;; Documents
(define-link has-document "emp:alice" "doc:alice-i9"
  (:field [has-document/uploaded-at 1672099200000]))

(define-link has-document "emp:alice" "doc:alice-w4"
  (:field [has-document/uploaded-at 1672099200000]))

(define-link has-document "emp:alice" "doc:alice-bgc"
  (:field [has-document/uploaded-at 1672272000000]))

(define-link has-document "emp:david" "doc:david-i9"
  (:field [has-document/uploaded-at 1704067200000]))

(define-link has-document "emp:david" "doc:david-w4"
  (:field [has-document/uploaded-at 1703894400000]))

(define-link has-document "emp:david" "doc:david-handbook"
  (:field [has-document/uploaded-at 1703980800000]))
```

```

```
