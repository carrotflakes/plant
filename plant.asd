#|
  This file is a part of plant project.
  Copyright (c) 2018 carrotflakes (carrotflakes@gmail.com)
|#

#|
  Author: carrotflakes (carrotflakes@gmail.com)
|#

(defsystem "plant"
  :version "0.1.0"
  :author "carrotflakes"
  :license "LLGPL"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "plant"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "plant-test"))))
