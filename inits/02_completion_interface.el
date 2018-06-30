;;; Code:
(defvar my/interface-name
  'Ivy
  "Shows what interface I want to use.  Candidates are IDO, Helm, Ivy.  You must chose one of them."
  )

(defun my/helm-settings ()
  "Settings for Helm interface."
  (use-package helm
    :diminish helm-mode
    :chords ((" f" . helm-find-files)
	     (" r" . helm-recentf)
	     (" b" . helm-for-files))
    :bind (("M-x" . helm-M-x)
	   ("C-x C-f" . helm-find-files)
	   ("C-x C-r" . helm-recentf)
	   ("M-y" . helm-show-kill-ring)
	   ("C-c i" . helm-imenu)
	   ("C-x b" . helm-for-files)
	   ("C-h SPC" . helm-all-mark-rings)
	   :map helm-map
	   ("C-h" . delete-backward-char)
	   ("M-n" . helm-next-source)
	   ("M-p" . helm-previous-source)
	   :map helm-find-files-map
	   ("C-h" . delete-backward-char)
	   ("TAB" . helm-execute-persistent-action)
	   :map helm-read-file-map
	   ("TAB" . helm-execute-persistent-action))
    :config
    (progn
      (require 'helm-config)
      (helm-mode 1)
      (if (and (executable-find "cmigemo") 'migemo-command)
	  (helm-migemo-mode 1)(diminish 'helm-migemo-mode))
      ))
  (use-package helm-swoop
    :bind (("M-i" . helm-swoop)
	   ("M-I" . helm-swoop-back-to-last-point)
	   ("C-c M-i" . helm-multi-swoop)
	   ("C-c M-I" . helm-multi-swoop-all)
	   :map isearch-mode-map
	   ("M-i" . helm-swoop-from-isearch)
	   :map helm-swoop-map
	   ("M-i" . helm-multi-swoop-all-from-helm-swoop))
    )
  (use-package helm-gtags
    :bind (:map helm-gtags-mode-map
		("M-t" . helm-gtags-find-tag)
		("M-r" . helm-gtags-find-rtag)
		("M-s" . helm-gtags-find-symbol)
		("C-t" . helm-gtags-pop-stack))
    :config
    (add-hook 'c-mode-hook 'helm-gtags-mode))
  (safe-diminish "helm-multi-match" helm-migemo-mode)
  (use-package helm-descbinds
    :bind (("C-h b" . helm-descbinds))
    :config
    (helm-descbinds-mode))
  )

(defun my/ivy-settings ()
  "Settings for Ivy interface."
  (use-package counsel
    :diminish ivy-mode
    :init
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "(%d/%d) ")
    :config
    (ivy-mode 1)
    :bind
    (("C-s" . swiper)
     ("M-x" . counsel-M-x)
     ("C-x C-f" . counsel-find-file)
     ("C-x C-r" . counsel-recentf)
     ("C-c i" . counsel-imenu)
     ("C-," . counsel-company)
     ("M-y" . counsel-yank-pop)
     ("C-h f" . counsel-describe-function)
     ("C-h v" . counsel-describe-variable)
     ("C-h l" . counsel-describe-library)
     ("<f2> i" . counsel-info-lookup-symbol)
     ("<f2> u" . counsel-unicode-char)
     ("C-c k" . counsel-ag)
     ("C-x l" . counsel-locate)
     ("C-c C-r" . ivy-resume)
     :map read-expression-map
     ("C-r" . counsel-expression-history)
     )
    )
  (use-package ivy-hydra
    :pin melpa-stable)
  (use-package counsel-gtags
    :pin melpa-stable)
  (use-package counsel-projectile
    :config
    (counsel-projectile))
  )

(defun my/ido-settings ()
  "Settings for IDO (Default settings)."
   (ido-mode 1)
   (ido-everywhere 1)
   (custom-set-variables
    '(ido-enable-flex-matching t))
   (use-package smex
     :config
     (smex-initialize)
     :bind
     ("M-x" . smex)
     ("M-X" . smex-major-mode-commands)
     ("C-c C-c M-x" . execute-extended-command))
   (use-package ido-ubiquitous
     :config
     (ido-ubiquitous-mode 1))
   (use-package ido-vertical-mode
     :pin melpa-stable
     :init
     (setq ido-max-window-height 0.75)
     :config
     (ido-vertical-mode 1)
     (setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)
     (setq ido-vertical-show-count t)
     )
   (use-package ido-yes-or-no
     :config
     (ido-yes-or-no-mode 1))
   (use-package ido-at-point
     :config
     (ido-at-point-mode 1))
   (use-package ido-occur)
   ;;; skk使いはC-jをskk-modeにする
   ;; from http://emacs.rubikitch.com/ido-ubiquitous/
   (when (fboundp 'skk-mode)
     (fset 'ido-select-text 'skk-mode))
   (setq magit-completing-read-function 'magit-ido-completing-read)
   (defun popup-menu*--ido (selection &rest ignore)
     (ido-completing-read "Popup menu: " selection nil t))
   (advice-add 'popup-menu* :override 'popup-menu*--ido)
   (bind-keys
    ("C-x C-f" . ido-find-file)
    ("C-x f" . ido-find-file-other-window)
    ("C-c o" . ido-occur)
    ("C-x C-d" . ido-dired)
    )
   )

(cond
 ((equalp my/interface-name 'Helm)
  (my/helm-settings))
 ((equalp my/interface-name 'Ivy)
  (my/ivy-settings))
 ((equalp my/interface-name 'IDO)
  (my/ido-settings))
 (t (my/ido-settings)))
;;; 02_completion_interface.el ends here
