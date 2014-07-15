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

(setq el-get-sources
      '((:name goto-chg
               :description "Goto the point of the most recent edit."
               :type elpa
               :features goto-chg)
        (:name evil
               :description "Vim!"
               :type elpa
               :features evil)))

(defvar jdh:packages
  '(ahg
    evil
    evil-indent-textobject
    evil-leader
    evil-matchit
    evil-surround
    flycheck
    magit
    omnisharp
    powerline
    powerline-evil
    powershell
    powershell-mode
    smex
    zenburn-theme
    jdh-evil
    jdh-sessions))

(el-get 'sync jdh:packages)

(require 'jdh-commands)
(require 'jdh-look-and-feel)
(require 'jdh-text)
(require 'jdh-behaviour)
(require 'jdh-c-mode-common)
(require 'jdh-c-sharp-mode)
(require 'jdh-powerline)
(require 'jdh-ahg)

(require 'powershell)
(require 'magit)

(server-start)
