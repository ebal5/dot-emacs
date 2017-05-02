;;; Code:
(use-package bm
  :demand t
  :config
  (setq-default bm-buffer-persistence t)
  (setq bm-cycle-all-buffers t)
  (setq bm-repository-file (locate-user-emacs-file "bm-repository"))
  (add-hook' after-init-hook 'bm-repository-load)
  (add-hook 'find-file-hooks 'bm-buffer-restore)
  (add-hook 'kill-buffer-hook #'bm-buffer-save)
  (add-hook 'kill-emacs-hook #'(lambda nil
				 (bm-buffer-save-all)
				 (bm-repository-save)))
  (add-hook 'after-save-hook #'bm-buffer-save)
  (add-hook 'after-revert-hook #'bm-buffer-restore)
  (if (package-installed-p 'hydra)
      (defhydra my-hydra/bm (global-map "C-.")
	"For bm.el use."
	("t" bm-toggle)
	("n" bm-next)
	("p" bm-previous)
	)
    )
  :init
  (setq bm-restore-repository-on-load t)
  )
;;; 04_bm.el ends here
