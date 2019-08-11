(defpackage #:game-engine
  (:use #:cl)
  (:export #:memoize
           #:make-stream
           #:take
           #:next
           #:take-until
           #:f-take
           #:f-take-until
           #:file-string))
