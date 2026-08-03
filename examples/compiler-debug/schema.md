# Schema

```lisp
(export Department Employee)

(define-entity Department
  (:field [department/name String {:required true}])
  (:field [department/code String]))

(define-entity Employee
  (:field [employee/name String {:required true}])
  (:field [employee/status String])
  (:field [employee/department (Ref Department)]))
```
