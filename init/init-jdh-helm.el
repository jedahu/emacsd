(req-package helm
  :defer t
  :config
  (progn
    (setq-default completion-at-point-functions nil)
    (req-package-force helm-ls-git :demand t)
    (req-package-force helm-ls-hg :demand t)))

(provide 'init-jdh-matching)
