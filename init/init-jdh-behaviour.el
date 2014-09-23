(req-package dired-x
  :demand t
  :init
  (progn
    (global-auto-revert-mode t)

    (setq-default compilation-ask-about-save nil)

    (defun jdh-save-all ()
      (interactive)
      (save-some-buffers t))

    (add-hook 'focus-out-hook 'jdh-save-all)))

(req-package debug
  :defer t
  :config
  (progn
    (setq-default
     debug-ignored-errors
     (append
      '("pattern not found"
        "No previous search")
      debug-ignored-errors))))

(provide 'init-jdh-behaviour)
