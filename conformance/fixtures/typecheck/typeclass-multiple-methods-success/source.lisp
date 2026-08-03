(define-typeclass (Show a)
  (show (-> a Str))
  (show-list (-> (List a) Str)))
(show 42)
