(req-package gist
  :defer t
  :require (evil)
  :config
  (progn
    (evil-set-initial-state 'gist-list-mode 'normal)
    (evil-ex-define-cmd "gist[s]" 'gist-list)
    (evil-define-key 'normal gist-list-menu-mode-map (kbd "<RET>") 'gist-fetch-current)
    (evil-define-key 'normal gist-list-menu-mode-map "g" 'gist-list-reload)
    (evil-define-key 'normal gist-list-menu-mode-map "e" 'gist-edit-current-description)
    (evil-define-key 'normal gist-list-menu-mode-map "d" 'gist-kill-current)
    (evil-define-key 'normal gist-list-menu-mode-map "+" 'gist-add-buffer)
    (evil-define-key 'normal gist-list-menu-mode-map "-" 'gist-remove-file)

    (evil-set-initial-state 'gist-mode 'normal)
    (evil-ex-define-cmd "gist-s[ave]" 'gist-mode-save-buffer)))

(provide 'init-jdh-gist)
