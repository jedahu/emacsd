(req-package helm
  :defer t
  :require (evil evil-leader)
  :init
  (progn
    (evil-leader/set-key "x" 'helm-M-x)
    (define-key evil-ex-map "b " 'helm-buffers-list)
    (evil-ex-define-cmd "ag" 'helm-ag)
    (evil-ex-define-cmd "agi[nteractive]" 'helm-do-ag)
    (define-key evil-ex-map "ag " 'helm-ag)
    (define-key evil-ex-map "agi " 'helm-do-ag)
    (evil-ex-define-cmd "ap[ropos]" 'helm-apropos)
    (define-key evil-ex-map "ap " 'helm-apropos)
    (define-key evil-ex-map "e " 'helm-browse-project)
    (define-key evil-ex-map "ef " 'helm-find-files))
  :config
  (progn
    (setq-default completion-at-point-functions nil)
    (req-package-force helm-ls-git :demand t)
    (req-package-force helm-ls-hg :demand t)))


(provide 'init-jdh-matching)
