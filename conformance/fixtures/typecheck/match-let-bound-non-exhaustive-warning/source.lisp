(define-type (Option a) (Some a) (None))
(let [value (Some 42)]
  (match value
    (Some x) x))
