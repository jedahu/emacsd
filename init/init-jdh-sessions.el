(require 'desktop)
(require 'ido)

;;; Ss enables named sessions.
;; Ss is largely based on my-desktop.el by Scott Frazer
;; Modification by Jannis Teunissen
;; Version 0.01b - 8 April 2014

;;; *** Usage ***
;; Note: if 'name' is not given, you'll be asked for a name
;;
;; (ss-load prefix &optional name) -> without prefix: load session
;; (ss-load prefix &optional name) -> with prefix: save session
;; (ss-remove &optional name)      -> remove session
;; (ss-reset)                      -> clear session without saving
;; (ss-prev)                       -> load previous session
;; (ss-name)               -> get current session name

;;; *** Example configuration in .emacs ***
;; (require 'desktop)
;; (require 'ss)
;; (require 'ido) or (setq ss-ido-mode nil)
;; (global-set-key (kbd "<f9>")     'ss-load)
;; (global-set-key (kbd "C-<f9>")   'ss-prev)
;; (global-set-key (kbd "C-S-<f9>") 'ss-save)

(defvar ss-dir
  (concat (getenv "HOME") "/.emacs.d/ss-sessions/")
  "*Directory to save desktop sessions in")

(defvar ss-prev-session nil
  "The previous desktop session")

(defvar ss-ido-mode t
  "Whether to use ido-mode")

(defun ss-save (&optional name)
  "Save desktop by name."
  (interactive)
   (unless name (setq name (read-string "Save session as: ")))
   (when (ss-name)
     (desktop-release-lock))
   (make-directory (concat ss-dir name) t)
   (desktop-lazy-complete)               ; Load all buffers before saving
   (desktop-save (concat ss-dir name) nil))

(defun ss-prev ()
  "Switch to previous session"
  (interactive)
  (when ss-prev-session
    (ss-load nil ss-prev-session)))

(defun ss-remove (&optional name)
  "Remove desktop by name."
  (interactive)
  (unless name
    (setq name (ss-select "Remove session: ")))
  (unless (ss-detect-problems name)
    (when (yes-or-no-p (concat "Really remove session '" name "' ?"))
      (progn
	(delete-directory (concat ss-dir name) t)
	(when (string= ss-prev-session name)
	  (setq ss-prev-session nil))
	(when (string= (ss-name) name) ; Current session is removed
	  (setq desktop-dirname nil))))))           ; so reset session name

(defun ss-reset ()
  "Reset session without saving."
  (interactive)
  (save-some-buffers)
  (desktop-release-lock)
  (desktop-clear)
  (setq desktop-dirname nil))

(defun ss-detect-problems (name)
  "Check whether a session is unlocked and stored correctly"
  (catch 'err
    (let ((dirname (file-name-as-directory (concat ss-dir name))))
      (when (not (file-directory-p dirname))
	(throw 'err (concat dirname " does not exist")))
      (when (file-exists-p (concat dirname desktop-base-lock-name))
	(if (y-or-n-p (concat name " is locked, remove lock?"))
	    (desktop-release-lock dirname)
	  (throw 'err (concat name " is locked"))))
      (let ((dirfiles (delete "." (delete ".." (directory-files dirname)))))
	(when (not (equal dirfiles (list desktop-base-file-name)))
	  (throw 'err (concat dirname " contains extra files")))))))

(defun ss-load (prefix &optional name)
  "Load session by name. With universal argument, create new session."
  (interactive "P")
  (let ((prev-name (ss-name)))
    (if (equal prefix '(4))
	(progn
	  (unless name (setq name (read-string "Create new session: ")))
          (when prev-name (ss-save prev-name))
	  (ss-reset)
	  (ss-save name))
      (progn
	(unless name (setq name (ss-select "Load session: ")))
        (when prev-name (ss-save prev-name))
	(ss-reset)
	(desktop-read (concat ss-dir name))))
    (unless (and ss-prev-session (string= ss-prev-session prev-name))
      (setq ss-prev-session prev-name))))

(defun ss-new ()
  (interactive)
  (ss-load '(4)))

(defun ss-name ()
  "Get the current desktop name."
  (interactive)
  (when desktop-dirname
    (let ((dirname (substring desktop-dirname 0 -1))) ; Remove trailing /
      (when (string=
             (file-name-directory dirname)
             (file-name-directory ss-dir))
	(message (file-name-nondirectory dirname))))))

(defun ss-list-all ()
  "Get all stored session names"
  (when (file-exists-p ss-dir)
    (delete "." (delete ".." (directory-files ss-dir)))))

(defun ss-select (message)
  "Select an existing session by name"
  (if ss-ido-mode
      (ido-completing-read message (ss-list-all) nil t nil nil ss-prev-session)
    (completing-read message (ss-list-all) nil t nil nil ss-prev-session)))

(defun ss-kill-emacs-hook ()
  "Save desktop before killing emacs."
  (when (ss-name)
    (ss-save (ss-name))))

(add-hook 'kill-emacs-hook 'ss-kill-emacs-hook)
