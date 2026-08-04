# Records

```lisp
(define-record "department:platform" Department
  (:field [department/name "Platform"])
  (:field [department/code "PLAT"]))

(define-record "employee:ada" Employee
  (:field [employee/name "Ada Lovelace"])
  (:field [employee/status "active"])
  (:field [employee/department "department:platform"]))

(define-record "employee:grace" Employee
  (:field [employee/name "Grace Hopper"])
  (:field [employee/status "onboarding"])
  (:field [employee/department "department:platform"]))
```
