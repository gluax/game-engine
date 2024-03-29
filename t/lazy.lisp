(in-package #:game-engine-test)


(defvar *natural* (make-stream #'1+ 0))

(defvar *fibonacci*
  (lambda (x)
    (cond ((null x) 0)
          ((= (length x) 1) 1)
          (t (+ (car x) (cadr x))))))

(defvar *list* (list-stream '(1 2 3)))
(defvar *1+* (map-stream #'1+ *list*))

(plan 9)

(is '(0 1 2 3 4 5 6 7 8 9 10 11) (take 12 *natural*) :test #'equalp)
(is 12 (next *natural*))
(is '(14 15 16 17 18 19 20 21) (take-until (lambda (x) (> x 20)) *natural*)  :test #'equalp)

(is '(0 1 1 2 3 5 8 13 21 34 55 89) (f-take 12 *fibonacci*) :test #'equalp)
(is '(0 1 1 2 3 5 8 13) (f-take-until (lambda (x) (> x 10)) *fibonacci*) :test #'equalp)

(is '(1 2 3) (take-list 3 *list*) :test #'equalp)
(is '(1 2) (take-list 2 *list*) :test #'equalp)
(is '(2 3) (take-list 2 *1+*) :test #'equalp)
(is '(2 3 4) (take-list 3 *1+*) :test #'equalp)

(finalize)
