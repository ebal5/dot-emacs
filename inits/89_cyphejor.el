;;; Code:
(use-package cyphejor
  :config
  (setq cyphejor-rules
	'(:upcase
	  ("bookmark" "→")
	  ("buffer" "β")
	  ("diff" "Δ")
	  ("dired" "δ")
	  ("emacs" "ε")
	  ("fundamental" "φ")
	  ("inferior"    "i" :prefix)
	  ("interaction" "i" :prefix)
	  ("interactive" "i" :prefix)
	  ("lisp"        "λ" :postfix)
	  ("menu" "μ")
	  ("mode" "")
	  ("package" "↓")
	  ("python" "π")
	  ("shell" "sh" :postfix)
	  ("text" "ξ")
	  ("wdired" "↯δ")
	  ("org" "Ω")
	  ("conf" "⚙")
	  ("java" "☕")
	  ))
  (cyphejor-mode 1)
  )
;;; 89_cyphejor.el ends here
