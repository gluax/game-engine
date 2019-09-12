(in-package #:game-engine)

;; Base Component class for an ECS
(defclass component ()
  ())

;; A macro that creates a component class that extends the base component class and creates a constructor for it.
(defmacro new-component (component-name &rest body)
  (let* ((cname (intern (format nil "~:@(~a~)-COMPONENT" (string-upcase component-name))))
         (fname (intern (format nil "MAKE-~:@(~a~)" cname))))
    `(progn (defclass ,cname (component)
              ((,cname
                :initform (intern (format nil "~:@(~a~)" ,component-name) "KEYWORD")
                :accessor name)
               ,@body))
            (defun ,fname (&rest slot-values)
              (let ((instance (make-instance ',cname)))
                (loop for value in slot-values
                      for slot in (cdr (sb-pcl:class-slots (class-of instance)))
                      do (setf (slot-value instance (sb-pcl:slot-definition-name slot)) value)
                      finally (return instance))))
            )))
