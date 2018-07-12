
(cl:in-package :asdf)

(defsystem "runtime_monitoring-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "winavg" :depends-on ("_package_winavg"))
    (:file "_package_winavg" :depends-on ("_package"))
  ))