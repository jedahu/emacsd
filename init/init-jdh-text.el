(req-package whitespace
  :diminish global-whitespace-mode
  :init
  (progn
    (setq-default indent-tabs-mode nil)
    (setq-default tab-width 4)
    (setq-default sentence-end-double-space nil)

    (setq-default ispell-dictionary "en_GB")

    (setq-default fill-column 80)

    (setq-default whitespace-style '(face trailing lines-tail))
    (global-whitespace-mode 1)

    (show-paren-mode 1)
    (setq-default blink-matching-paren t)

    (defadvice show-paren-function (after show-matching-paren-offscreen activate)
      (interactive)
      (let* ((cb (char-before (point)))
             (text (and cb
                        (char-equal (char-syntax cb) ?\))
                        (blink-matching-open))))
        (when text (message text))))))

(req-package markdown-mode)

(provide 'init-jdh-text)
