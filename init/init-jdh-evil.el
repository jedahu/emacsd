(req-package evil
  :demand t
  :init
  (progn
    (setq evil-ex-complete-emacs-commands nil)
    (setq evil-motion-state-modes
          (append evil-emacs-state-modes evil-motion-state-modes))
    (setq evil-emacs-state-modes nil)

    (evil-define-command evil-delete-buffer-keep-window (buffer &optional bang)
                         (interactive "<b><!>")
                         (with-current-buffer (or buffer (current-buffer))
                                              (when bang
                                                (set-buffer-modified-p nil)
                                                (dolist (process (process-list))
                                                  (when (eq (process-buffer process) (current-buffer))
                                                    (set-process-query-on-exit-flag process nil))))
                                              (if (and (fboundp 'server-edit)
                                                       (boundp 'server-buffer-clients)
                                                       server-buffer-clients)
                                                (server-edit)
                                                (kill-buffer nil))))

    (evil-define-command current-error ()
      (interactive)
      (next-error 0))

    ;; Files
    ;; (define-key evil-ex-completion-map (kbd "SPC") #'evil-ex-completion)

    ;; Buffers
    (evil-ex-define-cmd "bw" 'evil-delete-buffer-keep-window)
    (evil-ex-define-cmd "bu[ry]" 'bury-buffer)

    ;; Building
    (evil-ex-define-cmd "mak[e]" 'compile)
    (evil-ex-define-cmd "remak[e]" 'recompile)

    ;; Projects
    ;(evil-ex-define-cmd "sw[itch-project]" 'projectile-switch-project)
    ;(evil-ex-define-cmd "p[roject-file]" 'helm-projectile)
    ;(evil-ex-define-cmd "P[roject-file]" 'jdh-helm-projectile-no-cache)
    ;(define-key evil-ex-map "sw " 'projectile-switch-project)
    ;(define-key evil-ex-map "p " 'helm-projectile)
    ;(define-key evil-ex-map "P " 'jdh-helm-projectile-no-cache)

    ;; Ag
    ;(evil-ex-define-cmd "agp[roject]" 'helm-projectile-ag)
    ;(define-key evil-ex-map "agp " 'helm-projectile-ag)

    ;; Help

    (define-key evil-insert-state-map [remap newline] 'evil-ret-and-indent)
    (define-key evil-insert-state-map "\C-n" 'completion-at-point)
    (define-key evil-normal-state-map [escape] 'keyboard-quit)
    (define-key evil-visual-state-map [escape] 'keyboard-quit)
    (define-key minibuffer-local-map [escape] 'abort-recursive-edit)
    (define-key minibuffer-local-ns-map [escape] 'abort-recursive-edit)
    (define-key minibuffer-local-completion-map [escape] 'abort-recursive-edit)
    (define-key minibuffer-local-must-match-map [escape] 'abort-recursive-edit)
    (define-key minibuffer-local-isearch-map [escape] 'abort-recursive-edit)

    (define-key evil-motion-state-map "\C-w" nil)
    (dolist (keys (list
                    (kbd "C-w")
                    (kbd "C-a")
                    (kbd "C-k")
                    [up]
                    [down]
                    [right]
                    [left]))
      (define-key global-map keys nil)
      (define-key evil-insert-state-map keys nil)
      (define-key evil-normal-state-map keys nil)
      (define-key evil-visual-state-map keys nil))

    (evil-mode 1)

    (defun jdh-diminish-undo-tree-mode ()
      (diminish 'undo-tree-mode))

    (add-hook 'undo-tree-mode-hook 'jdh-diminish-undo-tree-mode)))

(req-package evil-leader
  :demand t
  :require (evil)
  :config
  (progn
    (evil-leader/set-leader ",")
    (global-evil-leader-mode 1)
    (setq-default evil-leader/in-all-states t)
    (evil-leader/set-key "." 'evil-execute-in-emacs-state)
    (evil-leader/set-key "ww" 'evil-window-next)
    (evil-leader/set-key "wW" 'evil-window-prev)
    (evil-leader/set-key "wp" 'evil-window-mru)
    (evil-leader/set-key "wo" 'delete-other-windows)
    (evil-leader/set-key "cn" 'next-error)
    (evil-leader/set-key "cp" 'previous-error)
    (evil-leader/set-key "cc" 'current-error)
    (evil-leader/set-key "cr" 'first-error)
    (evil-leader/set-key "dn" 'diff-hunk-next)
    (evil-leader/set-key "dp" 'diff-hunk-prev)
    (evil-leader/set-key "dN" 'diff-file-next)
    (evil-leader/set-key "dP" 'diff-file-prev)
    (evil-leader/set-key "da" 'diff-apply-hunk)
    (evil-leader/set-key "dA"
      (lambda ()
        (interactive)
        (flet ((diff-hunk-next ()))
            (diff-apply-hunk))
        (diff-hunk-kill)))
    (evil-leader/set-key "dr"
      (lambda ()
        (interactive)
        (diff-apply-hunk t)))
    (evil-leader/set-key "dR"
      (lambda ()
        (interactive)
        (flet ((diff-hunk-next ()))
          (diff-apply-hunk t))
        (diff-hunk-kill)))
    (evil-leader/set-key "dk" 'diff-hunk-kill)
    (evil-leader/set-key "dK" 'diff-file-kill)
    (evil-leader/set-key "dh" 'diff-refine-hunk)
    (evil-leader/set-key "ds" 'diff-goto-source)))

(req-package evil-god-state
  :defer t
  :require (evil evil-leader)
  :diminish god-local-mode
  :commands (evil-execute-in-god-state evil-god-state-bail)
  :init
  (progn
    (evil-leader/set-key "," 'evil-execute-in-god-state)
    (evil-define-key 'god global-map [escape] 'evil-god-state-bail)))

(provide 'init-jdh-evil)
