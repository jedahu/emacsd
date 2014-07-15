(require 'cl)
(require 'package)
(package-initialize)

(require 'el-get)
(require 'el-get-elpa)

(add-to-list 'load-path "~/.emacs.d/conf/")

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(setq el-get-user-package-directory "~/.emacs.d/el-get-init/")

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
    diminish
    evil
    evil-indent-textobject
    evil-leader
    evil-matchit
    evil-surround
    flycheck
    god-mode
    omnisharp
    powerline
    powerline-evil
    powershell
    powershell-mode
    smex
    zenburn-theme))

(el-get 'sync jdh:packages)

(require 'jdh-commands)
(require 'jdh-look-and-feel)
(require 'jdh-text)
(require 'jdh-behaviour)
(require 'jdh-c-mode-common)
(require 'jdh-c-sharp-mode)
(require 'jdh-evil)
(require 'jdh-powerline)
(require 'jdh-ahg)

(require 'powershell)

(server-start)
