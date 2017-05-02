;;; Code:
(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  (add-hook 'html-mode-hook #'yas-minor-mode)
  (add-hook 'sgml-mode-hook #'yas-minor-mode)
  (add-hook 'css-mode-hook #'yas-minor-mode)
  (when (package-installed-p 'web-mode)
    (add-hook 'web-mode-hook #'yas-minor-mode))
  (when (equal my/completion-type 'company)
    (defun check-expansion ()
      (save-excursion
	(if (looking-at "\\_>") t
	  (backward-char 1)
	  (if (looking-at "\\.") t
	    (backward-char 1)
	    (if (looking-at "->") t nil)))))

    (defun do-yas-expand ()
      (let ((yas-fallback-behavior 'return-nil))
	(yas-expand)))

    (defun tab-indent-or-complete ()
      (interactive)
      (if (minibufferp)
	  (minibuffer-complete)
	(if (or (not yas-minor-mode)
		(null (do-yas-expand)))
	    (if (check-expansion)
		(company-complete-common)
	      (indent-for-tab-command)))))
    (bind-keys ("TAB" . tab-indent-or-complete)
	       :map yas-minor-mode-map
	       ("TAB" . tab-indent-or-complete))
    )
  )
;;; 29_yasnippet.el ends here
