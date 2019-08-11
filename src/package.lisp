(defpackage #:game-engine
  (:use #:cl)
  (:export #:make-stream
           #:take
           #:next
           #:take-until
           #:f-take
           #:f-take-until
           #:list-stream
           #:map-stream
           #:take-list))
