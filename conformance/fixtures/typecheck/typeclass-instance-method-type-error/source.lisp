(define-typeclass (Show a)
  (show (-> a Str)))
(instance (Show Num)
  (define show (fn [x] 42)))
