(require 'helm)

(defvar jdh-init-file-prefix "init-jdh-")
(defvar jdh-init-file-suffix ".el")
(defvar jdh-init-file-dir "~/.emacs.d/init/")

(defun jdh-list-init-files ()
  (mapcar #'(lambda (fname)
              (cons
               (substring (file-name-nondirectory fname)
                          (length jdh-init-file-prefix)
                          (- 0 (length jdh-init-file-suffix)))
               fname))
          (directory-files jdh-init-file-dir
                           t
                           (rx-to-string
                            `(and
                              ,jdh-init-file-prefix
                              (+ anything)
                              ,jdh-init-file-suffix
                              eol)))))

(defvar helm-source-jdh-init-files
  `((name . "JDH's init files")
    (candidates . jdh-list-init-files)
    (keymap . ,helm-generic-files-map)
    (help-message . helm-generic-file-help-message)
    (mode-line . helm-generic-file-mode-line-string)
    (candidate-transformer . ,(lambda (xs) xs))
    (type . file)))

(defun jdh-find-init ()
  (interactive)
  (helm :sources 'helm-source-jdh-init-files
        :keymap helm-find-files-map
        :prompt "Init file: "
        :buffer "*Helm Find Files*"))

(provide 'jdh-init-files)
