;;; Code:
(use-package yasnippet-snippets)
(use-package yasnippet
  :diminish yas-minor-mode
  :bind (:map yas-minor-mode-map
	      ("C-x i i" . yas-insert-snippet)
	      ("C-x i n" . yas-new-snippet)
	      ("C-x i v" . yas-visit-snippet-file)
	      ("C-x i g" . yas-reload-all))
  :config
  (yas-reload-all)
  (yas-global-mode 1)
  ;; Add yasnippet support for all company backends
  ;; https://github.com/syl20bnr/spacemacs/pull/179
  (defvar company-mode/enable-yas t
    "Enable yasnippet for all backends.")
  (defun company-mode/backend-with-yas (backend)
    (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
	backend
      (append (if (consp backend) backend (list backend))
	      '(:with company-yasnippet))))
  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
  )
(use-package hippie-exp
  :config
  (add-to-list 'hippie-expand-try-functions-list 'yas-hippie-try-expand)
  )
;;; 29_yasnippet.el ends here
