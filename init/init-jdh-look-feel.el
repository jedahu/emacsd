(req-package zenburn-theme
  :config
  (progn
    (load-theme 'zenburn t)

    (setq inhibit-splash-screen t)
    (line-number-mode t)
    (column-number-mode t)
    (tool-bar-mode -1)
    (scroll-bar-mode -1)
    (unless (string-match "apple-darwin" system-configuration)
      (menu-bar-mode -1))
    (global-hl-line-mode)

    (windmove-default-keybindings 'meta)
    (setq windmove-wrap-around t)

    (setq mouse-wheel-progressive-speed t)
    (setq mouse-wheel-follow-mouse t)
    (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

    (setq visible-bell t)))

(provide 'init-jdh-look-feel)
