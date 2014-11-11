(req-package dired
  :defer t
  :require (evil wdired)
  :config
  (progn
    (defvar evil-local-leader-dired-mode-map
      (jdh-make-keymap '(("w" wdired-change-to-wdired-mode))))
    (define-leader-key 'local-leader dired-mode-map
      nil evil-local-leader-dired-mode-map)
    (defvar evil-local-leader-wdired-mode-map
      (jdh-make-keymap `((,(kbd "<ESC>") wdired-abort-changes)
                         ("w" wdired-finish-edit))))
    (define-leader-key 'local-leader wdired-mode-map
      nil evil-local-leader-wdired-mode-map)
    (define-key dired-mode-map [override-state] nil)
    (add-hook 'dired-mode-hook 'evil-normalize-keymaps)
    (define-key evil-ex-map "dired " 'dired)
    (evil-ex-define-cmd "dired" 'dired-jump)
    (evil-define-key 'normal dired-mode-map (kbd "<RET>") 'dired-find-file)
    (evil-define-key 'normal dired-mode-map "R" 'dired-do-rename)
    (evil-define-key 'normal dired-mode-map "D" 'dired-do-delete)
    (evil-define-key 'normal dired-mode-map "m" 'dired-mark)
    (evil-define-key 'normal dired-mode-map "F"
      #'(lambda ()
          (interactive)
          (dired-do-find-marked-files 2)))))

(provide 'init-jdh-dired)
