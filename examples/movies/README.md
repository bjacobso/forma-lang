---
id: movies
version: 0.1.0
preludes:
  - core
---

# Movies

Movies catalog example in canonical ontology syntax.

```lisp
(define-entity Studio
  (:field [studio/name String {:required true}]))

(define-entity Movie
  (:field [movie/title String {:required true}])
  (:field [movie/release-year Number])
  (:field [movie/studio (Ref Studio)]))
```

```lisp
(define-record "studio:a24" Studio
  (:field [studio/name "A24"]))

(define-record "movie:past-lives" Movie
  (:field [movie/title "Past Lives"])
  (:field [movie/release-year 2023])
  (:field [movie/studio "studio:a24"]))
```

```lisp
(define-query releases
  (:from Movie)
  (:select [movie/title movie/release-year movie/studio]))
```
