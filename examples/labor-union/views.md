# Views

```lisp
(export lr-dashboard covered-placement-queue authorization-task-queue cba-template-library rehire-review document-routing-monitor integration-events-view employee-card-dashboard)

;; =============================================================================
;; Labor Relations Ontology - Views
;; =============================================================================

(define-view lr-dashboard
  (:title "Labor Relations Dashboard")
  (:description "Covered placements, authorization work, and document routing state.")
  (:subject session)
  (:state selectedEmployee nil)
  (:named-query placements (:ref covered-placements))
  (:named-query tasks (:ref pending-authorization-tasks))
  (:named-query documents (:ref completed-authorization-documents))
  (:named-query reviews (:ref rehire-review-cases))
  (:layout
    (rows
      (heading "Labor Relations Operations")
      (workflow-strip {:title "Union Authorization Flow"
                       :description "CBA data drives the task, the employee signs the card, and completion becomes a routable document event."}
        (workflow-step {:label "Covered Placement" :description "HRIS or requisition data supplies CBA context." :status "complete"})
        (workflow-step {:label "Policy Evaluation" :description "The ontology rule creates the authorization task." :status "current"})
        (workflow-step {:label "Employee Signature" :description "The card is completed in a mobile document flow." :status "upcoming"})
        (workflow-step {:label "Routing" :description "Webhook and document APIs hand off the executed artifact." :status "upcoming"}))
      (stat-group
        (metric {:label "Covered Placements" :value (length (query placements))})
        (metric {:label "Open Auth Tasks" :value (length (query tasks))})
        (metric {:label "Executed Cards" :value (length (query documents))})
        (metric {:label "Rehire Reviews" :value (length (query reviews))}))
      (columns
        (card {:title "Open Authorization Work"}
          (table {:bind (query tasks)
                  :columns [{:key "?unionauthtask_title" :label "Task"}
                            {:key "?unionauthtask_status" :label "Status" :kind "status"}
                            {:key "?unionauthtask_priority" :label "Priority" :kind "priority"}
                            {:key "?unionauthtask_assignee_role" :label "Assignee"}
                            {:key "?unionauthtask_due_date" :label "Due" :kind "date"}]
                  :empty-state "No authorization tasks are open."}))
        (card {:title "Covered Placements"}
          (table {:bind (query placements)
                  :columns [{:key "?placement_start_date" :label "Start" :kind "date"}
                            {:key "?placement_status" :label "Status" :kind "status"}
                            {:key "?placement_source_system" :label "Source"}
                            {:key "?placement_cba_id" :label "CBA" :kind "mono"}]
                  :empty-state "No covered placements found."}))))))

(define-view covered-placement-queue
  (:title "Covered Placement Queue")
  (:description "Placements where employee-level or position-level CBA data can trigger card work.")
  (:subject session)
  (:named-query placements (:ref covered-placements))
  (:layout
    (rows
      (heading "Covered Placement Queue")
      (table {:bind (query placements)
              :columns [{:key "?placement_start_date" :label "Start Date" :kind "date"}
                        {:key "?placement_status" :label "Status" :kind "status"}
                        {:key "?placement_source_system" :label "Source System"}
                        {:key "?placement_cba_id" :label "CBA Identifier" :kind "mono"}
                        {:key "?placement_employee" :label "Employee" :kind "mono"}
                        {:key "?placement_position" :label "Position" :kind "mono"}]
              :default-sort {:key "?placement_start_date" :direction "asc"}
              :empty-state "No covered placements are waiting."}))))

(define-view authorization-task-queue
  (:title "Authorization Task Queue")
  (:description "Union authorization tasks produced by CBA policy evaluation.")
  (:subject session)
  (:named-query tasks (:ref pending-authorization-tasks))
  (:layout
    (rows
      (heading "Authorization Task Queue")
      (table {:bind (query tasks)
              :columns [{:key "?unionauthtask_title" :label "Task"}
                        {:key "?unionauthtask_status" :label "Status" :kind "status"}
                        {:key "?unionauthtask_priority" :label "Priority" :kind "priority"}
                        {:key "?unionauthtask_assignee_role" :label "Assignee"}
                        {:key "?unionauthtask_delivery_channel" :label "Delivery"}
                        {:key "?unionauthtask_template_version" :label "Template"}]
              :empty-state "No authorization work is open."}))))

(define-view cba-template-library
  (:title "CBA Template Library")
  (:description "Template metadata as consumed from the CBA master data source.")
  (:subject session)
  (:named-query templates (:ref all-cba-templates))
  (:named-query review (:ref cbas-needing-review))
  (:layout
    (rows
      (heading "CBA Template Library")
      (columns
        (card {:title "Card Templates"}
          (table {:bind (query templates)
                  :columns [{:key "?authcardtemplate_template_id" :label "Template ID" :kind "mono"}
                            {:key "?authcardtemplate_name" :label "Name"}
                            {:key "?authcardtemplate_version" :label "Version"}
                            {:key "?authcardtemplate_status" :label "Status" :kind "status"}
                            {:key "?authcardtemplate_form_mode" :label "Form Mode"}]
                  :empty-state "No templates are available."}))
        (card {:title "CBAs Needing Review"}
          (table {:bind (query review)
                  :columns [{:key "?cba_identifier" :label "CBA" :kind "mono"}
                            {:key "?cba_union_name" :label "Union"}
                            {:key "?cba_local_label" :label "Local"}
                            {:key "?cba_status" :label "Status" :kind "status"}]
                  :empty-state "All CBA records are active."}))))))

(define-view rehire-review
  (:title "Rehire Review")
  (:description "Returning workers where prior authorization policy must be evaluated.")
  (:subject session)
  (:named-query rehires (:ref rehire-review-cases))
  (:layout
    (rows
      (heading "Rehire Review")
      (table {:bind (query rehires)
              :columns [{:key "?employee_first_name" :label "First"}
                        {:key "?employee_last_name" :label "Last"}
                        {:key "?employee_status" :label "Status" :kind "status"}
                        {:key "?employee_global_hr_id" :label "Global HR ID" :kind "mono"}
                        {:key "?employee_cba_id" :label "CBA" :kind "mono"}
                        {:key "?employee_union_card_signed" :label "Prior Card"}]
              :empty-state "No rehire reviews are waiting."}))))

(define-view document-routing-monitor
  (:title "Document Routing Monitor")
  (:description "Executed authorization documents and downstream routing status.")
  (:subject session)
  (:named-query documents (:ref completed-authorization-documents))
  (:named-query exceptions (:ref routing-exceptions))
  (:layout
    (rows
      (heading "Document Routing Monitor")
      (stat-group
        (metric {:label "Available Documents" :value (length (query documents))})
        (metric {:label "Routing Exceptions" :value (length (query exceptions))}))
      (table {:bind (query documents)
              :columns [{:key "?executeddocument_name" :label "Document"}
                        {:key "?executeddocument_signed_at" :label "Signed" :kind "date"}
                        {:key "?executeddocument_template_version" :label "Template"}
                        {:key "?executeddocument_routing_status" :label "Routing" :kind "status"}
                        {:key "?executeddocument_pdf_reference" :label "PDF Reference" :kind "mono"}]
              :empty-state "No executed authorization documents are available."}))))

(define-view integration-events-view
  (:title "Integration Events")
  (:description "Webhook-style events emitted for downstream labor-relations systems.")
  (:subject session)
  (:named-query events (:ref integration-events))
  (:layout
    (rows
      (heading "Integration Events")
      (table {:bind (query events)
              :columns [{:key "?integrationevent_event_type" :label "Event"}
                        {:key "?integrationevent_status" :label "Status" :kind "status"}
                        {:key "?integrationevent_target_system" :label "Target"}
                        {:key "?integrationevent_emitted_at" :label "Emitted" :kind "date"}
                        {:key "?integrationevent_payload_summary" :label "Payload Summary"}]
              :empty-state "No integration events have been emitted."}))))

(define-view employee-card-dashboard
  (:title "Union Authorization")
  (:description "Employee-facing authorization task and submitted card details.")
  (:subject required)
  (:layout
    (rows
      (heading "Union Authorization")
      (custom {:component-name "runtime/employee-task-list"
               :title "My Authorization Tasks"
               :description "Open union authorization work assigned to this employee."
               :entity-id (input subject)
               :assigned-role "employee"})
      (custom {:component-name "runtime/bound-attribute-list"
               :title "Card Data"
               :description "Employee values bound from the submitted authorization card."
               :entity-id (input subject)
               :fields [{:field "Global HR ID" :attribute ":employee/global-hr-id"}
                        {:field "CBA Identifier" :attribute ":employee/cba-id"}
                        {:field "Address" :attribute ":employee/address"}
                        {:field "Signed" :attribute ":employee/union-card-signed"}]}))))
```
