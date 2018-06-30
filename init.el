;;; Code:
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;; byte compile if el file is newer whan elc file
;; (add-hook 'after-init-hook
;;           '(lambda ()
;;              (let* ((el (locate-user-emacs-file "init.el"))
;;                     (elc (concat el "c")))
;;                (when (file-newer-than-file-p el elc)
;;                  (byte-compile-file el)))))

(defvar my/emacs-version-number
  (let* ((major emacs-major-version)
	 (minor (float emacs-minor-version))
	 (power (ceiling (log 2 10)))
	 (minor-digit (/ minor (expt 10 power))))
    (+ major minor-digit))
  "Return Emacs version as number."
  )

;; enables clipboard
(if (>= my/emacs-version-number 25.1)
    (custom-set-variables
     '(select-enable-clipboard t)
     )
  (custom-set-variables
   '(x-select-enable-clipboard t))
  )

;; yes/no questions to y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; configuration file settings
(require 'generic-x)

;; delete all auto saved files when emacs finished
(setq delete-auto-save-files t)

;; setting for dired mode
(autoload 'wdired "wdired" nil t)
(add-hook 'dired-load-hook
	  (lambda ()
	    (define-key dired-mode-map "e" 'wdired-change-to-wdired-mode)))
(setq wdired-allow-to-change-permissions t)
;; ls's options D option is export to use dired-mode
(setq dired-listing-switches (purecopy "-aDhl"))
;; dired mode
(setq dired-dwim-target t)

;; reinforce C-x C-f
;; open directory , open browser when cosor on URL
(ffap-bindings)

;; hilighting region
(transient-mark-mode t)


;; hilighting a pair of parenthesis
(show-paren-mode t)
(setq show-paren-style 'mixed)


;; show function name
(which-function-mode t)

;; setting for shell (ignore tohu?)
(add-hook 'shell-mode-hook
          (lambda ()
            (set-buffer-process-coding-system
	     'utf-8-unix 'utf-8-unix)
            ))

;; ignoring character upper or lower when
;; completion of file name
(setq completion-ignore-case t)
;; reload file when the file is updated
(global-auto-revert-mode t)

;; if there is shebang , then +x permission
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; show line number left of each lines
(global-linum-mode 1)

;; kill whole line
(setq kill-whole-line t)

;; tab-width
(setq tab-width 4)

;; windmove
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; mark history
(setq set-mark-command-repeat-pop t)

;; hilight current line
(global-hl-line-mode 1)

;; recentf settings
(eval-when-compile(require 'cl))
(defvar my-recentf-list-prev nil)
(defadvice recentf-save-list
    (around no-message activate)
  "If `recentf-list' and previous recentf-list are equal, do nothing.  And suppress the output from `message' and `write-file' to minibuffer."
  (unless (equal recentf-list my-recentf-list-prev)
    (cl-flet ((message (format-string &rest args)
		       (eval `(format ,format-string ,@args)))
	      (write-file (file &optional confirm)
			  (let ((str (buffer-string)))
			    (with-temp-file file
			      (insert str)))))
      ad-do-it
      (setq my-recentf-list-prev recentf-list))))
(defadvice recentf-cleanup
    (around no-message activate)
  "Suppress the output from `message' to minibuffer."
  (cl-flet ((message (format-string &rest args)
		     (eval `(format ,format-string ,@args))))
    ad-do-it))
(setq recentf-save-file (expand-file-name ".recentf" user-emacs-directory))
(setq recentf-max-saved-items 2000)
(setq recentf-exclude '(".recentf"))
(setq recentf-auto-cleanup 30)
(run-with-idle-timer 30 t 'recentf-save-list)
(recentf-mode 1)


;; settings for package.el
(when (require 'package nil 'noerror)
  ;; adding some repositories
  (add-to-list 'package-archives
	       '("melpa" . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives
	       '("marmalade" . "http://marmalade-repo.org/packages/") t)
  (add-to-list 'package-archives
	       '("melpa-stable" . "https://stable.melpa.org/packages/") t)
  (add-to-list 'package-archives
	       '("org" . "http://orgmode.org/elpa/") t)
  ;; initialize packages
  (package-initialize)
  (unless (file-exists-p (locate-user-emacs-file "first"))
    (package-refresh-contents)
    (shell-command (concat "touch " (locate-user-emacs-file "first")))
    )

  (setq use-package-always-ensure t)

  (unless (package-installed-p 'use-package)
    (package-install 'use-package))

  (eval-when-compile
    (require 'use-package))
  (use-package diminish)
  (require 'bind-key)
  (unless (require 'use-package nil t)
    (defmacro use-package (&rest args)nil))
  
  (use-package use-package-chords
    :config
    (key-chord-mode 1)
    (setq key-chord-two-keys-delay 0.03)
    (setq key-chord-one-key-delay 0.10)
    (defun my/re-key-chord ()
      "disable key-chord and enable key-chord. Only for bug fix."
      (key-chord-mode -1)
      (key-chord-mode +1))
    )

  (defadvice toggle-input-method (after my/im-reKey-chord ())
    "Disable and enable key-chord-mode"
    (my/re-key-chord)
    (message "toggle input method"))
  (ad-activate 'toggle-input-method)

  ;; diminish some minor mode.
  ;; from http://qiita.com/tadsan/items/c859c5c04724cbda75fc#_reference-797b1ffd0bd9b5e8ea58
  (defmacro safe-diminish (file mode &optional new-name)
    "https://github.com/larstvei/dot-emacs/blob/master/init.org"
    `(with-eval-after-load ,file
       (diminish ,mode ,new-name)))

  ;; create a hook for switch-buffer called
  (use-package switch-buffer-functions)

  ;; init-loader setting
  (use-package init-loader
    :init
    (unless (file-exists-p (locate-user-emacs-file "inits"))
      (make-directory "inits" (locate-user-emacs-file "./")))
    :config
    (setq init-loader-show-log-after-init nil)
    ;; (setq init-loader-byte-compile t)
    (init-loader-load (locate-user-emacs-file "inits"))
    (message "init-loader setting loaded")
    )
  )

;;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-image-file-mode 1)
 '(beacon-lighter "")
 '(column-number-mode 1)
 '(company-dabbrev-downcase nil)
 '(company-dabbrev-ignore-case (quote nil))
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 3)
 '(company-selection-wrap-around t)
 '(cyphejor-rules
   (quote
    (:upcase
     ("bookmark" "→")
     ("buffer" "β")
     ("diff" "Δ")
     ("dired" "δ")
     ("emacs" "ε")
     ("fundamental" "φ")
     ("inferior" "i" :prefix)
     ("interaction" "i" :prefix)
     ("interactive" "i" :prefix)
     ("lisp" "λ" :postfix)
     ("menu" "μ")
     ("mode" "")
     ("package" "↓")
     ("python" "π")
     ("shell" "sh" :postfix)
     ("text" "ξ")
     ("wdired" "↯δ")
     ("org" "Ω")
     ("conf" "⚙")
     ("java" "☕"))))
 '(dired-dwim-target t)
 '(dired-recursive-copies (quote always))
 '(dired-recursive-deletes (quote top))
 '(eldoc-idle-delay 0.4)
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (telephone-line beacon madhat2r-theme yatex open-junk-file plantuml-mode ox-pandoc ox-gfm ox-qmd org-present markdown-mode+ markdown-mode skewer-mode string-edit js2-mode rainbow-mode emmet-mode web-mode irony c-eldoc ensime sbt-mode scala-mode java-snippets gradle-mode groovy-mode quickrun highlight-symbol flycheck-pos-tip flycheck free-keys volatile-highlights undo-tree perspeen avy-migemo avy company-web company-shell company sequential-command expand-region bm counsel-projectile counsel-gtags ivy-hydra counsel migemo ddskk orgit magit-gitflow magit init-loader switch-buffer-functions use-package-chords use-package)))
 '(scroll-bar-mode nil)
 '(select-enable-clipboard t)
 '(tool-bar-mode nil)
 '(use-file-dialog nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
