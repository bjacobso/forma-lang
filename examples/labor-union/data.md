# Seed Data

```lisp
(export brand-of location-for position-covered-by cba-uses-template placed-in placement-position placement-employer task-for-placement task-fulfills-cba task-produces-document event-for-document)

;; =============================================================================
;; Labor Relations Ontology - Seed Data
;; =============================================================================

(define-record "employer:northstar" Employer
  (:field [employer/name "Northstar Hospitality Group"])
  (:field [employer/status "active"])
  (:field [employer/repository-profile "Associate Digital File"])
  (:field [employer/default-delivery-channel "Candidate Messaging"]))

(define-record "brand:stadium-dining" SectorBrand
  (:field [sectorbrand/name "stadium-dining"])
  (:field [sectorbrand/display-name "Stadium Dining"])
  (:field [sectorbrand/branding-mode "sector-brand"])
  (:field [sectorbrand/status "active"]))

(define-record "brand:campus-kitchens" SectorBrand
  (:field [sectorbrand/name "campus-kitchens"])
  (:field [sectorbrand/display-name "Campus Kitchens"])
  (:field [sectorbrand/branding-mode "sector-brand"])
  (:field [sectorbrand/status "active"]))

(define-record "location:riverfront-arena" WorkLocation
  (:field [worklocation/name "Riverfront Arena"])
  (:field [worklocation/sector "sports-and-entertainment"])
  (:field [worklocation/city "Cleveland"])
  (:field [worklocation/state "OH"])
  (:field [worklocation/status "active"]))

(define-record "location:west-campus" WorkLocation
  (:field [worklocation/name "West Campus Dining"])
  (:field [worklocation/sector "education"])
  (:field [worklocation/city "Madison"])
  (:field [worklocation/state "WI"])
  (:field [worklocation/status "active"]))

(define-record "template:food-service-204-v3" AuthorizationCardTemplate
  (:field [authcardtemplate/template-id "AUTH-FS-204"])
  (:field [authcardtemplate/name "Food Service Workers Authorization Card"])
  (:field [authcardtemplate/version "v3"])
  (:field [authcardtemplate/status "active"])
  (:field [authcardtemplate/source-system "CBA MDM"])
  (:field [authcardtemplate/source-reference "mdm://templates/AUTH-FS-204/v3"])
  (:field [authcardtemplate/form-mode "simplified"])
  (:field [authcardtemplate/disclosure-summary "Employee authorizes union representation and payroll dues deduction for the covered bargaining unit."]))

(define-record "template:hospitality-311-v1" AuthorizationCardTemplate
  (:field [authcardtemplate/template-id "AUTH-HSP-311"])
  (:field [authcardtemplate/name "Hospitality Local Authorization Card"])
  (:field [authcardtemplate/version "v1"])
  (:field [authcardtemplate/status "draft"])
  (:field [authcardtemplate/source-system "CBA MDM"])
  (:field [authcardtemplate/source-reference "mdm://templates/AUTH-HSP-311/v1"])
  (:field [authcardtemplate/form-mode "verbatim"])
  (:field [authcardtemplate/disclosure-summary "Legal review requires verbatim card content before publication."]))

(define-record "cba:food-service-204" CollectiveBargainingAgreement
  (:field [cba/identifier "CBA-FS-204-2026"])
  (:field [cba/union-name "Food Service Workers Alliance"])
  (:field [cba/local-label "Local 204 Food Service Workers"])
  (:field [cba/sector "sports-and-entertainment"])
  (:field [cba/geographic-scope "Ohio arena accounts"])
  (:field [cba/effective-start 1767225600000])
  (:field [cba/effective-end 1861833600000])
  (:field [cba/status "active"])
  (:field [cba/card-template "template:food-service-204-v3"]))

(define-record "cba:hospitality-311" CollectiveBargainingAgreement
  (:field [cba/identifier "CBA-HSP-311-2026"])
  (:field [cba/union-name "Hospitality Staff Guild"])
  (:field [cba/local-label "Local 311 Hospitality Staff"])
  (:field [cba/sector "education"])
  (:field [cba/geographic-scope "Upper Midwest campus accounts"])
  (:field [cba/effective-start 1767225600000])
  (:field [cba/effective-end 1861833600000])
  (:field [cba/status "pending-review"])
  (:field [cba/card-template "template:hospitality-311-v1"]))

(define-record "position:arena-cashier" Position
  (:field [position/title "Concessions Cashier"])
  (:field [position/job-code "FS-1007"])
  (:field [position/status "open"])
  (:field [position/cba-id "CBA-FS-204-2026"])
  (:field [position/sector-brand "brand:stadium-dining"])
  (:field [position/work-location "location:riverfront-arena"]))

(define-record "position:campus-cook" Position
  (:field [position/title "Campus Line Cook"])
  (:field [position/job-code "CK-2204"])
  (:field [position/status "open"])
  (:field [position/cba-id "CBA-HSP-311-2026"])
  (:field [position/sector-brand "brand:campus-kitchens"])
  (:field [position/work-location "location:west-campus"]))

(define-record "employee:maya-chen" Employee
  (:field [employee/first-name "Maya"])
  (:field [employee/last-name "Chen"])
  (:field [employee/email "maya.chen@example.com"])
  (:field [employee/phone "+1-216-555-0142"])
  (:field [employee/status "preboarding"])
  (:field [employee/global-hr-id "GHR-00014822"])
  (:field [employee/hire-event-id "HIRE-2026-0419"])
  (:field [employee/rehire-indicator false])
  (:field [employee/address "142 Market Street, Cleveland, OH"])
  (:field [employee/union-card-signed false]))

(define-record "employee:darius-lee" Employee
  (:field [employee/first-name "Darius"])
  (:field [employee/last-name "Lee"])
  (:field [employee/email "darius.lee@example.com"])
  (:field [employee/phone "+1-608-555-0184"])
  (:field [employee/status "preboarding"])
  (:field [employee/global-hr-id "GHR-00009210"])
  (:field [employee/hire-event-id "HIRE-2026-0427"])
  (:field [employee/rehire-indicator true])
  (:field [employee/cba-id "CBA-HSP-311-2026"])
  (:field [employee/address "88 Lake Avenue, Madison, WI"])
  (:field [employee/union-card-signed false]))

(define-record "employee:rosa-diaz" Employee
  (:field [employee/first-name "Rosa"])
  (:field [employee/last-name "Diaz"])
  (:field [employee/email "rosa.diaz@example.com"])
  (:field [employee/phone "+1-216-555-0199"])
  (:field [employee/status "active"])
  (:field [employee/global-hr-id "GHR-00005218"])
  (:field [employee/hire-event-id "HIRE-2025-0931"])
  (:field [employee/rehire-indicator false])
  (:field [employee/cba-id "CBA-FS-204-2026"])
  (:field [employee/address "301 Ontario Avenue, Cleveland, OH"])
  (:field [employee/union-card-signed true]))

(define-record "placement:maya-arena" Placement
  (:field [placement/start-date 1770163200000])
  (:field [placement/status "covered-pending-card"])
  (:field [placement/source-system "Enterprise HRIS"])
  (:field [placement/cba-id "CBA-FS-204-2026"])
  (:field [placement/employee "employee:maya-chen"])
  (:field [placement/position "position:arena-cashier"])
  (:field [placement/employer "employer:northstar"]))

(define-record "placement:darius-campus" Placement
  (:field [placement/start-date 1770768000000])
  (:field [placement/status "rehire-review"])
  (:field [placement/source-system "Enterprise HRIS"])
  (:field [placement/cba-id "CBA-HSP-311-2026"])
  (:field [placement/employee "employee:darius-lee"])
  (:field [placement/position "position:campus-cook"])
  (:field [placement/employer "employer:northstar"]))

(define-record "placement:rosa-arena" Placement
  (:field [placement/start-date 1757894400000])
  (:field [placement/status "active"])
  (:field [placement/source-system "Enterprise HRIS"])
  (:field [placement/cba-id "CBA-FS-204-2026"])
  (:field [placement/employee "employee:rosa-diaz"])
  (:field [placement/position "position:arena-cashier"])
  (:field [placement/employer "employer:northstar"]))

(define-record "union-task:maya-card" UnionAuthorizationTask
  (:field [unionauthtask/title "Complete Food Service Workers authorization card"])
  (:field [unionauthtask/status "pending"])
  (:field [unionauthtask/priority "critical"])
  (:field [unionauthtask/assignee-role "employee"])
  (:field [unionauthtask/delivery-channel "Candidate Messaging"])
  (:field [unionauthtask/due-date 1770076800000])
  (:field [unionauthtask/template-version "v3"])
  (:field [unionauthtask/employee "employee:maya-chen"])
  (:field [unionauthtask/placement "placement:maya-arena"])
  (:field [unionauthtask/cba "cba:food-service-204"]))

(define-record "union-task:darius-review" UnionAuthorizationTask
  (:field [unionauthtask/title "Review rehire union authorization policy"])
  (:field [unionauthtask/status "needs-review"])
  (:field [unionauthtask/priority "high"])
  (:field [unionauthtask/assignee-role "labor-relations"])
  (:field [unionauthtask/delivery-channel "Labor Relations Queue"])
  (:field [unionauthtask/due-date 1770249600000])
  (:field [unionauthtask/template-version "v1"])
  (:field [unionauthtask/employee "employee:darius-lee"])
  (:field [unionauthtask/placement "placement:darius-campus"])
  (:field [unionauthtask/cba "cba:hospitality-311"]))

(define-record "union-task:rosa-card" UnionAuthorizationTask
  (:field [unionauthtask/title "Completed Food Service Workers authorization card"])
  (:field [unionauthtask/status "completed"])
  (:field [unionauthtask/priority "critical"])
  (:field [unionauthtask/assignee-role "employee"])
  (:field [unionauthtask/delivery-channel "Candidate Messaging"])
  (:field [unionauthtask/due-date 1757808000000])
  (:field [unionauthtask/completed-at 1757721600000])
  (:field [unionauthtask/template-version "v3"])
  (:field [unionauthtask/document-instance-id "docinst:rosa-card"])
  (:field [unionauthtask/employee "employee:rosa-diaz"])
  (:field [unionauthtask/placement "placement:rosa-arena"])
  (:field [unionauthtask/cba "cba:food-service-204"]))

(define-record "executed:rosa-card" ExecutedAuthorizationDocument
  (:field [executeddocument/name "Rosa Diaz - Union Authorization Card"])
  (:field [executeddocument/status "available"])
  (:field [executeddocument/signed-at 1757721600000])
  (:field [executeddocument/template-version "v3"])
  (:field [executeddocument/pdf-reference "api://documents/docinst:rosa-card/pdf"])
  (:field [executeddocument/structured-data-reference "api://documents/docinst:rosa-card/data"])
  (:field [executeddocument/routing-status "routed"])
  (:field [executeddocument/task "union-task:rosa-card"])
  (:field [executeddocument/employee "employee:rosa-diaz"])
  (:field [executeddocument/cba "cba:food-service-204"]))

(define-record "event:rosa-card-complete" IntegrationEvent
  (:field [integrationevent/event-type "task_updated"])
  (:field [integrationevent/status "delivered"])
  (:field [integrationevent/target-system "Associate Digital File"])
  (:field [integrationevent/emitted-at 1757721660000])
  (:field [integrationevent/payload-summary "Union authorization task reached 100% completion; PDF and structured data ready for retrieval."])
  (:field [integrationevent/task "union-task:rosa-card"])
  (:field [integrationevent/document "executed:rosa-card"])
  (:field [integrationevent/employee "employee:rosa-diaz"]))

(define-link brand-of "brand:stadium-dining" "employer:northstar")
(define-link brand-of "brand:campus-kitchens" "employer:northstar")
(define-link location-for "location:riverfront-arena" "brand:stadium-dining")
(define-link location-for "location:west-campus" "brand:campus-kitchens")
(define-link position-covered-by "position:arena-cashier" "cba:food-service-204")
(define-link position-covered-by "position:campus-cook" "cba:hospitality-311")
(define-link cba-uses-template "cba:food-service-204" "template:food-service-204-v3")
(define-link cba-uses-template "cba:hospitality-311" "template:hospitality-311-v1")
(define-link placed-in "employee:maya-chen" "placement:maya-arena")
(define-link placed-in "employee:darius-lee" "placement:darius-campus")
(define-link placed-in "employee:rosa-diaz" "placement:rosa-arena")
(define-link placement-position "placement:maya-arena" "position:arena-cashier")
(define-link placement-position "placement:darius-campus" "position:campus-cook")
(define-link placement-position "placement:rosa-arena" "position:arena-cashier")
(define-link placement-employer "placement:maya-arena" "employer:northstar")
(define-link placement-employer "placement:darius-campus" "employer:northstar")
(define-link placement-employer "placement:rosa-arena" "employer:northstar")
(define-link task-for-placement "union-task:maya-card" "placement:maya-arena")
(define-link task-for-placement "union-task:darius-review" "placement:darius-campus")
(define-link task-for-placement "union-task:rosa-card" "placement:rosa-arena")
(define-link task-fulfills-cba "union-task:maya-card" "cba:food-service-204")
(define-link task-fulfills-cba "union-task:darius-review" "cba:hospitality-311")
(define-link task-fulfills-cba "union-task:rosa-card" "cba:food-service-204")
(define-link task-produces-document "union-task:rosa-card" "executed:rosa-card")
(define-link event-for-document "event:rosa-card-complete" "executed:rosa-card")
```
