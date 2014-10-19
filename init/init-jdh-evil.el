(req-package evil
  :demand t
  :init
  (progn
    (setq evil-ex-complete-emacs-commands nil)
    (setq evil-motion-state-modes
          (append evil-emacs-state-modes evil-motion-state-modes))
    (setq evil-emacs-state-modes nil)

    (setq-default evil-overriding-maps nil
                  evil-intercept-maps nil)

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

    ;; Files
    ;; (define-key evil-ex-completion-map (kbd "SPC") #'evil-ex-completion)

    ;; Buffers
    (evil-ex-define-cmd "bw" 'evil-delete-buffer-keep-window)
    (evil-ex-define-cmd "bu[ry]" 'bury-buffer)

    ;; Building
    (evil-ex-define-cmd "mak[e]" 'compile)
    (evil-ex-define-cmd "remak[e]" 'recompile)

    ;; Help

    (define-key evil-insert-state-map [remap newline] 'evil-ret-and-indent)
    (define-key evil-insert-state-map (kbd "<tab>") 'completion-at-point)
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
                    (kbd "\\")
                    [up]
                    [down]
                    [right]
                    [left]))
      (define-key global-map keys nil)
      (define-key evil-motion-state-map keys nil)
      (define-key evil-insert-state-map keys nil)
      (define-key evil-normal-state-map keys nil)
      (define-key evil-visual-state-map keys nil))

    (evil-mode 1)

    (defun jdh-diminish-undo-tree-mode ()
      (diminish 'undo-tree-mode))

    (add-hook 'undo-tree-mode-hook 'jdh-diminish-undo-tree-mode)))

(req-package evil-scout
  :demand t
  :require (evil)
  :config
  (progn
    (setq-default evil-scout-keys-alist
		  `((leader "<SPC>" ,evil-normal-state-map ,evil-visual-state-map)
		    (local-leader "\\" normal visual insert)))
    (evil-define-key 'insert global-map "\\\\" 'self-insert-command)
    (define-key minibuffer-local-map "\\" 'self-insert-command)
    (define-key evil-ex-completion-map "\\" 'self-insert-command)

    (evil-define-command current-error ()
      (interactive)
      (next-error 0))

    (evil-define-key 'emacs global-map [escape] 'keyboard-quit)

    (defun jdh-show-symbol-info-at-point ()
      (interactive))

    (defun jdh-show-symbol-type-at-point ()
      (interactive))

    (let
        ((other-frame-reverse
          (lambda ()
            (interactive)
            (other-frame -1))))
      (dolist
          (kv
           `(("." evil-execute-in-emacs-state)
             ("f" evil-scroll-page-down)
             ("b" evil-scroll-page-up)
             ("F" scroll-other-window)
             ("B" scroll-other-window-down)
             ("ww" evil-window-next)
             ("wW" evil-window-prev)
             ("wp" evil-window-mru)
             ("wo" delete-other-windows)
             ("WW" other-frame)
             ("Ww" ,other-frame-reverse)
             ("Wo" delete-other-frames)
             ("cn" next-error)
             ("cp" previous-error)
             ("cc" current-error)
             ("cr" first-error)
             ("si" jdh-show-symbol-info-at-point)
             ("st" jdh-show-symbol-type-at-point)))
        (define-global-leader (first kv) (second kv))))))

(req-package evil-god-state
  :defer t
  :require (evil evil-scout)
  :diminish god-local-mode
  :commands (evil-execute-in-god-state evil-god-state-bail)
  :init
  (progn
    (define-global-leader "," 'evil-execute-in-god-state)
    (evil-define-key 'god global-map [escape] 'evil-god-state-bail)))

(provide 'init-jdh-evil)
