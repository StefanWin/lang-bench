(defun byte-copy (infile outfile)
  (declare (optimize (speed 3)))
  (with-open-file (instream infile :direction :input :element-type '(unsigned-byte 8)
				   :if-does-not-exist nil)
    (when instream
      (with-open-file (outstream outfile :direction :output :element-type '(unsigned-byte 8)
					 :if-exists :supersede)
        (time (loop for byte = (read-byte instream nil)
		    while byte
		    do (write-byte byte outstream)))))))

(byte-copy "../img.raw" "./list_img.raw")
