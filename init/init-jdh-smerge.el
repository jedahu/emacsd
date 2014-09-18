(req-package smerge-mode
  :defer t
  :require (evil evil-scout)
  :commands (smerge-mode smerge-start-session)
  :init
  (progn
    (evil-ex-define-cmd "smerge" 'smerge-start-session))
  :config
  (progn
    (add-hook 'smerge-mode-hook 'evil-normalize-keymaps)
    (evil-define-key 'normal smerge-mode-map
      "]c" 'smerge-next
      "[c" 'smerge-prev)
    (defvar evil-local-leader-smerge-mode-map
      (jdh-make-keymap '(("ka" smerge-keep-all)
                         ("km" smerge-keep-mine)
                         ("ko" smerge-keep-other)
                         ("kb" smerge-keep-base)
                         ("kc" smerge-keep-current)
                         ("Kc" smerge-kill-current)
                         ("cr" smerge-refine)
                         ("dbm" smerge-diff-base-mine)
                         ("dmo" smerge-diff-mine-other)
                         ("dbo" smerge-diff-base-other))))
    (define-leader-key 'local-leader smerge-mode-map
      nil evil-local-leader-smerge-mode-map)))

(provide 'init-jdh-smerge)
