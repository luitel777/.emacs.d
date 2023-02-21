(let ((default-directory user-emacs-directory)
      (file-name-handler-alist nil)
      (gc-cons-percentage .6)
      (gc-cons-threshold most-positive-fixnum)
      (read-process-output-max (* 1024 1024))))

(package-initialize)
(org-babel-load-file "/home/owl/.emacs.d/config.org")
