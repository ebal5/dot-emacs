;;; Code:
(use-package plantuml-mode
  :if (file-exists-p my/plantuml-jar-path)
  :mode (("\\.puml\\'" . plantuml-mode)
	 ("\\.plantuml\\'" . plantuml-mode))
  :init
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  (setq org-plantuml-jar-path my/plantuml-jar-path)
  (defun my/org-mode-init ()
    (org-babel-do-load-languages
     'org-babel-load-languages
     (add-to-list 'org-babel-load-languages '(plantuml . t))
     ))
  (add-hook 'org-mode-hook 'my/org-mode-init)
  :config
  (custom-set-variables
   '(plantuml-jar-path my/plantuml-jar-path))  
  )
;;; 29_plantuml.el ends here
