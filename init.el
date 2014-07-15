(require 'cl)
(require 'package)

(add-to-list 'load-path "~/.emacs.d/conf/")

(package-initialize)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

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

(when (cl-find-if (lambda (p) (not (package-installed-p p))) jdh:packages)
  (package-refresh-contents)
  (dolist (p jdh:packages)
    (when (not (package-installed-p p))
      (package-install p))))

(package-initialize)

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
