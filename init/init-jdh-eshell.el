(require 'eshell)

(defun ecr (cmd)
  (let* ((code 0)
         (result (eshell-command-result cmd code)))
    (if (/= code 0)
        (throw nil nil)
      result)))

(defun jdh-hg-bugzid ()
  (interactive)
  (let ((branch (shell-command-to-string "hg branch")))
    (if (string-match "^[0-9]+" branch)
        (match-string 0 branch)
      (throw 'no-branch-id-found nil))))

(defun eshell/hgcommit (&rest msg)
  (eshell-command
   (concat "hg commit -m \"bugzid:"
           (jdh-hg-bugzid)
           " "
           (eshell-flatten-and-stringify msg)
           "\"")))
