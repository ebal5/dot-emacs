;;; Code:
(defvar my/tex-env 'yatex "My choise of TeX environment.")

(defun my/yatex-setting ()

  )
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
  (setq tex-command "xelatex -synctex=1")
  (if (executable-find "evince")
      (setq dvi2-command "evince"))
  (setq YaTeX-kanji-code nil)
  (setq YaTeX-latex-message-code 'utf-8)
  (add-hook 'yatex-mode-hook 'turn-on-reftex)
  )
;;; 30_yatex.el ends here
