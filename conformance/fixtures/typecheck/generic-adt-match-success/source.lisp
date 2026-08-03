(define-type (Maybe a) (Some a) (None))
(match (Some 1)
  (Some x) x
  (None) 0)
