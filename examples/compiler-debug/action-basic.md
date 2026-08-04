# Basic Action

```lisp
(export mark-active)

(define-action mark-active
  (:input [employee Employee])
  (:returns Boolean)
  (:do
    (do
      (set-field employee :employee/status "active")
      (= (get employee :employee/status) "active"))))
```
