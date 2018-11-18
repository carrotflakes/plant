(ql:quickload :plant)

(use-package :plant)

(defvar *functions* nil)
(defvar *variables* nil)


(defun expression ()
  (branch
   (1 `(+ ,(expression) ,(expression)))
   (1 `(- ,(expression) ,(expression)))
   (1 `(* ,(expression) ,(expression)))
   (1 `(zerop ,(expression)))
   (3 (random 10))
   (2 (random-choice (cons 0 *variables*)))
   (1 (if *functions*
          `(,(random-choice *functions*) ,@(loop repeat (random 3)
                                                 collect (expression)))
          '(lambda (x) x)))))

(defun %defun (name)
  (let* ((args (loop
                 repeat (random 3)
                 collect (gensym "V")))
         (*variables* (concatenate 'list args *variables*)))
    `(defun ,name ,args
       ,(expression))))

(defun %defvar (name)
    `(defvar ,name
       ,(expression)))

(defun statements (n)
  (when (<= n 0)
    (return-from statements (list (expression))))
  (branch
   (2 (let* ((name (gensym "F"))
             (*functions* (cons name *functions*)))
        (list* (%defun name)
               (statements (1- n)))))
   (1 (let* ((name (gensym "V"))
             (*variables* (cons name *variables*)))
        (list* (%defvar name)
               (statements (1- n)))))
   (1 (list* (expression)
             (statements (1- n))))))

(defun code ()
  (statements (1+ (random 10))))


(print (code))

(print (code))

(print (code))
