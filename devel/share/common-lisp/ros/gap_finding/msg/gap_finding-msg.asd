
(cl:in-package :asdf)

(defsystem "gap_finding-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "Gap" :depends-on ("_package_Gap"))
    (:file "_package_Gap" :depends-on ("_package"))
    (:file "gaps" :depends-on ("_package_gaps"))
    (:file "_package_gaps" :depends-on ("_package"))
  ))