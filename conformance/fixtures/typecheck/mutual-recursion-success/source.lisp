(define even?
  (fn [n]
    (if (= n 0)
      true
      (odd? (- n 1)))))

(define odd?
  (fn [n]
    (if (= n 0)
      false
      (even? (- n 1)))))

(even? 10)
