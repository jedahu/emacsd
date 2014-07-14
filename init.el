(require 'cl)
(require 'package)

(package-initialize)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(defvar jdh:packages
  '(evil
    evil-indent-textobject
    evil-leader
    evil-matchit
    evil-surround
    flycheck
    omnisharp
    powerline
    powerline-evil
    smex
    zenburn-theme))

(when (cl-find-if (lambda (p) (not (package-installed-p p))) jdh:packages)
  (package-refresh-contents)
  (dolist (p jdh:packages)
    (when (not (package-installed-p p))
      (package-install p))))

(defun jdh:install-packages ()
  (interactive)
  (dolist (p jdh:packages)
    (when (not (package-installed-p p))
      (package-install p))))

(defun jdh:find-init-file ()
  (interactive)
  (find-file user-init-file))

(package-initialize)

(load-theme 'zenburn t)

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

(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(setq c-basic-offset tab-width)

(defun jdh:c-mode-common-init ()
  (setq tab-width 4)
  (setq c-basic-offset tab-width)
  (c-set-offset 'arglist-intro '++)
  (c-set-offset 'substatement-open 0))

(add-hook 'c-mode-common-hook 'jdh:c-mode-common-init)
(add-hook 'csharp-mode-hook 'omnisharp-mode)
(setq omnisharp-server-executable-path
      "E:\mystuff\proj\OmniSharpServer\OmniSharp\bin\Debug\OmniSharp.exe")


(setq mouse-wheel-progressive-speed t)
(setq mouse-wheel-follow-mouse t)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

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
(setq powerline-evil-tag-style 'visual-expanded)
(powerline-default-theme)


(electric-indent-mode t)

(server-start)
