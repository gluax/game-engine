(asdf:defsystem #:game-engine
  :version "0.0.1"
  :author "Jonathan Pavlik"
  :license "GPL v3"
  :description "A game engine."
  :long-description ""
  :defsystem-depends-on ()
  :depends-on ()
  :build-operation :compile-op
  :serial t
  :components ((:module "src"
                :components
                ((:file "package")
                 (:file "game")
                 (:module "utils"
                  :components
                          ((:file "lazy")))
                 )
                ))
  :in-order-to ((test-op (load-op game-engine-test))))
