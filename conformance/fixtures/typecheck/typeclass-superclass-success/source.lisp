(define-typeclass (Eq a)
  (eq (-> a a Bool)))
(define-typeclass (Ord a) [(Eq a)]
  (compare (-> a a Num)))
(compare 1 2)
