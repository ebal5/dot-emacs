;;; Code:
(defvar my/plantuml-jar-path
  (expand-file-name "~/bin/plantuml.jar")
  "Specify plantUML's jar path."
  )
(use-package org
  :pin org
  :bind (:map org-mode-map
	      ("C-c a" . org-agenda)
	      ("TAB" . org-cycle)
	      ("<tab>" . org-cycle))
  :init
  (setq org-directory "~/Documents/junk")
  (setq org-agenda-files
	(-flatten
	 (mapcar
	  (lambda (dir)
	    (directory-files dir t "\\.org\\'"))
	  (-flatten
	   (mapcar
	    (lambda (dir)
	      (directory-files dir t "[0-9][0-9]"))
	    (directory-files org-directory t "[0-9][0-9][0-9][0-9]"))))))
  (setq org-use-speed-commands t)
  :config
  (with-eval-after-load 'ox-latex
    (add-to-list 'org-latex-classes
		 '("bxjsarticle"
		   "\\documentclass[a4paper,xelatex,ja=standard]{bxjsarticle}
\\usepackage{zxjatype}
\\usepackage{metalogo}
\\usepackage{graphicx}
\\usepackage{color}
\\usepackage{hyperref}
\\usepackage{pdfpages}
[NO-DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
	     '("beamer"
	       "\\documentclass[14pt, cjk, xetex,xcolor=pdftex,dvipsnames,table]{beamer}
\\usepackage[cm-default]{fontspec}
\\usepackage{xltxtra}
\\usepackage{multicol}
[NO-DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]
\\setmainfont{IPAPMincho}
\\setsansfont{IPAPGothic}
\\setmonofont{IPAGothic}
\\XeTeXlinebreaklocale \"ja\"

\\usetheme{Madrid}
\\usecolortheme{whale}
% \\usecolortheme{dolphin}

\\AtBeginSection[]{
\\begin{frame}
\\tableofcontents[currentsection]
\\end{frame}
}"
               ("\\section\{%s\}" . "\\section*\{%s\}")
               ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
               ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")
))
(setq org-latex-default-class "bxjsarticle"))
)

(use-package org-present
  :bind
  (:map org-present-mode-keymap
	("b" . org-present-big)
	("s" . org-present-small)
	("q" . org-present-quit))
  :config
  (defun my/org-present-hook ()
    "My setting for org-present."
    (org-present-big)
    (org-display-inline-images)
    (org-present-hide-cursor)
    (org-present-read-only)
    )
  (defun my/org-present-quit-hook ()
    "My setting for org-present escape."
    (org-present-small)
    (org-remove-inline-images)
    (org-present-show-cursor)
    (org-present-read-write))
  (add-hook 'org-present-mode-hook 'my/org-present-hook)
  (add-hook 'org-present-mode-quick-hook 'my/org-present-quit-hook)
  (setq org-present-text-scale 5)
  )

(use-package ox-qmd)
(use-package ox-gfm)
(use-package ox-pandoc
  :if (executable-find "pandoc")
  )
;;; 28_org.el ends here
