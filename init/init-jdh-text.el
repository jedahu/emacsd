(req-package whitespace
  :diminish global-whitespace-mode
  :requires (evil)
  :demand t
  :init
  (progn
    (setq-default sentence-end-double-space nil)

    (setq-default ispell-dictionary "en_GB")

    (setq-default fill-column 80)

    (setq-default indent-tabs-mode nil)
    (setq-default tab-width 4)
    (defvaralias 'c-basic-offset 'tab-width)
    (defvaralias 'js-indent-level 'tab-width)
    (defvaralias 'evil-shift-width 'tab-width)

    (setq-default whitespace-style '(face trailing))
    (global-whitespace-mode 1)

    (show-paren-mode 1)
    (setq-default blink-matching-paren t)

    (defun jdh-set-indents (width)
      (set (make-local-variable 'tab-width) width)
      (set (make-local-variable 'c-basic-offset) width)
      (set (make-local-variable 'js-indent-level) width)
      (set (make-local-variable 'evil-shift-width) width))

    (evil-define-command jdh-set-indent (width)
      (interactive "<a>")
      (jdh-set-indents (string-to-number width)))

    (evil-ex-define-cmd "seti[ndent]" 'jdh-set-indent)

    (defadvice show-paren-function (after show-matching-paren-offscreen activate)
      (interactive)
      (let* ((cb (char-before (point)))
             (text (and cb
                        (char-equal (char-syntax cb) ?\))
                        (blink-matching-open))))
        (when text (message text))))))

(req-package markdown-mode)

(provide 'init-jdh-text)
