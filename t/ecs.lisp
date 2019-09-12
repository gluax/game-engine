(in-package #:game-engine-test)

(new-component "ename" (ename :accessor ename))
(new-component "health" (hp :accessor hp))
(new-component "attack" (atk :accessor atk))
(new-component "speed" (sv :accessor sv))

(defun enemy-assemblage (name hp atk sv)
  (let ((entity (make-entity))
        (ename (make-ename-component name))
        (health (make-health-component hp))
        (atk (make-attack-component atk))
        (speed (make-speed-component sv)))
    (add-component entity ename)
    (add-component entity health)
    (add-component entity atk)
    (add-component entity speed)
    (add-to-system entity :ENEMY)
    entity))

(new-parallel-system ENEMY (format nil "A ~A appears with hp: ~D atk: ~D sv: ~D" (ename (gethash :ENAME value)) (hp (gethash :HEALTH value)) (atk (gethash :ATTACK value)) (sv (gethash :SPEED value))))

(defvar *cat* (enemy-assemblage "cat" 7 3 10))
(defvar *cow* (enemy-assemblage "cow" 15 5 3))
(defvar *out* (join-parallel-system (enemy-parallel-system)))


(plan 8)

(is 4 (hash-table-count (components *cat*)))
(is 4 (hash-table-count (components *cow*)))
(is 2 (count-in-system :ENEMY))

(defvar *cow2* (enemy-assemblage "cow" 15 5 3))
(is 4 (hash-table-count (components *cow2*)))
(is 3 (count-in-system :ENEMY))

(remove-component *cow2* :HEALTH)
(is 3 (hash-table-count (components *cow2*)))

(remove-from-system *cow2* :ENEMY)
(is 2 (count-in-system :ENEMY))

(is *out* '("A cat appears with hp: 7 atk: 3 sv: 10" "A cow appears with hp: 15 atk: 5 sv: 3") :test #'equalp)

(finalize)
