# Filtered Query

```lisp
(export active-employees)

(define-query active-employees
  (:from Employee)
  (:where (= (get it :employee/status) "active"))
  (:select [employee/name employee/status]))
```
