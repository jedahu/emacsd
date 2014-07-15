(require 'dired-x)
(require 'ido)

(global-auto-revert-mode t)

(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)

(provide 'jdh-behaviour)
