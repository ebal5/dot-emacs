;;; Code:
(use-package scala-mode
  :if (executable-find "activator")
  :mode (("\\.scala\\'" . scala-mode))
  :pin melpa-stable
  :interpreter
  ("scala" . scala-mode)
  )
(use-package sbt-mode
  :commands sbt-start sbt-command
  :pin melpa-stable
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
  (add-hook 'sbt-mode-hook
	    (lambda ()
	      (add-hook 'before-save-hook 'sbt-hydra:check-modified-buffers))))
(use-package ensime
  :if (executable-find "activator")
  :pin melpa
  :config
  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
  (add-hook 'java-mode-hook 'ensime-mode))
;;; 21_scala.el ends here
