(req-package find-file
  :defer t
  :require (evil evil-scout)
  :commands (ff-get-other-file jdh-assume-new-is-modified)
  :init
  (progn
    (add-hook 'find-file-hooks 'jdh-assume-new-is-modified)
    (define-global-leader "go" 'ff-get-other-file))
  :config
  (progn
    (defun jdh-assume-new-is-modified ()
      (when (not (file-exists-p (buffer-file-name)))
        (set-buffer-modified-p t)))
    (defvar jdh-dotnet-other-file-alist nil)
    (setq jdh-dotnet-other-file-alist
          '(("\\.aspx\\'" (".aspx.cs" ".aspx.vb"))
            ("\\.ascx\\'" (".ascx.cs" ".ascx.vb"))
            ("\\.aspx\\.\\(?:cs\\|vb\\)\\'" (".aspx"))
            ("\\.ascx\\.\\(?:cs\\|vb\\)\\'" (".ascx"))))
    (defvar jdh-other-file-alist nil)
    (setq jdh-other-file-alist
          (append jdh-dotnet-other-file-alist cc-other-file-alist))
    (setq-default
     ff-case-fold-search nil
     ff-always-in-other-window nil
     ff-ignore-include t
     ff-always-try-to-create nil
     ff-quiet-mode t
     ff-other-file-alist 'jdh-other-file-alist)))

(provide 'init-jdh-nav)
