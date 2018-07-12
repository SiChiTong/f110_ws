;; Auto-generated. Do not edit!


(when (boundp 'runtime_monitoring::winavg)
  (if (not (find-package "RUNTIME_MONITORING"))
    (make-package "RUNTIME_MONITORING"))
  (shadow 'winavg (find-package "RUNTIME_MONITORING")))
(unless (find-package "RUNTIME_MONITORING::WINAVG")
  (make-package "RUNTIME_MONITORING::WINAVG"))

(in-package "ROS")
;;//! \htmlinclude winavg.msg.html


(defclass runtime_monitoring::winavg
  :super ros::object
  :slots (_avg _windowsize ))

(defmethod runtime_monitoring::winavg
  (:init
   (&key
    ((:avg __avg) 0.0)
    ((:windowsize __windowsize) 0)
    )
   (send-super :init)
   (setq _avg (float __avg))
   (setq _windowsize (round __windowsize))
   self)
  (:avg
   (&optional __avg)
   (if __avg (setq _avg __avg)) _avg)
  (:windowsize
   (&optional __windowsize)
   (if __windowsize (setq _windowsize __windowsize)) _windowsize)
  (:serialization-length
   ()
   (+
    ;; float64 _avg
    8
    ;; int32 _windowsize
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _avg
       (sys::poke _avg (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int32 _windowsize
       (write-long _windowsize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _avg
     (setq _avg (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int32 _windowsize
     (setq _windowsize (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get runtime_monitoring::winavg :md5sum-) "ee07ea8681a58f4616a5f3928b9086e8")
(setf (get runtime_monitoring::winavg :datatype-) "runtime_monitoring/winavg")
(setf (get runtime_monitoring::winavg :definition-)
      "float64 avg
int32 windowsize

")



(provide :runtime_monitoring/winavg "ee07ea8681a58f4616a5f3928b9086e8")


