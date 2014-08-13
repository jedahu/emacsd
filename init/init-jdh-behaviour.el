(require 'dired-x)
(require 'ffap)

(global-auto-revert-mode t)

(setq-default compilation-ask-about-save nil)

(defun jdh-save-all ()
  (interactive)
  (save-some-buffers t))

(add-hook 'focus-out-hook 'jdh-save-all)
