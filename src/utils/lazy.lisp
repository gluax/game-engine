(in-package #:salvage)

(defmacro memoize (name args body)
  (let ((hash-name (gensym)))
    `(let ((,hash-name (make-hash-table :test 'equal)))
       (defun ,name ,args
         (or (gethash (list ,@args) ,hash-name)
             (setf (gethash (list ,@args) ,hash-name)
                   ,body))))))

(defstruct lazy ()
  ((val :initarg :val)))

(defmacro lazy (item)
  `(make-instance 'lazy
                  :val (lambda () ,item)))

(defgeneric force (lazy))

(defmethod force ((lazy lazy))
  (funcall (slot-value lazy 'val)))

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

;; (defvar *natural* (make-stream #'1+ 0))
;; (take 12 *natural*) -> (0 1 2 3 4 5 6 7 8 9 10 11)
;; (next *natural*) -> 12
;; (take-until (lambda (x) (> x 20)) *natural*) -> (14 15 16 17 18 19 20 21)

(defun f-take (n stream)
  (let (res)
    (dotimes (i n (reverse res))
      (push (funcall stream res) res))))

(defun f-take-until (pred stream)
  (let ((res (list (funcall stream nil))))
    (loop for i from (car res) until (funcall pred (car res))
          do (push (funcall stream res) res))
    (reverse res)))

;; (defvar fibonacci
;;   (lambda (x)
;;     (cond ((null x) 0)
;;           ((= (length x) 1) 1)
;;           (t (+ (car x) (cadr x))))))

;; (f-take 12 fibonacci) -> (0 1 1 2 3 5 8 13 21 34 55 89)
;; (f-take-until (lambda (x) (> x 10)) fibonacci) -> (0 1 1 2 3 5 8 13)

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
