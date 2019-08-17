(require 'haskell-interactive-mode)
(require 'haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(custom-set-variables '(haskell-process-type 'stack-ghci)) ; needed for Stack-based projects only

