(in-package :cl-user)
(defpackage #:salvage-test
  (:use #:cl #:asdf))
(in-package #:salvage-test)

(defsystem salvage-test
  :author ""
  :license ""
  :depends-on (:salvage)
  :components ((:module "t"
                :components
                ((:file "lazy"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
