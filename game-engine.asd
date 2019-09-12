(asdf:defsystem #:game-engine
  :version "0.0.1"
  :author "Jonathan Pavlik"
  :license "GPL v3"
  :description "A game engine."
  :long-description ""
  :defsystem-depends-on ()
  :depends-on (#:bordeaux-threads)
  :build-operation :program-op
  :build-pathname "game"
  :entry-point "game-engine:main"
  :serial t
  :components ((:module "src"
                :components
                ((:file "package")
                 (:module "ecs"
                  :components
                          ((:file "components")
                           (:file "entities")
                           (:file "systems")))
                 (:module "utils"
                  :components
                          ((:file "lazy")
                           (:file "misc")))
                 (:file "game")
                 )
                ))
  :in-order-to ((test-op (load-op game-engine-test))))
