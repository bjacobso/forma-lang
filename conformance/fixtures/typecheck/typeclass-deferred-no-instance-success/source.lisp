(define-typeclass (Show a)
  (show (-> a Str)))
(show 42)
