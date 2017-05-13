;;; Code:
(use-package quickrun
  :if (notany (equal system-type 'windows-nt) (equal system-type 'ms-dos))
  :commands (quickrun
	     quickrun-with-arg
	     quickrun-option-args
	     quickrun-input-file-extension
	     quickrun-shell)
  :bind (("C-c q" . quickrun))
  )
;;; 20_quickrun.el ends here
