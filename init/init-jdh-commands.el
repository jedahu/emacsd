(defun jdh-install-packages ()
  (interactive)
  (dolist (p jdh:packages)
    (when (not (package-installed-p p))
      (package-install p))))

(defun jdh-find-init-file ()
  (interactive)
  (find-file user-init-file))

(provide 'init-jdh-commands)
