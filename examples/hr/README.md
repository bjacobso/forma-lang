---
id: hr
version: 0.1.0
preludes:
  - core
---

# HR

HR onboarding example in canonical ontology syntax.

```lisp
(define-entity Candidate
  (:field [candidate/name String {:required true}])
  (:field [candidate/email String])
  (:field [candidate/status String {:required true}]))

(define-entity Offer
  (:field [offer/title String {:required true}])
  (:field [offer/status String {:required true}])
  (:field [offer/candidate (Ref Candidate)]))
```

```lisp
(define-record "candidate:sam" Candidate
  (:field [candidate/name "Sam Patel"])
  (:field [candidate/email "sam@example.com"])
  (:field [candidate/status "interviewing"]))

(define-record "candidate:taylor" Candidate
  (:field [candidate/name "Taylor Brooks"])
  (:field [candidate/email "taylor@example.com"])
  (:field [candidate/status "hired"]))

(define-record "offer:taylor" Offer
  (:field [offer/title "Customer Success Manager"])
  (:field [offer/status "accepted"])
  (:field [offer/candidate "candidate:taylor"]))
```

```lisp
(define-query active-offers
  (:from Offer)
  (:select [offer/title offer/status offer/candidate]))
```
