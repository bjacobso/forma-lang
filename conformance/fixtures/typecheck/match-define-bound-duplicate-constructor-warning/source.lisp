(define-type (Option a) (Some a) (None))
(define value (Some 42))
(match value
  (Some x) x
  (Some y) y
  (None) 0)
