(req-package org
  :defer t
  :require (evil evil-scout evil-rebellion)
  :init
  (progn
    (setq-default
     org-agenda-files (jdh-emacsd-file "AGENDA")
     org-insert-mode-line-in-empty-file t
     org-return-follows-link nil
     org-cycle-separator-lines 1)
    (evil-ex-define-cmd "todos" 'org-todo-list))
  :config
  (progn
    (defun jdh-org-case-open (n)
      (browse-url (concat "http://cases/?" n)))

    (defun jdh-org-insert-todo ()
      (interactive)
      (end-of-line)
      (org-insert-todo-heading t)
      (evil-insert-state 1))

    (evil-define-operator jdh-org-do-to-lines (beg end f)
      (let ((beg (set-marker (make-marker) beg))
            (end (set-marker (make-marker) end)))
        (save-excursion
          (goto-char beg)
          (evil-move-beginning-of-line nil)
          (while (< (point) end)
            (funcall f)
            (forward-line 1)))))

    (evil-define-operator jdh-org-demote (beg end)
      :type line
      (interactive "<r>")
      (jdh-org-do-to-lines beg end #'org-demote))

    (evil-define-operator jdh-org-promote (beg end)
      :type line
      (interactive "<r>")
      (jdh-org-do-to-lines beg end #'org-promote))

    (org-add-link-type "case" 'jdh-org-case-open)

    (evil-define-key 'normal org-mode-map
      ">" 'jdh-org-demote
      "<" 'jdh-org-promote)

    (define-leader-key 'local-leader org-mode-map nil
      (jdh-make-keymap
       '(("cr" org-evaluate-time-range)
         ("ci" org-clock-in)
         ("co" org-clock-out)
         ("cd" org-clock-display)
         ("it" jdh-org-insert-todo)
         ("tt" org-todo))))))

(req-package org-agenda
  :defer t
  :require (evil evil-scout org)
  :config
  (progn
    (evil-define-key 'normal org-agenda-mode-map
      ":" 'evil-ex
      "'" 'org-agenda-set-tags)))

(provide 'init-jdh-org)
