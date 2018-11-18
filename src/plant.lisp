(defpackage plant
  (:use :cl)
  (:export :random-choice
           :random-choice-with-probability
           :branch
           :defgrowth))
(in-package :plant)

(defun random-choice (list)
  (nth (random (length list)) list))

(defun random-choice-with-probability (alist)
  (let ((sum (reduce #'+ alist :key #'car)))
    (when (<= sum 0)
      (error "Probabilities need to be a positive number by sum"))
    (let ((number (random (float sum))))
      (dolist (item alist)
        (if (< number (car item))
            (return-from random-choice-with-probability (cdr item))
            (decf number (car item)))))))

(defmacro branch (&body patterns)
  `(case (random-choice-with-probability
          ',(loop
              for pattern in patterns
              for i from 0
              collect (cons (first pattern) i)))
     ,@(loop
         for pattern in patterns
         for i from 0
         collect `(,i ,(second pattern)))))

(defmacro defgrowth (name args &body patterns)
  `(defun ,name ,args
     (branch ,patterns)))
