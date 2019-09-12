(in-package #:game-engine)

;; An Entity class for an ECS
(defclass entity ()
  ((id
    :initform (gensym)
    :accessor id)
   (components
    :initform (make-hash-table :test #'eql)
    :accessor components)))

;; Entities var to store all created entities
;; Also one to group them by their component systems
(defparameter *entities* (make-hash-table :test #'eql))
(defparameter *entities-systems* (make-hash-table :test #'eql))

(defun count-in-system (sysname)
  (hash-table-count (gethash sysname *entities-systems*)))

;; Entity Constructor creates an entity and adds it to global map of entities.
(defun make-entity ()
  (let ((e (make-instance 'entity)))
    (setf (gethash (id e) *entities*) e)
    e))

;; Entity Method to add a component
(defmethod add-component ((e entity) component)
  (setf (gethash (name component) (components e)) component))

;; Entity method to remove a component
(defmethod remove-component ((e entity) component)
  (remhash component (components e)))

;; Stores the entity in the appropiate sub map of the globaly mapping of systems to entities.
(defmethod add-to-system ((e entity) system)
  (if (gethash system *entities-systems*)
      (setf (gethash (id e) (gethash system *entities-systems*)) e)
      (progn (setf (gethash system *entities-systems*) (make-hash-table :test #'eql))
             (setf (gethash (id e) (gethash system *entities-systems*)) e))))

(defmethod remove-from-system ((e entity) system)
  (if (gethash system *entities-systems*)
      (remhash (id e) (gethash system *entities-systems*))))

