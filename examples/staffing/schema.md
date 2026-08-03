# Schema

```lisp
(export Address Employer Client Employee JobType Placement Policy OnboardingTask Document works-at placed-at serves-client governed-by assigned-task has-document)

;; =============================================================================
;; Staffing Agency Ontology - Canonical Schema
;; =============================================================================
;;
;; Canonical noun-form copy of the staffing schema. This preserves entity names
;; and field names from the current example while moving the surface away from
;; def-* documents and nested attribute declarations.
;;

(define-entity Address
  (:field [address/street String])
  (:field [address/street2 String])
  (:field [address/city String {:required true}])
  (:field [address/state String {:required true}])
  (:field [address/zip String {:required true}])
  (:field [address/country String]))

(define-entity Employer
  (:field [employer/name String {:required true}])
  (:field [employer/ein String {:doc "Employer Identification Number"}])
  (:field [employer/phone String])
  (:field [employer/email String])
  (:field [employer/status String {:required true}])
  (:field [employer/address (Ref Address)]))

(define-entity Client
  (:field [client/name String {:required true}])
  (:field [client/industry String])
  (:field [client/phone String])
  (:field [client/email String])
  (:field [client/status String {:required true}])
  (:field [client/address (Ref Address)]))

(define-entity Employee
  (:field [employee/first-name String {:required true}])
  (:field [employee/last-name String {:required true}])
  (:field [employee/email String])
  (:field [employee/phone String])
  (:field [employee/date-of-birth String])
  (:field [employee/ssn String {:doc "Social Security Number (encrypted)"}])
  (:field [employee/i9-citizenship-status String])
  (:field [employee/i9-section-1-signed Boolean])
  (:field [employee/status String {:required true}])
  (:field [employee/hire-date Number])
  (:field [employee/address (Ref Address)]))

(define-entity JobType
  (:field [jobtype/name String {:required true}])
  (:field [jobtype/description String])
  (:field [jobtype/hourly-rate Number])
  (:field [jobtype/bill-rate Number]))

(define-entity Placement
  (:field [placement/start-date Number {:required true}])
  (:field [placement/end-date Number])
  (:field [placement/status String {:required true}])
  (:field [placement/pay-rate Number])
  (:field [placement/bill-rate Number])
  (:field [placement/employee (Ref Employee)])
  (:field [placement/client (Ref Client)])
  (:field [placement/employer (Ref Employer)])
  (:field [placement/job-type (Ref JobType)]))

(define-entity Policy
  (:field [policy/name String {:required true}])
  (:field [policy/description String])
  (:field [policy/status String {:required true}]))

(define-entity OnboardingTask
  (:field [onboardingtask/title String {:required true}])
  (:field [onboardingtask/document-name String])
  (:field [onboardingtask/status String {:required true}])
  (:field [onboardingtask/priority String {:required true}])
  (:field [onboardingtask/due-date Number])
  (:field [onboardingtask/completed-at Number])
  (:field [onboardingtask/assignee-role String {:required true}])
  (:field [onboardingtask/employee (Ref Employee)])
  (:field [onboardingtask/placement (Ref Placement)])
  (:field [onboardingtask/policy (Ref Policy)]))

(define-entity Document
  (:field [document/name String {:required true}])
  (:field [document/type String {:required true}])
  (:field [document/status String {:required true}])
  (:field [document/created-at Number])
  (:field [document/signed-at Number])
  (:field [document/expires-at Number])
  (:field [document/source-document String])
  (:field [document/document-instance-id String])
  (:field [document/document-submission-id String])
  (:field [document/attachment-hash String])
  (:field [document/attachment-filename String])
  (:field [document/employee (Ref Employee)]))

(define-relation works-at Employee Employer
  (:field [works-at/start-date Number])
  (:field [works-at/end-date Number])
  (:field [works-at/status String]))

(define-relation placed-at Employee Client
  (:field [placed-at/start-date Number])
  (:field [placed-at/end-date Number])
  (:field [placed-at/employer String])
  (:field [placed-at/jobtype String])
  (:field [placed-at/status String]))

(define-relation serves-client Employer Client
  (:field [serves-client/since Number])
  (:field [serves-client/contract-type String]))

(define-relation governed-by Employer Policy
  (:field [governed-by/since Number])
  (:field [governed-by/overridden Boolean]))

(define-relation assigned-task Employee OnboardingTask
  (:field [assigned-task/assigned-at Number]))

(define-relation has-document Employee Document
  (:field [has-document/uploaded-at Number]))
```

```

```
