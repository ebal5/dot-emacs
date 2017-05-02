;;; Code:
(use-package quickrun
  :if (notany (equal system-type 'windows-nt) (equal system-type 'ms-dos))
  :commands (quickrun-with-arg
	     quickrun-option-args
	     quickrun-input-file-extension
	     quickrun-shell)
  :bind (("C-c q" . quickrun))
  )
;;; 29_quickrun.el ends here
