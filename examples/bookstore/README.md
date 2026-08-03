---
id: bookstore
version: 0.1.0
preludes:
  - core
---

# Bookstore

Bookstore catalog example in canonical ontology syntax.

```lisp
(define-entity Author
  (:field [author/name String {:required true}]))

(define-entity Book
  (:field [book/title String {:required true}])
  (:field [book/genre String])
  (:field [book/author (Ref Author)]))
```

```lisp
(define-record "author:le-guin" Author
  (:field [author/name "Ursula K. Le Guin"]))

(define-record "book:earthsea" Book
  (:field [book/title "A Wizard of Earthsea"])
  (:field [book/genre "fantasy"])
  (:field [book/author "author:le-guin"]))
```

```lisp
(define-query catalog
  (:from Book)
  (:select [book/title book/genre book/author]))
```
