;;; Code:
(use-package undo-tree
  :diminish undo-tree-mode
  :bind
  (("M-/" . undo-tree-redo))
  :config
  (global-undo-tree-mode 1))
;;; 12_undo.el ends here
