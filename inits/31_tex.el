;;; Code:
(defvar my/tex-env 'yatex "My choise of TeX environment.")

(defun my/yatex-setting ()
  "Setting for yatex."
  (use-package yatex
    :mode (("\\.tex\\'" . yatex-mode)
	   ("\\.ltx\\'" . yatex-mode)
	   ("\\.cls\\'" . yatex-mode)
	   ("\\.sty\\'" . yatex-mode)
	   ("\\.clo\\'" . yatex-mode)
	   ("\\.bbl\\'" . yatex-mode))
    :bind (("C-c C-t" . YaTeX-typeset-menu))
    :init
    (setq YaTeX-inhibit-prefix-letter t)
    (setq YaTeX-nervous t)
    (setq YaTeX-use-LaTeX2e t)
    (setq YaTeX-use-AMS-LaTeX t)
    (when (executable-find "xelatex")
      (setq tex-command "xelatex -synctex=1")
      )
    (when (package-installed-p 'yasnippet)
      (add-hook 'yatex-mode-hook 'yas-minor-mode)
      )
    (when (executable-find "evince")
      (setq dvi2-command "evince"))
    (setq YaTeX-kanji-code nil)
    (add-hook 'yatex-mode-hook 'turn-on-reftex)
    )
  )

(defun my/auctex-setting ()
  "Setting for AUCTeX."
  (use-package auctex
    :pin gnu
    :mode (("\\.tex\\'" . auctex-mode))
    :config
    (setq-default TeX-master nil)
    (when (package-installed-p 'yasnippet)
      (add-hook 'auctex-mode 'yas-minor-mode))
    )
  )

(cond
 ((equal my/tex-env 'yatex) (my/yatex-setting) "YaTeX")
 ((equal my/tex-env 'auctex) (my/auctex-setting) "AucTeX")
 (t (my/yatex-setting) "YaTeX")
 )
;;; 30_tex.el ends here
