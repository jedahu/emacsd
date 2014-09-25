(req-package jdh-init-files
  :defer t
  :require (evil)
  :commands (jdh-find-init)
  :init
  (progn
    (evil-ex-define-cmd "jinit" 'jdh-find-init)
    (define-key evil-ex-map "jinit " 'jdh-find-init)))

(provide 'init-jdh-jdh)
