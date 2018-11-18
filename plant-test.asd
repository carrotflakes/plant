#|
  This file is a part of plant project.
  Copyright (c) 2018 carrotflakes (carrotflakes@gmail.com)
|#

(defsystem "plant-test"
  :defsystem-depends-on ("prove-asdf")
  :author "carrotflakes"
  :license "LLGPL"
  :depends-on ("plant"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "plant"))))
  :description "Test system for plant"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
