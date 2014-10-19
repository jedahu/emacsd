(req-package ahg
  :commands (hg-review hg-revstat hg-diff hg-stat ahg-status)
  :require (evil)
  :init
  (progn
    (evil-ex-define-cmd "hgstat" 'hg-stat)
    (evil-ex-define-cmd "hgdiff" 'hg-diff)
    (evil-ex-define-cmd "hgrevstat" 'hg-revstat)
    (evil-ex-define-cmd "hgreview" 'hg-review))
  :config
  (progn
    (setq ahg-auto-refresh-status-buffer t)

    (defun jdh-insert-fogbugz-id-prefix ()
      (interactive)
      (if (ahg-root)
          (let ((branch (shell-command-to-string "hg branch")))
            (if (string-match "^[0-9]\+" branch)
                (insert "bugzid:" (match-string 0 branch) " ")
              (message "Branch %s has no ID." branch)))
        (message "Not in hg project.")))

    (defun jdh-log-edit-mode-hook ()
      (evil-ex-define-cmd "fbid" 'jdh-insert-fogbugz-id-prefix))

    (add-hook 'log-edit-mode-hook 'jdh-log-edit-mode-hook)

    (defun hg-stat ()
      (interactive)
      (shell-command "hg diff --stat" "*hg stat*"))

    (defun hg-diff ()
      (interactive)
      (shell-command "hg diff" "*hg diff*")
      (with-current-buffer "*hg diff*"
        (diff-mode)))

    (defun hg-revstat ()
      (interactive)
      (shell-command "hg diff --stat -r \"max(ancestor(default, '.'))\""
                     "*hg revstat*"))

    (defun hg-review ()
      (interactive)
      (shell-command "hg diff -r \"max(ancestor(default, '.'))\""
                     "*hg review*")
      (with-current-buffer "*hg review*"
        (diff-mode)))))

(provide 'init-jdh-hg)
