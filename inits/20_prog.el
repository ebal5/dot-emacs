;;; Code:
(add-hook 'prog-mode-hook 'electric-pair-mode)
(use-package js-doc
  :config
  (if (package-installed-p 'hydra)
      (defhydra my-hydra/jsdoc (global-map "C-!")
	"For js-doc"
	("t" js-doc-insert-file-doc)
	("f" js-doc-insert-function-doc)
	("s" js-doc-insert-function-doc-snippet)
	("t" js-doc-insert-tag)
	))
  )
(defun my-c-c++-mode-init ()
  (progn
  (setq c-basic-offset 4)
  (setq tab-width 4))
  )
(add-hook 'c-mode-hook 'my-c-c++-mode-init)
(add-hook 'c++-mode-hook 'my-c-c++-mode-init)
;;; 20_prog.el ends here
