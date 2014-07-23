(require 'projectile)
(require 'helm-ag)

(projectile-global-mode 1)

(setq-default projectile-switch-project-action 'projectile-dired)
(setq-default projectile-indexing-method 'alien)
(setq-default projectile-enable-caching t)

(defun helm-projectile-ag ()
  (interactive)
  (helm-ag (projectile-project-root)))
