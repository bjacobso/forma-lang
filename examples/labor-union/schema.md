# Schema

```lisp
(export Employer SectorBrand WorkLocation Employee Position Placement CollectiveBargainingAgreement AuthorizationCardTemplate UnionAuthorizationTask ExecutedAuthorizationDocument IntegrationEvent brand-of location-for placed-in placement-position placement-employer position-covered-by cba-uses-template task-for-placement task-fulfills-cba task-produces-document event-for-document)

;; =============================================================================
;; Labor Relations Ontology - Schema
;; =============================================================================
;;
;; Client-neutral model for CBA-triggered union authorization card workflow.
;;

(define-entity Employer
  (:field [employer/name String {:required true}])
  (:field [employer/status String {:required true}])
  (:field [employer/repository-profile String])
  (:field [employer/default-delivery-channel String]))

(define-entity SectorBrand
  (:field [sectorbrand/name String {:required true}])
  (:field [sectorbrand/display-name String])
  (:field [sectorbrand/branding-mode String])
  (:field [sectorbrand/status String {:required true}]))

(define-entity WorkLocation
  (:field [worklocation/name String {:required true}])
  (:field [worklocation/sector String])
  (:field [worklocation/city String])
  (:field [worklocation/state String])
  (:field [worklocation/status String {:required true}]))

(define-entity Employee
  (:field [employee/first-name String {:required true}])
  (:field [employee/last-name String {:required true}])
  (:field [employee/email String])
  (:field [employee/phone String])
  (:field [employee/status String {:required true}])
  (:field [employee/global-hr-id String])
  (:field [employee/hire-event-id String])
  (:field [employee/rehire-indicator Boolean])
  (:field [employee/cba-id String])
  (:field [employee/address String])
  (:field [employee/union-card-signed Boolean]))

(define-entity Position
  (:field [position/title String {:required true}])
  (:field [position/job-code String {:required true}])
  (:field [position/status String {:required true}])
  (:field [position/cba-id String])
  (:field [position/sector-brand (Ref SectorBrand)])
  (:field [position/work-location (Ref WorkLocation)]))

(define-entity Placement
  (:field [placement/start-date Number {:required true}])
  (:field [placement/status String {:required true}])
  (:field [placement/source-system String])
  (:field [placement/cba-id String])
  (:field [placement/employee (Ref Employee)])
  (:field [placement/position (Ref Position)])
  (:field [placement/employer (Ref Employer)]))

(define-entity CollectiveBargainingAgreement
  (:field [cba/identifier String {:required true}])
  (:field [cba/union-name String {:required true}])
  (:field [cba/local-label String])
  (:field [cba/sector String])
  (:field [cba/geographic-scope String])
  (:field [cba/effective-start Number])
  (:field [cba/effective-end Number])
  (:field [cba/status String {:required true}])
  (:field [cba/card-template (Ref AuthorizationCardTemplate)]))

(define-entity AuthorizationCardTemplate
  (:field [authcardtemplate/template-id String {:required true}])
  (:field [authcardtemplate/name String {:required true}])
  (:field [authcardtemplate/version String {:required true}])
  (:field [authcardtemplate/status String {:required true}])
  (:field [authcardtemplate/source-system String])
  (:field [authcardtemplate/source-reference String])
  (:field [authcardtemplate/form-mode String])
  (:field [authcardtemplate/disclosure-summary String]))

(define-entity UnionAuthorizationTask
  (:field [unionauthtask/title String {:required true}])
  (:field [unionauthtask/status String {:required true}])
  (:field [unionauthtask/priority String])
  (:field [unionauthtask/assignee-role String])
  (:field [unionauthtask/delivery-channel String])
  (:field [unionauthtask/due-date Number])
  (:field [unionauthtask/completed-at Number])
  (:field [unionauthtask/template-version String])
  (:field [unionauthtask/runtime-task-id String])
  (:field [unionauthtask/document-instance-id String])
  (:field [unionauthtask/employee (Ref Employee)])
  (:field [unionauthtask/placement (Ref Placement)])
  (:field [unionauthtask/cba (Ref CollectiveBargainingAgreement)]))

(define-entity ExecutedAuthorizationDocument
  (:field [executeddocument/name String {:required true}])
  (:field [executeddocument/status String {:required true}])
  (:field [executeddocument/signed-at Number])
  (:field [executeddocument/template-version String])
  (:field [executeddocument/pdf-reference String])
  (:field [executeddocument/structured-data-reference String])
  (:field [executeddocument/routing-status String])
  (:field [executeddocument/task (Ref UnionAuthorizationTask)])
  (:field [executeddocument/employee (Ref Employee)])
  (:field [executeddocument/cba (Ref CollectiveBargainingAgreement)]))

(define-entity IntegrationEvent
  (:field [integrationevent/event-type String {:required true}])
  (:field [integrationevent/status String {:required true}])
  (:field [integrationevent/target-system String])
  (:field [integrationevent/emitted-at Number])
  (:field [integrationevent/payload-summary String])
  (:field [integrationevent/task (Ref UnionAuthorizationTask)])
  (:field [integrationevent/document (Ref ExecutedAuthorizationDocument)])
  (:field [integrationevent/employee (Ref Employee)]))

(define-relation brand-of SectorBrand Employer)
(define-relation location-for WorkLocation SectorBrand)
(define-relation placed-in Employee Placement)
(define-relation placement-position Placement Position)
(define-relation placement-employer Placement Employer)
(define-relation position-covered-by Position CollectiveBargainingAgreement)
(define-relation cba-uses-template CollectiveBargainingAgreement AuthorizationCardTemplate)
(define-relation task-for-placement UnionAuthorizationTask Placement)
(define-relation task-fulfills-cba UnionAuthorizationTask CollectiveBargainingAgreement)
(define-relation task-produces-document UnionAuthorizationTask ExecutedAuthorizationDocument)
(define-relation event-for-document IntegrationEvent ExecutedAuthorizationDocument)
```
