;;;;
;; Packages
;;;;

;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)

;(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)

;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;;                          ("marmalade" . "http://marmalade-repo.org/packages/")
;;                          ("melpa-stable" . "http://stable.melpa.org/packages/")
;;                          ("melpa" . "http://melpa.org/packages/")))


;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    paredit

    ;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; support for structured editing, literate haskell
    ;; and an interactive mode for "repl-like" interaction
    haskell-mode

    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking

    ;; integration with a Clojure REPL
    ;; https://github.com/clojure-emacs/cider
    cider

    ;; allow ido usage in as many contexts as possible. see
    ;; customizations/navigation.el line 23 for a description
    ;; of ido
    ido-ubiquitous

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    smex

    ;; project navigation
    projectile

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; edit html tags like sexps
    tagedit

    ;; git integration
    magit

    ;; more reasonable package configuration/loading
    use-package))

;; On OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. Obviously this will lead to unexpected results when
;; calling external utilities like make from Emacs.
;; This library works around this problem by copying important
;; environment variables from the user's shell.
;; https://github.com/purcell/exec-path-from-shell
(if (eq system-type 'darwin)
   (add-to-list 'my-packages 'exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; Place downloaded elisp files in ~/.emacs.d/vendor. You'll then be able
;; to load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; 
;; Adding this code will make Emacs enter yaml mode whenever you open
;; a .yml file
(add-to-list 'load-path "~/.emacs.d/vendor")


;;;;
;; Customization
;;;;

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/customizations")

;; Sets up exec-path-from-shell so that Emacs will use the correct
;; environment variables
(load "shell-integration.el")

;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.
(load "navigation.el")

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(load "ui.el")

;; These customizations make editing a bit nicer.
(load "editing.el")

;; Hard-to-categorize customizations
(load "misc.el")

;; For editing lisps
(load "elisp-editing.el")

;; Language-specific
(load "setup-clojure.el")
(load "setup-js.el")
(load "setup-common-lisp.el")
(load "setup-haskell.el")
(load "setup-racket.el")

;; for literature
(load "writing.el")


;; mobot-specific configs:
(add-to-list 'load-path "~/.emacs.d/config")
(load "setup-python.el")

(use-package aggressive-indent
  :ensure t
  :diminish
  :config (global-aggressive-indent-mode))

(use-package ivy
  :ensure t
  :diminish
  :init (setq ivy-display-style 'fancy
              ivy-use-virtual-buffers t
              ivy-count-format "(%d/%d) "
              ivy-use-selectable-prompt t
              ivy-initial-inputs-alist nil
              ivy-height 15
              ivy-ignore-buffers '("\\` " ".+_archive"))
  :bind (("C-c C-r" . ivy-resume))
  :config (ivy-mode t))

(use-package sqlup-mode
  :ensure t
  :diminish
  :init (setq sqlup-blacklist '("name" "id" "state" "result" "action"))
  :config (add-hook 'sql-mode-hook 'sqlup-mode))

(use-package ag
  :ensure t)

;; for more on elm-mode:
;; https://github.com/jcollard/elm-mode
(use-package elm-mode
  :ensure t
  :init (setq elm-format-on-save t
              elm-package-json "elm.json")
  :config (add-to-list 'company-backends 'company-elm))

(use-package yaml-mode
  :ensure t)

(use-package swiper
  :ensure t
  :init (setq enable-recursive-minibuffers nil)
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

(use-package company
  :ensure t
  :diminish
  :bind (("M-/" . company-complete))
  :config (global-company-mode))

(use-package git-gutter-fringe
  :ensure t
  :diminish git-gutter-mode
  :config
  (set-face-foreground 'git-gutter-fr:modified "deep sky blue")
  (set-face-foreground 'git-gutter-fr:added    "green")
  (set-face-foreground 'git-gutter-fr:deleted  "red")
  (global-git-gutter-mode t))

(use-package ace-window
  :ensure t
  :bind (("C-x o" . ace-window)
         ("M-o" . ace-window))
  :init (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)
              aw-scope 'frame)
  :config (custom-set-faces
           '(aw-leading-char-face
             ((t (:inherit aw-mode-line-face :foreground "orange red" :weight bold :height 3.0))))))


;; https://www.flycheck.org/en/latest/user/installation.html
;; TODO: had to install this manually from MELPA stable, since
;; it wasn't found in MELPA?
;; TODONE: I needed to `package-refresh-contents`:
;; https://github.com/flycheck/flycheck/issues/744
(use-package flycheck
  :ensure t)

(use-package dante
  :ensure t
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  (add-hook 'haskell-mode-hook 'dante-mode)
  (setq dante-tap-type-time 2)
  ;; Recommended by Dante:
  ;; https://github.com/jyp/dante/tree/7411904bfbde25cdb986e001ec682593dcb7c5e3#installation
  ;;(auto-save-visited-mode 1)
  ;;(setq auto-save-visited-interval 1)
  :bind
  (("C-c C-c" . haskell-compile)))

;; Attrap, to complement Dante:
;; https://github.com/jyp/attrap
;; http://h2.jaguarpaw.co.uk/posts/how-i-use-dante/

(use-package attrap
  :ensure t
  :bind (("C-x /" . attrap-attrap)))


;; PURESCRIPT 
;; From the purescript docs:
;; https://github.com/purescript/documentation/blob/5de53609ea0be6e749dada8238d70331dc55db7c/ecosystem/Editor-and-tool-support.md#emacs

;; https://github.com/purescript-emacs/purescript-mode
(use-package purescript-mode
  :ensure t)

(defun purescript-hook ()
 (psc-ide-mode)
 (company-mode)
 (flycheck-mode)
 (turn-on-purescript-indentation))

;; https://github.com/purescript-emacs/psc-ide-emacs
(use-package psc-ide
  :ensure t
  :after purescript-mode
  :config
  (add-hook 'purescript-mode-hook 'purescript-hook)
  :init
  (auto-save-visited-mode 1)
  (setq auto-save-visited-interval 1)
  (customize-set-variable 'psc-ide-rebuild-on-save t))

;; TODO: look into dumb-jump/ag and smartscan:
;; https://github.com/jcorrado/dotfiles/blob/9ed00cc3cff418bfdf9163b27bcb7527d6f8c5ad/tag-emacs/emacs.d/init.el#L334
;; https://github.com/jcorrado/dotfiles/blob/9ed00cc3cff418bfdf9163b27bcb7527d6f8c5ad/tag-emacs/emacs.d/init.el#L216

;; tramp setup
(setq tramp-default-method "ssh")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#c5c8c6" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#8abeb7" "#1d1f21"))
 '(coffee-tab-width 2)
 '(column-number-mode t)
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   (quote
    ("9e54a6ac0051987b4296e9276eecc5dfb67fdcd620191ee553f40a9b6d943e78" "7f1263c969f04a8e58f9441f4ba4d7fb1302243355cb9faecb55aec878a06ee9" "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd" "5ee12d8250b0952deefc88814cf0672327d7ee70b16344372db9460e9a0e3ffc" "52588047a0fe3727e3cd8a90e76d7f078c9bd62c0b246324e557dfa5112e0d0c" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(electric-indent-mode nil)
 '(fci-rule-color "#282a2e")
 '(haskell-compile-cabal-build-command "stack build")
 '(haskell-process-type (quote stack-ghci))
 '(haskell-stylish-on-save t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(magit-bury-buffer-function (quote magit-mode-quit-window))
 '(magit-diff-use-overlays nil)
 '(magit-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
   (quote
    (psc-ide purescript-mode attrap dante flycheck reformatter elm-mode sqlup-mode ag ace-window org-present epresent magit muse markdown-mode haskell-mode slime racket-mode yaml-mode tagedit solarized-theme smex rainbow-delimiters projectile php-mode paredit ido-ubiquitous feature-mode exec-path-from-shell clojure-mode-extra-font-locking cider)))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(safe-local-variable-values
   (quote
    ((cider-default-cljs-repl . shadow)
    (cider-test-infer-test-ns lambda
                               (ns)
                               (if
                                   (string-match "^[^.]+.test" ns)
                                   ns
                                 (replace-regexp-in-string "^\\([^.]+\\)." "\\1.test." ns)))
     (cider-shadow-cljs-default-options . "app"))))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit aw-mode-line-face :foreground "orange red" :weight bold :height 3.0)))))

;; cmd-p keeps killing my emacs
(global-unset-key (kbd "s-p"))

;; emacs server stuff

(server-start)
(setq server-temp-file-regexp ".*")


(add-hook 'org-present-mode-hook
          (lambda ()
            (org-present-big)
            (define-key org-present-mode-keymap [right]  nil)
            (define-key org-present-mode-keymap [left]   nil)
            (define-key org-present-mode-keymap (kbd "C-n")  'org-present-next)
            (define-key org-present-mode-keymap (kbd "C-p")   'org-present-prev)
            (org-display-inline-images)))

;; weird issue with https and the elpa server:
;; https://www.reddit.com/r/emacs/comments/cdei4p/failed_to_download_gnu_archive_bad_request/
;; + https://emacs.stackexchange.com/questions/51615/my-init-el-gets-stuck-on-trying-to-install-spinner-a-sub-dependency-of-cider#comment79634_51615
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(setq visible-bell nil)
(setq ring-bell-function #'ignore)
