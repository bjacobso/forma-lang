# Basic Query

```lisp
(export employee-directory)

(define-query employee-directory
  (:from Employee)
  (:select [employee/name employee/status employee/department]))
```
