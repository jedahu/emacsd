(req-package c-mode
  :defer t
  :config
  (progn
    (defun jdh:c-mode-common-init ()
      (setq tab-width 4)
      (setq c-basic-offset tab-width)
      (c-set-offset 'arglist-intro '++)
      (c-set-offset 'substatement-open 0))

    (add-hook 'c-mode-common-hook 'jdh:c-mode-common-init)))

(provide 'init-jdh-c-common)
