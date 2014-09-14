;; jedahu@gmail.com
(defvar jdh-emacsd (file-name-as-directory (expand-file-name "~/.emacs.d")))

(when (string-equal "TMWS107" (system-name))
  (setenv "HOME" "C:/Users/jhughes")
  (setq-default jdh-emacsd
                (file-name-as-directory
                 (expand-file-name
                  (concat
                   (file-name-as-directory (getenv "APPDATA"))
                   ".emacs.d")))))

(require 'cl)
(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(when (not (package-installed-p 'req-package))
  (package-install 'req-package))

(require 'req-package)

(add-to-list 'load-path (concat jdh-emacsd "init"))
(add-to-list 'load-path (concat jdh-emacsd "pkgs/vbnet-mode"))

;;(setq el-get-user-package-directory "~/.emacs.d/init/")
;;(add-to-list 'el-get-recipe-path "~/.emacs.d/recipes")
;; (setq-default el-get-is-lazy t)

;;(defvar jdh-package-overrides
;;  '((:name goto-chg
;;           :description "Goto the point of the most recent edit."
;;           :type elpa
;;           :features goto-chg)
;;    (:name evil
;;           :description "Vim!"
;;           :type elpa
;;           :features evil)
;;    (:name magit
;;           :description "Git!"
;;           :type elpa
;;           :features magit)
;;    (:name vbnet-mode
;;           :descriptoin "VB.NET"
;;           :type http
;;           :url "http://www.emacswiki.org/emacs/download/vbnet-mode.el"
;;           :features vbnet-mode)
;;    (:name htmlize
;;           :description "HTMLize"
;;           :type elpa)
;;    (:name pos-tip
;;           :description "pos-tip"
;;           :type elpa)
;;    (:name evil-scout
;;           :description "Alternative <leader>"
;;           :type github
;;           :pkgname "tarleb/evil-scout"
;;           :features evil-scout)
;;    (:name evil-rebellion
;;           :description "Evil Rebellion!"
;;           :depends (evil-scout)
;;           :type github
;;           :pkgname "tarleb/evil-rebellion"
;;           :features evil-rebellion)))

(defun jdh-system-sym ()
  (intern system-name))

(require 'init-jdh-evil)
(require 'init-jdh-sessions)
(require 'init-jdh-matching)
(require 'init-jdh-dotnet)
(require 'init-jdh-c-common)
(require 'init-jdh-commands)
(require 'init-jdh-look-feel)
(require 'init-jdh-text)
(require 'init-jdh-behaviour)
(require 'init-jdh-hg)
(require 'init-jdh-git)
(require 'init-jdh-project)
(require 'init-jdh-eshell)
(require 'init-jdh-haskell)
(req-package magit)
(req-package powershell)
(req-package powershell-mode)
(req-package evil-rebellion)

(req-package-finish)

;;(defvar jdh-packages
;;  '((:name jdh-core)
;;    (:name jdh-evil
;;           :depends (evil evil-leader evil-indent-textobject evil-matchit
;;                          evil-surround evil-rebellion god-mode diminish
;;                          jdh-project))
;;    (:name jdh-sessions)
;;    (:name jdh-matching
;;           :depends (helm))
;;    (:name jdh-dotnet
;;           :depends (omnisharp vbnet-mode fsharp-mode jdh-core))
;;    (:name jdh-c-common)
;;    (:name jdh-commands)
;;    (:name jdh-look-feel
;;           :depends (solarized-theme zenburn-theme))
;;    (:name jdh-text
;;           :depends (markdown-mode diminish))
;;    (:name jdh-behaviour)
;;    (:name jdh-git
;;           :depends (ahg))
;;    (:name jdh-project
;;           :depends (projectile helm-ag))
;;    (:name jdh-blog
;;           :depends (o-blog))
;;    (:name jdh-eshell)
;;    (:name jdh-misc
;;           :depends (ahg flycheck magit powershell powershell-mode))))

;;(setq el-get-sources
;;      (append
;;       jdh-package-overrides
;;       (mapcar (lambda (p) (append p '(:type no-op))) jdh-packages)))
;;
;;
;;(defun jdh-package-symbols ()
;;  (mapcar (lambda (p) (plist-get p :name)) jdh-packages))

;;(el-get 'sync (jdh-package-symbols))

(let ((name (getenv "EMACS_SERVER")))
  (when name
    (setq-default server-name name)))

;;(set-file-modes (expand-file-name "~/.emacs.d/server") #o700)

(server-start)
