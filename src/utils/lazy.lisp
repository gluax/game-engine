(in-package #:game-engine)

(defmacro memoize (name args body)
  (let ((hash-name (gensym)))
    `(let ((,hash-name (make-hash-table :test 'equal)))
       (defun ,name ,args
         (or (gethash (list ,@args) ,hash-name)
             (setf (gethash (list ,@args) ,hash-name)
                   ,body))))))


(defun make-stream (fn init)
  (let (v)
    (lambda () (setf v (if v (funcall fn v) init)))))

(defun take (n stream)
  (loop repeat n collect (funcall stream)))

(defun next (stream)
  (car (take 1 stream)))

(defun take-until (pred stream)
  (loop for i from (funcall stream) until (funcall pred i) 
        collect (funcall stream)))

(defun f-take (n stream)
  (let (res)
    (dotimes (i n (reverse res))
      (push (funcall stream res) res))))

(defun f-take-until (pred stream)
  (let ((res (list (funcall stream nil))))
    (loop for i from (car res) until (funcall pred (car res))
          do (push (funcall stream res) res))
    (reverse res)))

(defun file-string (path)
  (with-open-file (stream path)
    (let ((data (make-string (file-length stream))))
      (read-sequence data stream)
      data)))

(defun file-get-lines (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))
