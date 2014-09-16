(req-package dired-x
  :require (ffap)
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
      '("pattern not found")
      debug-ignored-errors))))

(provide 'init-jdh-behaviour)
