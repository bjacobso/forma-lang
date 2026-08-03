---
id: company
version: 0.1.0
preludes:
  - core
---

# Company

Core company org example in canonical ontology syntax.

```lisp
(define-entity Department
  (:field [department/name String {:required true}])
  (:field [department/cost-center String]))

(define-entity Employee
  (:field [employee/name String {:required true}])
  (:field [employee/title String])
  (:field [employee/department (Ref Department)]))
```

```lisp
(define-record "department:engineering" Department
  (:field [department/name "Engineering"])
  (:field [department/cost-center "1001"]))

(define-record "department:finance" Department
  (:field [department/name "Finance"])
  (:field [department/cost-center "2001"]))

(define-record "employee:alice" Employee
  (:field [employee/name "Alice Chen"])
  (:field [employee/title "VP Engineering"])
  (:field [employee/department "department:engineering"]))

(define-record "employee:mario" Employee
  (:field [employee/name "Mario Ruiz"])
  (:field [employee/title "Controller"])
  (:field [employee/department "department:finance"]))
```

```lisp
(define-query employee-directory
  (:from Employee)
  (:select [employee/name employee/title employee/department]))
```
