;;; Code:
(setq-default ispell-program-name "aspell")
(eval-after-load "ispell"
  '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
(mapc                                   ;; 以下flyspell-modeの設定
 (lambda (hook)
   (add-hook hook 'flyspell-prog-mode))
 '(;; ここに書いたモードではコメント領域のところだけflyspell-mode が有効になる
   c-mode-common-hook
   emacs-lisp-mode-hook
   java-mode
   js2-mode
   scala-mode
   scala2-mode
   rust-mode
   lisp-mode
   emacs-lisp-mode
   ))
(mapc
   (lambda (hook)
     (add-hook hook
                      '(lambda () (flyspell-mode 1))))
   '(;; ここに書いたモードではflyspell-mode が有効になる
     yatex-mode-hook
     org-mode
     markdown-mode
     fundamental-mode
     ))
;;; 32_spelling.el ends here
