(req-package eldoc
  :demand t
  :commands (eldoc-mode)
  :diminish eldoc-mode)

(req-package lisp-mode
  :demand t
  :require (helm evil)
  :commands (jdh-scratch emacs-lisp-mode lisp-interaction-mode)
  :init
  (progn
    (evil-ex-define-cmd "scratch" 'jdh-scratch)
    (setq-default initial-scratch-message nil)
    (add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
    (define-key evil-insert-state-map [remap completion-at-point]
      'helm-lisp-completion-at-point))
  :config
  (progn
    (evil-define-command jdh-scratch ()
      (interactive)
      (with-current-buffer (get-buffer-create "*scratch*")
        (lisp-interaction-mode))
      (switch-to-buffer "*scratch*"))))

(provide 'init-jdh-elisp)
