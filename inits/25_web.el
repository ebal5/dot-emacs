;;; Code:
(use-package web-mode
  :mode (("\\html\\'" . web-mode)
	 ("\\.phtml\\'" . web-mode)
	 ("\\.[agj]sp\\'" . web-mode)
	 ("\\.tpl\\.php\\'" . web-mode)
	 ("\\.as[cp]x\\'" . web-mode)
	 ("\\.erb\\'" . web-mode)
	 ("\\.mustache\\'" . web-mode)
	 ("\\.djhtml\\'" . web-mode))
  :config
  (progn
    (setq web-mode-code-indent-offset 2)
    (setq web-mode-markup-indent-offset 2))
  )
(use-package emmet-mode
  :init
  (progn
    (add-hook 'web-mode-hook 'emmet-mode)
    (add-hook 'html-mode-hook 'emmet-mode)
    (add-hook 'css-mode-hook 'emmet-mode)))
(use-package rainbow-mode
  :init
  (progn
    (add-hook 'web-mode-hook 'rainbow-mode)
    (add-hook 'html-mode-hook 'rainbow-mode)
    (add-hook 'css-mode-hook 'rainbow-mode)))
(use-package js2-mode
  :mode (("\\.js\\'" . js2-mode)
	 ("\\.json\\'" . js2-mode))
  )
(use-package string-edit
  :bind (:map js2-mode-map
	      ("C-c '" . string-edit-at-point)))
(use-package skewer-mode
  :init
  (progn
    (add-hook 'html-mode-hook 'skewer-mode)
    (add-hook 'css-mode-hook 'skewer-mode)
    (add-hook 'js2-mode-hook 'skewer-mode))
  )
;;; 25_web.el ends here
