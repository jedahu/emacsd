(require 'omnisharp)
(require 'vbnet-mode)
(require 'flymake)

(defun jdh-csharp-mode-init ()
  (flymake-mode -1))

(add-hook 'csharp-mode-hook 'jdh-csharp-mode-init t)
(add-hook 'csharp-mode-hook 'omnisharp-mode)

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
