(req-package projectile
  :defer t
  :require helm-ag
  :init (projectile-global-mode 1)
  :config
  (progn
    (setq-default projectile-switch-project-action 'projectile-dired)
    (setq-default projectile-indexing-method 'alien)
    (setq-default projectile-enable-caching t)

    (defun helm-projectile-ag ()
      (interactive)
      (helm-ag (projectile-project-root)))))

(provide 'init-jdh-project)
