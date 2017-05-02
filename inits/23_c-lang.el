;;; Code:
(use-package c-eldoc
  :config
  (custom-set-variables
   '(eldoc-idle-delay 0.4))
  (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
  (add-hook 'c++-mode-hook 'c-turn-on-eldoc-mode)
  (setq c-eldoc-buffer-regenerate-time 60))
(use-package irony
  :if (and (executable-find "clang")
	   (executable-find "cmake")
	   (>= my/emacs-version-number 24.4))
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  (when (package-installed-p "company")
    (add-to-list 'company-backends 'company-irony))
  (use-package flycheck-irony
    :config
    (eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  )
;;; 23_c-lang.el ends here
