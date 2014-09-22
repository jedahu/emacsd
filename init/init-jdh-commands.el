(req-package dired-x
  :defer t
  :require (evil helm)
  :commands (jdh-find-init)
  :init
  (progn
    (evil-ex-define-cmd "jinit" 'jdh-find-init)
    (define-key evil-ex-map "jinit " 'jdh-find-init))
  :config
  (progn
    (defvar jdh-init-file-prefix "init-jdh-")
    (defvar jdh-init-file-suffix ".el")
    (defun jdh-list-init-files ()
      (mapcar #'(lambda (fname)
                  (cons
                   (substring (file-name-nondirectory fname)
                              (length jdh-init-file-prefix)
                              (- 0 (length jdh-init-file-suffix)))
                   fname))
       (directory-files (jdh-emacsd-dir "init")
                        t
                        (rx-to-string
                         `(and
                           ,jdh-init-file-prefix
                           (+ anything)
                           ,jdh-init-file-suffix
                           eol)))))
    (defvar helm-source-jdh-init-files nil)
    (setq-default helm-source-jdh-init-files
      `((name . "JDH's init files")
        (candidates . jdh-list-init-files)
        (keymap . ,helm-generic-files-map)
        (help-message . helm-generic-file-help-message)
        (mode-line . helm-generic-file-mode-line-string)
        (candidate-transformer . ,(lambda (xs) xs))
        ;(action . (("Open" . ,(lambda (x)
        ;             (find-file (concat (jdh-emacsd-dir "init") x))))))
        (type . file)))
    (defun jdh-find-init ()
      (interactive)
      (helm :sources 'helm-source-jdh-init-files
            ;:case-fold-search helm-file-name-case-fold-search
            :keymap helm-find-files-map
            :prompt "Init file: "
            :buffer "*Helm Find Files*"))))

(provide 'init-jdh-commands)
