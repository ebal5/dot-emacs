;;; Code:
(use-package highlight-symbol
  :pin melpa-stable
  :diminish highlight-symbol-mode
  :chords(("hl" . highlight-symbol))
  :bind
  (("C-h C-l" . highlight-symbol))
  :config
  (custom-set-variables
   '(highlight-symbol-idle-delay 1.0))
  (add-hook 'prog-mode-hook 'highlight-symbol-mode)
  (add-hook 'prog-mode-hook 'highlight-symbol-nav-mode)
  )
;;; 20_highlight-symbol.el ends here
