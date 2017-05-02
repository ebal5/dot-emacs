;;; Code:
(custom-set-variables
 '(dired-recursive-copies 'always)
 '(dired-recursive-deletes 'top)
 '(dired-dwim-target t)
 )
(put 'dired-find-alternate-file 'disabled nil)
(bind-keys
 (:map dired-mode-map
       ("r" . wdired-change-to-wdired-mode)
       ))
(use-package dired-hacks-utils)
;;; 11_dired.el ends here
