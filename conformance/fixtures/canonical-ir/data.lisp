(define-record "department:platform" Department
  (:field [department/name "Platform"]))

(define-record "employee:ada" Employee
  (:field [employee/name "Ada Lovelace"])
  (:field [employee/department "department:platform"]))
