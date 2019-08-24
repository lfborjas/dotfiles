;; Python
;;
;; Required modules: jedi flake8 black
;; the `elpy-config' command is useful for checking prerequisites
(use-package elpy
  :ensure t
  :init (elpy-enable)
  :config
  (add-hook 'python-mode-hook 'blacken-mode)
  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i --simple-prompt"))

(use-package blacken
  :ensure t)

(provide 'setup-python)
