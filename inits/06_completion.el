;;; Code:
(defvar my/completion-type
  'company
  "It's value will 'company or 'ac(means auto-complete)."
  )

(defun my/company-settings ()
  "Settings for company."
  (use-package company
    :pin melpa-stable
    :diminish company-mode
    :demand t
    :bind (("C-c /" . company-files)
	   ("C-M-i" . company-complete)
	   :map company-active-map
	   ("C-s" . company-filter-candidates)
	   ("C-n" . company-select-next)
	   ("C-p" . company-select-previous)
	   ("C-i" . company-complete-selection)
	   :map company-search-map
	   ("C-n" . company-select-next)
	   ("C-p" . company-select-previous))
    :init
    (add-hook 'java-mode-hook
	      '(lambda ()
		 (delete 'company-eclim company-backends)))
    :config
    (global-company-mode +1)
    (setq company-dabbrev-downcase nil)
    (add-to-list 'company-backends '(:with company-yasnippet))
    (custom-set-variables
     '(company-minimum-prefix-length 3)
     '(company-idle-delay 0)
     '(company-selection-wrap-around t)
     '(company-dabbrev-downcase nil)
     '(company-dabbrev-ignore-case 'nil))
    )
  ;; backends for company
  (use-package company-shell
    :config
    (add-to-list 'company-backends 'company-shell))
  (use-package company-web
    :config
    (add-to-list 'company-backends 'company-web-html))
  )

(defun my/ac-settings ()
  "Settings for Auto Complete."
  nil
  )

(cond
 ((equalp my/completion-type 'company)
  (my/company-settings)
  )
 ((equalp my/completion-type 'ac)
  (my/ac-settings))
 (t (my/company-settings))
 )

;;; 06_completion.el ends here
