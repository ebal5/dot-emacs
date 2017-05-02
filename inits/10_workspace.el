;;; Code:
(if (>= my/emacs-version-number 25.0)
    (use-package perspeen
      :pin melpa-stable
      :init
      (setq perspeen-use-tab t)
      :config
      (perspeen-mode 1)
      )
  (use-package persp-mode
    :pin melpa-stable
    :init
    (setq persp-keymap-prefix (kbg "C-z"))
    (setq persp-add-on-switch-or-display t)
    :config
    (persp-mode 1)
    )
  )
;;; 10_workspace.el ends here
