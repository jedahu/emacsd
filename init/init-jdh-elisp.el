(req-package emacs-lisp-mode
  :defer t
  :require (helm evil-scout)
  :diminish eldoc-mode
  :init
  (progn
    (define-key evil-insert-state-map [remap completion-at-point]
      'helm-lisp-completion-at-point))
  :config
  (progn
    (add-hook 'emacs-lisp-mode-hook 'eldoc-mode)))

(provide 'init-jdh-elisp)
