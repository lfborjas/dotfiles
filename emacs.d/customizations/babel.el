;; Configure org-mode with Cider
;; From: http://fgiasson.com/blog/index.php/2016/04/05/using-clojure-in-org-mode-and-implementing-asynchronous-processing/
;; And: 

;; Configure Org-mode supported languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((clojure . t)
   (emacs-lisp . t)))

;; Use cider as the Clojure execution backend
(setq org-babel-clojure-backend 'cider)
(require 'cider)

(org-defkey org-mode-map "\C-x\C-e" 'cider-eval-last-sexp)
(org-defkey org-mode-map "\C-c\C-d" 'cider-doc)      


