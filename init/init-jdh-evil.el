(req-package evil
  :require (evil-leader god-mode projectile helm)
  :diminish god-mode
  :init
  (progn
    (global-evil-leader-mode 1)
    (setq-default evil-leader/in-all-states t)
    (setq evil-ex-complete-emacs-commands nil)
    (setq evil-motion-state-modes
          (append evil-emacs-state-modes evil-motion-state-modes))
    (setq evil-emacs-state-modes nil)

    (evil-define-command jdh-helm-projectile-no-cache ()
                         (helm-projectile t))

    (evil-define-state god
                       "God state."
                       :tag " <G> "
                       :message "-- GOD MODE --"
                       :enable (god-local-mode)
                       :input-method t
                       :intercept-esc nil)

    (defvar evil-execute-in-god-state-buffer nil)

    (defun evil-stop-execute-in-god-state ()
      (when (and (not (eq this-command #'evil-execute-in-god-state))
                 (not (minibufferp)))
        (remove-hook 'post-command-hook 'evil-stop-execute-in-god-state)
        (when (buffer-live-p evil-execute-in-god-state-buffer)
          (with-current-buffer evil-execute-in-god-state-buffer
                               (if (and (eq evil-previous-state 'visual)
                                        (not (use-region-p)))
                                 (progn
                                   (evil-change-to-previous-state)
                                   (evil-exit-visual-state))
                                 (evil-change-to-previous-state))))
        (setq evil-execute-in-god-state-buffer nil)))

    (evil-define-command evil-execute-in-god-state ()
                         "Execute the next command in God state."
                         (add-hook 'post-command-hook #'evil-stop-execute-in-god-state t)
                         (setq evil-execute-in-god-state-buffer (current-buffer))
                         (cond
                           ((evil-visual-state-p)
                            (let ((mrk (mark))
                                  (pnt (point)))
                              (evil-god-state)
                              (set-mar mrk)
                              (goto-char pnt)))
                           (t
                             (evil-god-state)))
                         (evil-echo "Switched to God state for the next command ..."))

    (evil-leader/set-key "," 'evil-execute-in-god-state)
    (evil-leader/set-key "." 'evil-execute-in-emacs-state)
    (define-key evil-god-state-map [escape] 'keyboard-quit)

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

    (evil-leader/set-leader ",")

    (evil-leader/set-key "x" 'helm-M-x)
    (evil-leader/set-key "ww" 'evil-window-next)
    (evil-leader/set-key "wW" 'evil-window-prev)
    (evil-leader/set-key "wp" 'evil-window-mru)
    (evil-leader/set-key "wo" 'delete-other-windows)
    (evil-leader/set-key "cn" 'next-error)
    (evil-leader/set-key "cp" 'previous-error)
    (evil-leader/set-key "cc" 'current-error)
    (evil-leader/set-key "cr" 'first-error)

    ;; Files
    (define-key evil-ex-map "e " 'helm-find-files)
    ;; (define-key evil-ex-completion-map (kbd "SPC") #'evil-ex-completion)

    ;; Buffers
    (evil-ex-define-cmd "bw" 'evil-delete-buffer-keep-window)
    (evil-ex-define-cmd "bu[ry]" 'bury-buffer)
    (define-key evil-ex-map "b " 'helm-buffers-list)

    ;; Building
    (evil-ex-define-cmd "mak[e]" 'compile)
    (evil-ex-define-cmd "remak[e]" 'recompile)

    ;; Projects
    (evil-ex-define-cmd "sw[itch-project]" 'projectile-switch-project)
    (evil-ex-define-cmd "p[roject-file]" 'helm-projectile)
    (evil-ex-define-cmd "P[roject-file]" 'jdh-helm-projectile-no-cache)
    (define-key evil-ex-map "sw " 'projectile-switch-project)
    (define-key evil-ex-map "p " 'helm-projectile)
    (define-key evil-ex-map "P " 'jdh-helm-projectile-no-cache)

    ;; Ag
    (evil-ex-define-cmd "ag" 'helm-ag)
    (evil-ex-define-cmd "agi[nteractive]" 'helm-do-ag)
    (evil-ex-define-cmd "agp[roject]" 'helm-projectile-ag)
    (define-key evil-ex-map "ag " 'helm-ag)
    (define-key evil-ex-map "agi " 'helm-do-ag)
    (define-key evil-ex-map "agp " 'helm-projectile-ag)

    ;; Help
    (evil-ex-define-cmd "ap[ropos]" 'helm-apropos)
    (define-key evil-ex-map "ap " 'helm-apropos)

    (define-key evil-insert-state-map [remap newline] 'evil-ret-and-indent)
    (define-key evil-insert-state-map "\C-n" 'completion-at-point)
    ;(define-key evil-ex-map "w " 'helm-write-buffer)
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
      (define-key evil-visual-state-map keys nil)
      (define-key evil-god-state-map keys nil))

    (evil-mode 1)

    (defun jdh-diminish-undo-tree-mode ()
      (diminish 'undo-tree-mode))

    (add-hook 'undo-tree-mode-hook 'jdh-diminish-undo-tree-mode)))

(provide 'init-jdh-evil)
