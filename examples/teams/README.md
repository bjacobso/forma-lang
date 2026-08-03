---
id: teams
version: 0.1.0
preludes:
  - core
---

# Teams

Small team topology example in canonical ontology syntax.

```lisp
(define-entity Team
  (:field [team/name String {:required true}])
  (:field [team/focus String]))

(define-entity Member
  (:field [member/name String {:required true}])
  (:field [member/role String])
  (:field [member/team (Ref Team)]))
```

```lisp
(define-record "team:platform" Team
  (:field [team/name "Platform"])
  (:field [team/focus "Developer infrastructure"]))

(define-record "team:growth" Team
  (:field [team/name "Growth"])
  (:field [team/focus "Lifecycle experiments"]))

(define-record "member:alex" Member
  (:field [member/name "Alex Kim"])
  (:field [member/role "Staff Engineer"])
  (:field [member/team "team:platform"]))

(define-record "member:jordan" Member
  (:field [member/name "Jordan Lee"])
  (:field [member/role "Product Manager"])
  (:field [member/team "team:growth"]))
```

```lisp
(define-query team-members
  (:from Member)
  (:select [member/name member/role member/team]))
```
