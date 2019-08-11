(in-package #:game-engine)

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

(defun list-stream (list)
  (when list (cons (car list) (lambda () (list-stream (cdr list))))))

(defun map-stream (fn stream)
  (if (funcall (cdr stream))
      (cons (funcall fn (car stream)) (lambda () (map-stream fn (funcall (cdr stream)))))
      (cons (funcall fn (car stream)) nil)))

(defun take-list (n list)
  (cond ((= n 0) nil)
        ((null list) list)
        ((null (cdr list)) (cons (car list) nil))
        (t (cons (car list) (take-list (1- n) (funcall (cdr list)))))))
