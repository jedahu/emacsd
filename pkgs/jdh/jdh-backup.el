(defvar jdh-backup-per-save-dir "~/.emacs.d/.backup/per-save/")
(defvar jdh-backup-per-session-dir "~/.emacs.d/.backup/per-session/")

(defun jdh-backup-buffer-force ()
  ;; per-session backup on first save of session
  (when (not buffer-backed-up)
    (let ((backup-directory-alist `(("" . ,jdh-backup-per-session-dir)))
          (kept-new-versions 3))
      (backup-buffer)))
  ;; per-save backup
  (let ((backup-directory-alist `(("" . ,jdh-backup-per-save-dir)))
        (buffer-backed-up nil))
    (backup-buffer)))

(defun jdh-backup-save-all ()
  (interactive)
  (save-some-buffers t))

(provide 'jdh-backup)
