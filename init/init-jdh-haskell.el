(req-package haskell-mode
  :defer t
  :require (evil haskell-indent)
  :config
  (progn
    (setq-default haskell-indentation-layout-offset 4
                  haskell-indentation-starter-offset 2
                  haskell-indentation-left-offset 4
                  haskell-indentation-ifte-offset 4
                  haskell-indentation-where-pre-offset 2
                  haskell-indentation-where-post-offset 2)

    (defun jdh-haskell-mode-setup ()
      (turn-on-haskell-indentation))

    (add-hook 'haskell-mode-hook 'jdh-haskell-mode-setup)))

(provide 'init-jdh-haskell)
