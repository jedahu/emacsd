(req-package dired
  :defer t
  :require (evil)
  :config
  (progn
    (define-key dired-mode-map [override-state] nil)
    (add-hook 'dired-mode-hook 'evil-normalize-keymaps)))

(provide 'init-jdh-dired)
