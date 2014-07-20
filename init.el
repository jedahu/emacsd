;; jedahu@gmail.com
(require 'cl)
(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)

(unless (package-installed-p 'el-get)
  (make-directory "~/.emacs.d/el-get")
  (package-refresh-contents)
  (package-install 'el-get))


(require 'el-get)
(require 'el-get-elpa)

(add-to-list 'load-path "~/.emacs.d/conf/")

(setq el-get-user-package-directory "~/.emacs.d/init/")
(add-to-list 'el-get-recipe-path "~/.emacs.d/recipes")

(defvar jdh-package-overrides
  '((:name goto-chg
           :description "Goto the point of the most recent edit."
           :type elpa
           :features goto-chg)
    (:name evil
           :description "Vim!"
           :type elpa
           :features evil)
    (:name magit
           :description "Git!"
           :type elpa
           :features magit)
    (:name vbnet-mode
           :descriptoin "VB.NET"
           :type http
           :url "http://www.emacswiki.org/emacs/download/vbnet-mode.el"
           :features vbnet-mode)))

(defvar jdh-packages
  '((:name jdh-core)
    (:name jdh-evil
           :depends (evil evil-leader evil-indent-textobject evil-matchit
                          evil-surround god-mode diminish))
    (:name jdh-sessions
           :depends (desktop))
    (:name jdh-matching
           :depends (helm))
    (:name jdh-status-line
           :depends (powerline powerline-evil powershell powershell-mode))
    (:name jdh-dotnet
           :depends (omnisharp vbnet-mode jdh-core))
    (:name jdh-c-common)
    (:name jdh-commands)
    (:name jdh-look-feel
	   :depends (solarized-theme zenburn-theme))
    (:name jdh-text
           :depends (markdown-mode))
    (:name jdh-behaviour)
    (:name jdh-git
	   :depends (ahg))
    (:name jdh-misc
	   :depends (ahg flycheck helm-ag magit))))

(setq el-get-sources
      (append
       jdh-package-overrides
       (mapcar (lambda (p) (append p '(:type no-op))) jdh-packages)))


(defun jdh-package-symbols ()
  (mapcar (lambda (p) (plist-get p :name)) jdh-packages))

(el-get 'sync (jdh-package-symbols))

(server-start)
