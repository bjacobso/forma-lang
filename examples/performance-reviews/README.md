---
id: performance-reviews
version: 0.1.0
preludes:
  - core
---

# Performance Reviews

Performance review cycle example in canonical ontology syntax.

```lisp
(define-entity ReviewCycle
  (:field [review-cycle/name String {:required true}])
  (:field [review-cycle/status String {:required true}]))

(define-entity Review
  (:field [review/employee-name String {:required true}])
  (:field [review/rating Number])
  (:field [review/cycle (Ref ReviewCycle)]))
```

```lisp
(define-record "cycle:2026-h1" ReviewCycle
  (:field [review-cycle/name "2026 H1"])
  (:field [review-cycle/status "open"]))

(define-record "review:alex" Review
  (:field [review/employee-name "Alex Kim"])
  (:field [review/rating 4.5])
  (:field [review/cycle "cycle:2026-h1"]))
```

```lisp
(define-query review-ratings
  (:from Review)
  (:select [review/employee-name review/rating review/cycle]))
```
