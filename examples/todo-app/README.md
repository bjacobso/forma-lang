---
id: todo-app
version: 1.0.0
description: Todo list application ontology
preludes:
  - core
---

# Todo Application Ontology

A simple todo list application with support for adding, listing, and marking tasks as complete.

## Entity: Todo

Represents a task item in the todo list.

```lisp
(define-entity Todo
  (:field [todo/title String {:required true}])
  (:field [todo/completed Boolean {:default false}]))
```

## Queries

### List All Todos

Returns all todo items in the system.

```lisp
(define-query list-todos
  (:from Todo)
  (:select [todo/title todo/completed]))
```

### List Incomplete Todos

Returns only todos that haven't been completed yet.

```lisp
(define-query list-incomplete-todos
  (:from Todo)
  (:where (= (get it :todo/completed) false))
  (:select [todo/title]))
```

## Actions

### Add Todo

Creates a new todo item with the given title and returns its entity id.

```lisp
(define-action add-todo
  (:input [title String])
  (:returns String)
  (:do
    (create! "Todo"
      :todo/title title
      :todo/completed false)))
```

### Mark Todo as Done

Updates a todo item to mark it as completed.

```lisp
(define-action mark-done
  (:input [todo Todo])
  (:returns Boolean)
  (:do
    (do
      (set-field todo :todo/completed true)
      true)))
```

### Delete Todo

Retracts the current todo facts from the system while preserving time-travel history.

```lisp
(define-action delete-todo
  (:input [todo Todo])
  (:returns Boolean)
  (:do
    (do
      (retract! (id todo) ":todo/title")
      (retract! (id todo) ":todo/completed")
      (retract! (id todo) ":_schema/type")
      true)))
```

## View: Todo List Manager

A comprehensive view for managing the todo list with add, complete, and delete capabilities.

```lisp
(define-view todo-list-manager
  (:query list-todos)
  (:title "Todo List Manager")
  (:description "Add todos, inspect all tasks, and run completion or delete actions.")
  (:subject session)
  (:state newTitle "" (:type string))
  (:state selectedTodo nil)
  (:named-query todos (:ref list-todos))
  (:layout
    (rows
      (heading "Todo List Manager")
      (columns
        (input {:name "newTitle"
                :label "Task"
                :placeholder "What needs to be done?"})
        (action-button {:action-ref "add-todo"
                        :label "Add Todo"
                        :parameters {:title (state newTitle)}
                        :variant "default"}))
      (table {:bind (query todos)
              :columns [{:key "?title" :label "Task"}
                        {:key "?completed" :label "Done" :kind "boolean"}
                        {:key "?id" :label "ID" :kind "mono"}]
              :empty-state "No todos yet."})
      (columns
        (entity-picker {:name "selectedTodo"
                        :label "Todo"
                        :entity-type "Todo"
                        :placeholder "Select todo"})
        (action-button {:action-ref "mark-done"
                        :label "Mark Complete"
                        :parameters {:todo (get (state selectedTodo) :entityId)}
                        :variant "secondary"
                        :visible (not (nil? (state selectedTodo)))})
        (action-button {:action-ref "delete-todo"
                        :label "Delete"
                        :parameters {:todo (get (state selectedTodo) :entityId)}
                        :variant "destructive"
                        :visible (not (nil? (state selectedTodo)))})))))
```
