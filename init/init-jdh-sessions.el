(require 'desktop)
(require 'nameses)
(require 'ido)

(defun ss-load ()
  (interactive)
  (nameses-load '(4)))

(defun ss-save ()
  (interactive)
  (nameses-save))

(defun ss-delete ()
  (interactive)
  (nameses-remove))

(defun ss-clear ()
  (interactive)
  (nameses-reset))

(defun ss-name ()
  (interactive)
  (nameses-current-name))

(defun ss-list ()
  (interactive)
  (nameses-list-all))

(defun ss-choose ()
  (interactive)
  (nameses-select))
