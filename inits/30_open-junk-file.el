;;; Code:
(use-package open-junk-file
  :init
  (setq open-junk-file-directory "~/Documents/junk/%Y/%m/%Y-%m-%d-%H%M%S.")
  :bind (("C-c j" . open-junk-file))
  )
;;; 30_open-junk-file.el ends here
