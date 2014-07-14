(require 'cl)
(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(defvar jdh:packages
  '(evil
    evil-leader
    powerline
    powerline-evil
    smex))

(defun jdh:install-packages ()
  (interactive)
  (dolist (p jdh:packages)
    (when (not (package-installed-p p))
      (package-install p))))

(package-initialize)

(setq inhibit-splash-screen t)
(line-number-mode t)
(column-number-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(unless (string-match "apple-darwin" system-configuration)
  (menu-bar-mode -1))
(global-hl-line-mode)


(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)

(global-auto-revert-mode t)

(require 'dired-x)

(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)


(require 'evil)
(require 'evil-leader)
(require 'smex)

(global-evil-leader-mode)
(evil-leader/set-key "x" 'smex)
(evil-leader/set-key "z" 'smex-major-mode-commands)
(define-key evil-insert-state-map "\C-n" 'completion-at-point)
(define-key evil-ex-map "e " 'ido-find-file)
(define-key evil-ex-map "b " 'ido-switch-buffer)
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'abort-recursive-edit)
(define-key minibuffer-local-ns-map [escape] 'abort-recursive-edit)
(define-key minibuffer-local-completion-map [escape] 'abort-recursive-edit)
(define-key minibuffer-local-must-match-map [escape] 'abort-recursive-edit)
(define-key minibuffer-local-isearch-map [escape] 'abort-recursive-edit)
(evil-mode t)


(require 'powerline)
(require 'powerline-evil)
(powerline-evil-center-color-theme)


(electric-indent-mode t)

(server-start)
