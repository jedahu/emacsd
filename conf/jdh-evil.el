(require 'evil)
(require 'evil-leader)
(require 'smex)
(require 'god-mode)
(require 'diminish)

(global-evil-leader-mode)
(evil-leader/set-key "x" 'smex)
(evil-leader/set-key "z" 'smex-major-mode-commands)
(define-key evil-insert-state-map "\C-n" 'completion-at-point)
(define-key evil-ex-map "e " 'ido-find-file)
(define-key evil-ex-map "b " 'ido-switch-buffer)
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
  :input-method t
  :intercept-esc nil)

(defun evil-god-start-hook ()
  (diminish 'god-local-mode)
  (god-local-mode 1))

(defun evil-god-stop-hook ()
  (god-local-mode -1)
  (diminish-undo 'god-local-mode))

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
    (setq evil-execute-in-got-state-buffer nil)))

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

(evil-define-key 'normal global-map "," 'evil-execute-in-god-state)

(evil-mode t)

(diminish 'undo-tree-mode)

(provide 'jdh-evil)
