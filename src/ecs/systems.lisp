(in-package #:game-engine)

;; A macro that defines a function to loop through all entities in a system.
(defmacro new-system (name &rest body)
  (let ((fname (intern (format nil "~A-SYSTEM" name)))
        (systype (intern (format nil "~A" name) "KEYWORD")))
    `(defun ,fname ()
       (loop for entity being the hash-values of (gethash ',systype *entities-systems*)
             using (hash-key key)
             do (let ((value (components entity)))
                  (progn ,@body))
             ))))


;; A macro that defines a function to loop through all entities in a system.
;; It also does all that work in a thread.
;; Returns a list of those treads.
(defmacro new-parallel-system (name &rest body)
  (let ((fname (intern (format nil "~A-PARALLEL-SYSTEM" name)))
        (systype (intern (format nil "~A" name) "KEYWORD")))
    `(defun ,fname ()
       (loop for entity being the hash-values of (gethash ',systype *entities-systems*)
             using (hash-key key)
             collect (let ((value (components entity)))
                       (bt:make-thread (lambda () (progn ,@body))))
             ))))

;; Ensures all threads are done,
(defun join-parallel-system (threads)
  (mapcar #'bt:join-thread threads))
