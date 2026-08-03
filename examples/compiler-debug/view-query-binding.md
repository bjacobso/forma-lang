# Query-backed View

```lisp
(export employee-directory-view)

(define-view employee-directory-view
  (:query employee-directory)
  (:title "Employee Directory")
  (:description "Compact compiler fixture for a query-backed table view.")
  (:subject session)
  (:mode table)
  (:column employee/name)
  (:column employee/status)
  (:empty-state "No employees found.")
  (:row-action :read))
```
