---
id: fantasy
version: 0.1.0
preludes:
  - core
---

# Fantasy

Fantasy realm example in canonical ontology syntax.

```lisp
(define-entity Realm
  (:field [realm/name String {:required true}])
  (:field [realm/element String]))

(define-entity Hero
  (:field [hero/name String {:required true}])
  (:field [hero/class String])
  (:field [hero/realm (Ref Realm)]))
```

```lisp
(define-record "realm:emberfall" Realm
  (:field [realm/name "Emberfall"])
  (:field [realm/element "fire"]))

(define-record "hero:lyra" Hero
  (:field [hero/name "Lyra"])
  (:field [hero/class "warden"])
  (:field [hero/realm "realm:emberfall"]))
```

```lisp
(define-query heroes
  (:from Hero)
  (:select [hero/name hero/class hero/realm]))
```
