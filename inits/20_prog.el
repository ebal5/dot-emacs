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
;;; 20_prog.el ends here
