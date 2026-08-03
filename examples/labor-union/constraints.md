# Constraints

```lisp
(export covered-placement-needs-card-task pending-card-needs-active-template rehire-needs-lr-review)

;; =============================================================================
;; Labor Relations Ontology - Constraints
;; =============================================================================

(define-constraint covered-placement-needs-card-task
  (:entity Placement)
  (:severity error)
  (:description "Covered placements need a union authorization task")
  (:category "labor-relations")
  (:violation-query
    (find ?placement ?cbaId)
    (where
      [?placement :_schema/type "Placement"]
      [?placement :placement/status "covered-pending-card"]
      [?placement :placement/cba-id ?cbaId]
      [not [?task :unionauthtask/placement ?placement]]))
  (:message (format "Covered placement for CBA {} has no authorization task" ?cbaId)))

(define-constraint pending-card-needs-active-template
  (:entity UnionAuthorizationTask)
  (:severity warning)
  (:description "Open authorization tasks should reference an approved template version")
  (:category "template-governance")
  (:violation-query
    (find ?task ?title ?version)
    (where
      [?task :_schema/type "UnionAuthorizationTask"]
      [?task :unionauthtask/status "needs-review"]
      [?task :unionauthtask/title ?title]
      [?task :unionauthtask/template-version ?version]))
  (:message (format "Authorization task \"{}\" is waiting on template version {} review" ?title ?version)))

(define-constraint rehire-needs-lr-review
  (:entity Employee)
  (:severity info)
  (:description "Returning workers require labor-relations policy review before skipping a card")
  (:category "rehire")
  (:violation-query
    (find ?employee ?firstName ?lastName ?globalHrId)
    (where
      [?employee :_schema/type "Employee"]
      [?employee :employee/rehire-indicator true]
      [?employee :employee/first-name ?firstName]
      [?employee :employee/last-name ?lastName]
      [?employee :employee/global-hr-id ?globalHrId]))
  (:message (format "Rehire {} {} ({}) needs union-card reuse policy review" ?firstName ?lastName ?globalHrId))
  (:resolution
    (resolution
      (:label "Flag Rehire Review")
      (:action flag-rehire-review)
      (:auto false))))
```
