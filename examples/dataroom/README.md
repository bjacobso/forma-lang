---
id: dataroom
version: 0.1.0
preludes:
  - core
---

# Data Room

Secure deal room example in canonical ontology syntax.

```lisp
(define-entity Room
  (:field [room/name String {:required true}])
  (:field [room/stage String {:required true}]))

(define-entity Document
  (:field [document/title String {:required true}])
  (:field [document/classification String])
  (:field [document/room (Ref Room)]))
```

```lisp
(define-record "room:series-b" Room
  (:field [room/name "Series B"])
  (:field [room/stage "due-diligence"]))

(define-record "document:financials" Document
  (:field [document/title "FY25 Financials"])
  (:field [document/classification "confidential"])
  (:field [document/room "room:series-b"]))
```

```lisp
(define-query room-documents
  (:from Document)
  (:select [document/title document/classification document/room]))
```
