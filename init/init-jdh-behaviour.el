(req-package debug
  :defer t
  :config
  (progn
    (add-hook 'focus-out-hook 'evil-normal-state)
    (setq-default
     debug-ignored-errors
     (append
      '("pattern not found"
        "No previous search")
      debug-ignored-errors))))

(req-package jdh-backup
  :defer t
  :commands (jdh-backup-buffer-force jdh-backup-save-all)
  :init
  (progn
    (add-hook 'before-save-hook 'jdh-backup-buffer-force)
    (add-hook 'focus-out-hook 'jdh-backup-save-all))
  :config
  (progn
    (global-auto-revert-mode t)
    (setq-default
     compilation-ask-about-save nil
     backup-directory-alist `(("." . ,(jdh-emacsd-dir ".backup/per-save")))
     version-control t
     backup-by-copying t
     kept-new-versions 10
     kept-old-versions 0
     delete-old-versions t
     vc-make-backup-files t)))

(provide 'init-jdh-behaviour)
