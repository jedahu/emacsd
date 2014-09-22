(req-package helm-ag
  :require (helm))

(req-package helm-projectile
  :defer t
  :require (helm-ag projectile evil)
  :commands (helm-projectile-switch-project helm-projectile helm-projectile-ag)
  :init
  (progn
    (evil-ex-define-cmd "sw[itch-project]" 'helm-projectile-switch-project)
    ;(evil-ex-define-cmd "p[roject-file]" 'helm-projectile)
    ;(evil-ex-define-cmd "P[roject-file]" 'jdh-helm-projectile-no-cache)
    (define-key evil-ex-map "sw " 'helm-projectile-switch-project)
    ;(define-key evil-ex-map "p " 'helm-projectile)
    ;(define-key evil-ex-map "P " 'jdh-helm-projectile-no-cache)
    (evil-ex-define-cmd "agp[roject]" 'helm-projectile-ag)
    (define-key evil-ex-map "agp " 'helm-projectile-ag)
    )
  :config
  (progn
    (setq-default projectile-completion-system 'helm)
    (setq-default projectile-switch-project-action 'projectile-dired)
    (setq-default projectile-indexing-method 'alien)
    (setq-default projectile-enable-caching t)

    (projectile-global-mode 1)

    (defun helm-projectile-ag ()
      (interactive)
      (helm-ag (projectile-project-root)))))

(provide 'init-jdh-project)
