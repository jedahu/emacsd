(require 'markdown-mode)
(require 'whitespace)
(require 'diminish)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(electric-indent-mode t)

(setq-default ispell-dictionary "en_GB")

(setq-default fill-column 80)

(setq-default whitespace-style '(face trailing lines-tail))
(global-whitespace-mode 1)

(diminish 'global-whitespace-mode)

(show-paren-mode 1)
(setq-default blink-matching-paren t)

(defadvice show-paren-function (after show-matching-paren-offscreen activate)
  (interactive)
  (let* ((cb (char-before (point)))
         (text (and cb
                    (char-equal (char-syntax cb) ?\))
                    (blink-matching-open))))
    (when text (message text))))
