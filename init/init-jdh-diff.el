(req-package diff-mode
  :defer t
  :require (evil-scout)
  :commands (diff-hunk-next diff-hunk-prev diff-file-next diff-file-prev
             diff-goto-source diff-apply-hunk diff-hunk-kill diff-file-kill
             diff-refine-hunk)
  :config
  (progn
    (evil-define-key 'normal diff-mode-map
      "]]" 'diff-hunk-next
      "[[" 'diff-hunk-prev
      "]}" 'diff-file-next
      "[{" 'diff-file-prev
      "gs" 'diff-goto-source)
    (defvar evil-local-leader-diff-mode-map
      (jdh-make-keymap '(("a" diff-apply-hunk)
                         ("A"
                          (lambda ()
                            (interactive)
                            (flet ((diff-hunk-next ()))
                              (diff-apply-hunk))
                            (diff-hunk-kill)))
                         ("r"
                           (lambda ()
                             (interactive)
                             (diff-apply-hunk t)))
                         ("R"
                           (lambda ()
                             (interactive)
                             (flet ((diff-hunk-next ()))
                               (diff-apply-hunk t))
                             (diff-hunk-kill)))
                         ("k" diff-hunk-kill)
                         ("K" diff-file-kill)
                         ("h" diff-refine-hunk))))
    (define-leader-key 'local-leader diff-mode-map
      nil evil-local-leader-diff-mode-map)))

(provide 'init-jdh-diff)
