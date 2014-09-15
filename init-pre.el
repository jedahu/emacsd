(defvar jdh-emacsd (file-name-as-directory (expand-file-name "~/.emacs.d")))

(when (string-equal "TMWS107" (system-name))
  (setenv "HOME" "C:/Users/jhughes")
  (setq-default jdh-emacsd
                (file-name-as-directory
                 (expand-file-name
                  (concat
                   (file-name-as-directory (getenv "APPDATA"))
                   ".emacs.d")))))

(defun jdh-add-subdirs-to-load-path (dir)
  (let* ((default-directory dir)
         (load-path* load-path))
    (setq load-path (cons dir nil))
    (normal-top-level-add-subdirs-to-load-path)
    (nconc load-path load-path*)))

(defun jdh-emacsd-file (path)
  (concat jdh-emacsd path))

(defun jdh-emacsd-dir (path)
  (file-name-as-directory (jdh-emacsd-file path)))

(defun jdh-system-sym ()
  (intern system-name))

(defun jdh-package-init (pkg-archives)
  (setq-default package-archives pkg-archives)
  (package-initialize)
  (when (not package-archive-contents)
    (package-refresh-contents))
  (when (not (package-installed-p 'req-package))
    (package-install 'req-package)))

(defun jdh-start-server ()
  (let ((name (getenv "EMACS_SERVER")))
    (when name
      (setq-default server-name name)))
  (server-start))

(defun jdh-find-init-file ()
  (interactive)
  (find-file user-init-file))

(provide 'init-pre)
