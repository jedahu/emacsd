(req-package omnisharp
  :defer t
  :commands (omnisharp-start-omnisharp-server)
  :config
  (progn
    (defun omnisharp-start-omnisharp-server (path-to-solution)
      "Starts an OmniSharpServer for a given path to a solution file"
      (interactive "fStart OmniSharpServer.exe for solution: ")
      (setq BufferName "*Omni-Server*")
      (omnisharp--find-and-cache-omnisharp-server-executable-path)
      (if (equal nil omnisharp-server-executable-path)
          (error "Could not find the OmniSharpServer. Please set the variable omnisharp-server-executable-path to a valid path")

              (message (format "Starting OmniSharpServer for solution file: %s" path-to-solution))
              (when (not (eq nil (get-buffer BufferName)))
                (kill-buffer BufferName))
              (start-process-shell-command
               "Omni-Server"
               (get-buffer-create BufferName)
               (omnisharp--get-omnisharp-server-executable-command path-to-solution))))

    (defun omnisharp--fix-build-command-if-on-windows (command)
      command)

    (setq-default omnisharp-auto-complete-want-documentation t)

    (setq-default omnisharp-server-executable-path
          (case (jdh-system-sym)
            ('TMWS107
             "E:\\mystuff\\proj\\OmniSharpServer\\OmniSharp\\bin\\Debug\\OmniSharp.exe")
            (t (getenv "OMNISHARP_EXE_PATH"))))

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
      (kbd ",.") 'omnisharp-show-overloads-at-point)))

(provide 'init-jdh-omnisharp)
