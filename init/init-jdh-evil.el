(require 'evil)
(require 'evil-leader)
(require 'smex)
(require 'god-mode)
(require 'diminish)

(setq evil-motion-state-modes
      (append evil-emacs-state-modes evil-motion-state-modes))
(setq evil-emacs-state-modes nil)

(setq evil-ex-complete-emacs-commands nil)

(global-evil-leader-mode 1)
(setq evil-leader/in-all-states t)
(evil-leader/set-leader ",")
(evil-leader/set-key "x" 'helm-M-x)

(define-key evil-insert-state-map "\C-n" 'completion-at-point)
(define-key evil-ex-map "e " 'helm-find-files)
(define-key evil-ex-map "b " 'helm-buffers-list)
;(define-key evil-ex-map "w " 'helm-write-buffer)
(define-key evil-ex-map "ha " 'helm-apropos)
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'abort-recursive-edit)
(define-key minibuffer-local-ns-map [escape] 'abort-recursive-edit)
(define-key minibuffer-local-completion-map [escape] 'abort-recursive-edit)
(define-key minibuffer-local-must-match-map [escape] 'abort-recursive-edit)
(define-key minibuffer-local-isearch-map [escape] 'abort-recursive-edit)

(evil-define-state god
  "God state."
  :tag " <G> "
  :message "-- GOD MODE --"
  :entry-hook (evil-god-start-hook)
  :exit-hook (evil-god-stop-hook)
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

(evil-ex-define-cmd "bw" 'evil-delete-buffer-keep-window)
(evil-ex-define-cmd "bu[ry]" 'bury-buffer)

(evil-mode 1)

(diminish 'undo-tree-mode)