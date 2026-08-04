# HTTP API

Compiler fixture for declarative HTTP API authoring. This is intentionally kept
outside the registered product examples; the OCaml corpus uses it to keep the
canonical HTTP API IR shape golden-stable while the TypeScript runtime
translator is still pending.

```lisp
(define-schema DebugBlobHash
  (:kind string)
  (:pattern "^[a-f0-9]{64}$")
  (:brand "DebugBlobHash")
  (:doc "64-character lowercase hex blob hash"))

(define-schema DebugBlobUploadResponse
  (:kind struct)
  (:fields
    (field hash DebugBlobHash)
    (field size Int)
    (field mime-type String)
    (field filename (Optional String))
    (field is-new Bool))
  (:identifier "DebugBlobUploadResponse"))

(define-error DebugDatabaseNotFound
  (:fields (field database String))
  (:status 404))

(define-error DebugBlobUploadError
  (:fields (field reason String))
  (:status 500))

(define-api-group debug-blobs
  (:path-params
    (param database String)
    (param hash DebugBlobHash))

  (endpoint upload
    (:method POST)
    (:path "/db/{database}/debug-blobs")
    (:payload Uint8Array)
    (:query
      (field filename (Optional String)))
    (:success DebugBlobUploadResponse)
    (:errors DebugDatabaseNotFound DebugBlobUploadError InternalError))

  (endpoint metadata
    (:method GET)
    (:path "/db/{database}/debug-blobs/{hash}/metadata")
    (:success DebugBlobUploadResponse)
    (:errors DebugDatabaseNotFound InternalError)))
```
