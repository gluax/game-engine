(asdf:defsystem #:salvage
  :version "0.0.1"
  :author "Jonathan Pavlik"
  :license ""
  :description "A game."
  :long-description ""
  :defsystem-depends-on ()
  :depends-on ()
  :build-operation :program-op
  :build-pathname "main"
  :entry-point "salvage:main"
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
  :in-order-to ((asdf:test-op (asdf:load-op salvage-test))))
