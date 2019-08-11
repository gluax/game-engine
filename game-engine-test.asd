(defsystem game-engine-test
  :author "Jonathan Pavlik"
  :license "GPL V3"
  :depends-on (#:game-engine #:prove)
  :components ((:module "t"
                :components
                ((:file "package")
                 (:file "lazy"))
                ))
  :perform (load-op :after (op c) (asdf:clear-system c)))
