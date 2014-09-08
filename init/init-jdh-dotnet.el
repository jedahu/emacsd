(req-package fsharp-mode
  :defer t
  :config
  (progn
    (defun jdh-fsharp-mode-init ()
      (electric-indent-local-mode -1))

    (add-hook 'fsharp-mode-hook 'jdh-fsharp-mode-init)))

(req-package vbnet-mode
  :defer t
  :commands vbnet-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.vb\\$" . vbnet-mode)))

(req-package csharp-mode
  :defer t
  :require (omnisharp cc-mode)
  :config
  (progn
    (defun jdh-csharp-mode-init ()
      (flymake-mode -1))

    (add-hook 'csharp-mode-hook 'jdh-csharp-mode-init t)
    ;;(add-hook 'csharp-mode-hook 'omnisharp-mode)

    (setq omnisharp-server-executable-path
          (case (jdh-system-sym)
            ('TMWS107
             "E:\\mystuff\\proj\\OmniSharpServer\\OmniSharp\\bin\\Debug\\OmniSharp.exe")))

    (evil-define-key 'insert omnisharp-mode-map
      (kbd "M-.") 'omnisharp-auto-complete)

    (evil-define-key 'normal omnisharp-mode-map
      (kbd "<f12>") 'omnisharp-go-to-definition)

    (evil-define-key 'normal omnisharp-mode-map
      (kbd "g u") 'omnisharp-find-usages)

    (evil-define-key 'normal omnisharp-mode-map
      (kbd "g o") 'omnisharp-go-to-definition)

    (evil-define-key 'normal omnisharp-mode-map
      (kbd "g r") 'omnisharp-run-code-action-refactoring)

    (evil-define-key 'normal omnisharp-mode-map
      (kbd "g f") 'omnisharp-fix-code-issue-at-point)

    (evil-define-key 'normal omnisharp-mode-map
      (kbd "g R") 'omnisharp-rename)

    (evil-define-key 'normal omnisharp-mode-map
      (kbd ", i") 'omnisharp-current-type-information)

    (evil-define-key 'insert omnisharp-mode-map
      (kbd ".") 'omnisharp-add-dot-and-auto-complete)

    (evil-define-key 'normal omnisharp-mode-map
      (kbd ", n t") 'omnisharp-navigate-to-current-file-member)

    (evil-define-key 'normal omnisharp-mode-map
      (kbd ", n s") 'omnisharp-navigate-to-solution-member)

    (evil-define-key 'normal omnisharp-mode-map
      (kbd ", n f") 'omnisharp-navigate-to-solution-file-then-file-member)

    (evil-define-key 'normal omnisharp-mode-map
      (kbd ", n F") 'omnisharp-navigate-to-solution-file)

    (evil-define-key 'normal omnisharp-mode-map
      (kbd ", n r") 'omnisharp-navigate-to-region)

    (evil-define-key 'normal omnisharp-mode-map
      (kbd "<f12>") 'omnisharp-show-last-auto-complete-result)

    (evil-define-key 'insert omnisharp-mode-map
      (kbd "<f12>") 'omnisharp-show-last-auto-complete-result)

    (evil-define-key 'normal omnisharp-mode-map
      (kbd ",.") 'omnisharp-show-overloads-at-point)

    (setq omnisharp-auto-complete-want-documentation t)

    (defun omnisharp--fix-build-command-if-on-windows (command)
      command)


    (defun csharp-insert-open-brace ()
      (interactive)
      (let
          (tpoint
           (in-string (string= (csharp-in-literal) "string"))
           (preceding3
            (save-excursion
              (and
               (skip-chars-backward " \t")
               (> (- (point) 2) (point-min))
               (buffer-substring-no-properties (point) (- (point) 3)))))
           (one-word-back
            (save-excursion
              (backward-word 2)
              (thing-at-point 'word))))

        (cond

         ;; Case 1: inside a string literal?
         ;; --------------------------------------------
         ;; If so, then just insert a pair of braces and put the point
         ;; between them.  The most common case is a format string for
         ;; String.Format() or Console.WriteLine().
         (in-string
          (self-insert-command 1)
          (insert "}")
          (backward-char))

         ;; Case 2: the open brace starts an array initializer.
         ;; --------------------------------------------
         ;; When the last non-space was an equals sign or square brackets,
         ;; then it's an initializer.
         ((save-excursion
            (and (c-safe (backward-sexp) t)
                 (looking-at "\\(\\w+\\b *=\\|[[]]+\\)")))
          (self-insert-command 1)
          (insert "  };")
          (backward-char 3))

         ;; Case 3: the open brace starts an instance initializer
         ;; --------------------------------------------
         ;; If one-word-back was "new", then it's an object initializer.
         ((string= one-word-back "new")
          (csharp-log 2 "object initializer")
          (setq tpoint (point)) ;; prepare to indent-region later
          (backward-word 2)
          (c-backward-syntactic-ws)
          (if (or (eq (char-before) ?,)       ;; comma
                  (and (eq (char-before) 123) ;; open curly
                       (progn (backward-char)
                              (c-backward-syntactic-ws)
                              (looking-back "\\[\\]"))))
              (progn
                ;; within an array - emit no newlines
                (goto-char tpoint)
                (self-insert-command 1)
                (insert "  },")
                (backward-char 3))

            (progn
              (goto-char tpoint)
              (newline)
              (self-insert-command 1)
              (newline-and-indent)
              (newline)
              (insert "};")
              (c-indent-region tpoint (point))
              (forward-line -1)
              (indent-according-to-mode)
              (end-of-line))))


         ;; Case 4: a lambda initialier.
         ;; --------------------------------------------
         ;; If the open curly follows =>, then it's a lambda initializer.
         ((or (string= (substring preceding3 -2) "=>")
              (string= preceding3 "get")
              (string= preceding3 "set"))
          (csharp-log 2 "lambda init")
          (self-insert-command 1)
          (insert "  }")
          (backward-char 2))

         ;; else, it's a new scope. (if, while, class, etc)
         (t
          (save-excursion
            (csharp-log 2 "new scope")
            (set-mark (point)) ;; prepare to indent-region later
            ;; check if the prior sexp is on the same line
            (if (save-excursion
                  (let ((curline (line-number-at-pos))
                        (aftline (progn
                                   (if (c-safe (backward-sexp) t)
                                       (line-number-at-pos)
                                     -1))))
                    (= curline aftline)))
                (newline-and-indent))
            (self-insert-command 1)
            (c-indent-line-or-region)
            (end-of-line)
            (newline)
            (insert "}")
            ;;(c-indent-command) ;; not sure of the difference here
            (c-indent-line-or-region)
            (forward-line -1)
            (end-of-line)
            (newline-and-indent)
            ;; point ends up on an empty line, within the braces, properly indented
            (setq tpoint (point)))

          (goto-char tpoint)))))))

(provide 'init-jdh-dotnet)
