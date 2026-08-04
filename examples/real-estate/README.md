---
id: real-estate
version: 0.1.0
preludes:
  - core
---

# Real Estate

Listings and agents example in canonical ontology syntax.

```lisp
(define-entity Agent
  (:field [agent/name String {:required true}])
  (:field [agent/market String]))

(define-entity Listing
  (:field [listing/address String {:required true}])
  (:field [listing/status String {:required true}])
  (:field [listing/agent (Ref Agent)]))
```

```lisp
(define-record "agent:noah" Agent
  (:field [agent/name "Noah Bennett"])
  (:field [agent/market "Austin"]))

(define-record "listing:oakhill" Listing
  (:field [listing/address "18 Oakhill Drive"])
  (:field [listing/status "active"])
  (:field [listing/agent "agent:noah"]))
```

```lisp
(define-query active-listings
  (:from Listing)
  (:where (= (get it :listing/status) "active"))
  (:select [listing/address listing/status listing/agent]))
```
