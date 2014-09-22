;; jedahu@gmail.com
(require 'cl)
(require 'package)

(load-file (concat (file-name-directory load-file-name) "init-pre.el"))

(jdh-package-init
 '(("gnu" . "http://elpa.gnu.org/packages/")
   ("marmalade" . "http://marmalade-repo.org/packages/")
   ("melpa" . "http://melpa.milkbox.net/packages/")))

(jdh-add-subdirs-to-load-path (jdh-emacsd-dir "pkgs"))
(add-to-list 'load-path (jdh-emacsd-dir "init"))
(load-file (concat (file-name-directory load-file-name) "pkgs/extra-paths.el"))

(require 'req-package)

(req-package-force load-dir :init (load-dir-one (jdh-emacsd-dir "init")))
(require 'init-jdh-project)

(req-package-finish)

(jdh-start-server)
