;(req-package shm
;  :defer t
;  :require (evil evil-scout)
;  :commands (structured-haskell-mode
;             shm/newline-indent shm/goto-parent shm/goto-parent-end
;             shm/add-operand shm/raise shm/delete-indentation shm/kill shm/yank
;             shm/kill-line)
;  :config
;  (progn
;    (require 'shm-customizations)
;    ;(setq-default shm-program-name (getenv "EMACS_SHM_PATH"))
;    (setq-default shm-indent-spaces 4)
;    (evil-define-key 'normal shm-map
;      "(" 'shm/goto-parent
;      ")" 'shm/goto-parent-end)
;    (evil-define-key 'visual shm-map
;      "(" 'shm/goto-parent
;      ")" 'shm/goto-parent-end)
;    (evil-define-key 'insert shm-map
;      "<RET>" 'shm/newline-indent
;      (kbd "<return>") 'shm/newline-indent
;      [remap return] 'shm/newline-indent
;      [remap newline] 'shm/newline-indent)
;    (defvar evil-local-leader-shm-mode-map
;      (jdh-make-keymap
;       '(("o" shm/newline-indent)
;         ("+" shm/add-operand)
;         ("k" shm/raise)
;         ("<" shm/delete-indentation)
;         ("d" shm/kill)
;         ("D" shm/kill-line)
;         ("p" shm/yank))))
;    (define-leader-key 'local-leader shm-map
;      nil evil-local-leader-shm-mode-map)))


(req-package ghc
  :defer t
  :commands (ghc-init ghc-debug ghc-goto-next-error ghc-goto-prev-error
             ghc-show-info ghc-show-type))

(req-package haskell-mode
  :defer t
  :commands (haskell-mode)
  :config
  (progn
    (setq-default haskell-indentation-layout-offset 4
                  haskell-indentation-starter-offset 2
                  haskell-indentation-left-offset 4
                  haskell-indentation-ifte-offset 4
                  haskell-indentation-where-pre-offset 2
                  haskell-indentation-where-post-offset 2)

    (defun jdh-haskell-mode-setup ()
      (turn-on-haskell-indentation)
      (ghc-init))

    (define-key haskell-mode-map
      [remap next-error] 'ghc-goto-next-error)
    (define-key haskell-mode-map
      [remap previous-error] 'ghc-goto-prev-error)
    (define-key haskell-mode-map
      [remap jdh-show-symbol-info-at-point] 'ghc-show-info)
    (define-key haskell-mode-map
      [remap jdh-show-symbol-type-at-point] 'ghc-show-type)

    (add-hook 'haskell-mode-hook 'jdh-haskell-mode-setup)))

(provide 'init-jdh-haskell)
