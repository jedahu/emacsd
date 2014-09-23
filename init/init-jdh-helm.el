(req-package helm
  :defer t
  :require (evil evil-scout)
  :init
  (progn
    (define-global-leader "x" 'helm-M-x)
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
    (req-package-force helm-ls-hg :demand t)
    (define-key helm-map "\\f" 'helm-scroll-other-window)
    (define-key helm-map "\\b" 'helm-scroll-other-window-down)
    (define-key helm-map "\\mm" 'helm-toggle-visible-mark)
    (define-key helm-map "\\ma" 'helm-mark-all)
    (define-key helm-map "\\mA" 'helm-unmark-all)
    (define-key helm-map "\\mn" 'helm-next-visible-mark)
    (define-key helm-map "\\mN" 'helm-prev-visible-mark)
    (define-key helm-map "\\." 'helm-execute-persistent-action)))

(req-package helm-ag
  :defer t
  :require (helm))

(provide 'init-jdh-matching)
