---
id: bizops
version: 0.1.0
preludes:
  - core
---

# BizOps

Revenue and operations example in canonical ontology syntax.

```lisp
(define-entity Account
  (:field [account/name String {:required true}])
  (:field [account/segment String]))

(define-entity Invoice
  (:field [invoice/status String {:required true}])
  (:field [invoice/amount Number])
  (:field [invoice/account (Ref Account)]))
```

```lisp
(define-record "account:northstar" Account
  (:field [account/name "Northstar Health"])
  (:field [account/segment "enterprise"]))

(define-record "invoice:1001" Invoice
  (:field [invoice/status "open"])
  (:field [invoice/amount 18500])
  (:field [invoice/account "account:northstar"]))
```

```lisp
(define-query revenue-open-invoices
  (:from Invoice)
  (:where (= (get it :invoice/status) "open"))
  (:select [invoice/status invoice/amount invoice/account]))
```
