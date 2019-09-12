(defpackage #:game-engine
  (:use #:cl #:bordeaux-threads)
  (:export
   ;;; game
   #:main
   
   ;;; ecs
   #:count-in-system
   #:name
   #:systype
   #:components
   #:value
   #:new-component
   #:make-entity
   #:add-component
   #:add-to-system
   #:remove-from-system
   #:remove-component
   #:new-system
   #:new-parallel-system
   #:join-parallel-system
   
   ;;; lazy
   #:make-stream
   #:take
   #:next
   #:take-until
   #:f-take
   #:f-take-until
   #:list-stream
   #:map-stream
   #:take-list))
