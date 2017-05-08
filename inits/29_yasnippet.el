;;; Code:
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
  )
(use-package hippie-exp
  :config
  (add-to-list 'hippie-expand-try-functions-list 'yas-hippie-try-expand)
  )
;;; 29_yasnippet.el ends here
