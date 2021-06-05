;
;   ___ _ __ ___   __ _  ___ ___
;  / _ \ '_ ` _ \ / _` |/ __/ __|
; |  __/ | | | | | (_| | (__\__ \
;  \___|_| |_| |_|\__,_|\___|___/
;
; ~ M. Thomas

(setq make-backup-files nil) ;; We dont need these
(setq auto-save-default nil) ;; Not this one either
(menu-bar-mode -1) ;; The menu bar looks ugly in terminal
(tool-bar-mode -1) ;; Nobody needs this
(scroll-bar-mode -1)
(toggle-scroll-bar -1) ;; Or this
(setq inhibit-startup-screen t) ;; Leave me alone with your tutorials
(setq tramp-default-method "ssh") ;; speed up tramp mode
(setq initial-major-mode 'fundamental-mode) ;; better startup speed
(setq initial-scratch-message nil) ;; don't show me help at startup

;; Show matching paranthesis
(show-paren-mode t)
;; paranthesis
;; expression
;; mixed - paren if visible, expr when not
(setq show-paren-style 'paranthesis)

;; Font
(set-face-attribute 'default nil :font "SFMono Nerd Font Mono" :height 100)
(add-to-list 'default-frame-alist '(font . "SFMono Nerd Font Mono"))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Relative line numbers
(setq-default display-line-numbers 'visual
              display-line-numbers-widen t
              ;; this is the default
              display-line-numbers-current-absolute t)

(defun noct:relative ()
  (setq-local display-line-numbers 'visual))

(defun noct:absolute ()
  (setq-local display-line-numbers t))

(add-hook 'evil-insert-state-entry-hook #'noct:absolute)
(add-hook 'evil-insert-state-exit-hook #'noct:relative)

;; whitespace
(global-whitespace-mode t)
(setq whitespace-style '(face trailing tabs tab-mark))


(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("elpa"  . "http://elpa.gnu.org/packages/")
                         ))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package) ; unless it is already installed
  (package-refresh-contents) ; update packages archive
  (package-install 'use-package)) ; and install the most recent version of use-package

(eval-when-compile
  (require 'use-package))

(use-package quelpa
  :ensure t)
(use-package quelpa-use-package
  :ensure t)

;; Packages

(use-package exec-path-from-shell
  :ensure t)

;; Use ssh agent from env
(exec-path-from-shell-copy-env "SSH_AGENT_PID")
(exec-path-from-shell-copy-env "SSH_AUTH_SOCK")
(exec-path-from-shell-copy-env "PATH")

;; Themes and icons
(use-package doom-themes
  :ensure t
  :init
  :config
  (setq doom-gruvbox-light-variant "soft")
  (load-theme 'doom-gruvbox-light t)
  (doom-themes-org-config)
  (doom-themes-treemacs-config))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 10)))

;; icons
(use-package all-the-icons
  :ensure t)

;; fancy startup screen
(use-package page-break-lines
  :ensure t)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(setq dashboard-banner-logo-title "Welcome back, Marc")
(setq dashboard-startup-banner 'logo)
(setq dashboard-center-content t)
(setq dashboard-items '((recents  . 5)
                        (projects . 5)))
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)

;; NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA
;; music requires 'player'
(use-package nyan-mode
  :ensure t
  :config
  (nyan-mode)
  (nyan-start-animation))

;; indentation for c
(setq-default c-basic-offset 8)

;; heuristic indentation
(use-package dtrt-indent
  :ensure t
  :hook
  (prog-mode . dtrt-indent-mode)
  (markdown-mode . dtrt-indent-mode))

;; auto parens
(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (require 'smartparens-config)
  (setq sp-highlight-pair-overlay nil) ;; to hide this fucking highlighting
  :hook
  (prog-mode . smartparens-mode)
  (markdown-mode . smartparens-mode))

;; general
(use-package general
  :ensure t
  :init
  ;; Space as leader key
  (general-create-definer vim-leader-def :prefix "SPC"))

;; help to find keybindings
(use-package which-key
  :ensure t
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

;; 80 charcater limit line in prog mode
(use-package fill-column-indicator
  :ensure t
  :defer 1
  :diminish fci-mode
  :config
  (setq fci-rule-width 1)
  (setq fci-rule-color "#cc241d")
  :hook
  (prog-mode . fci-mode)
  (markdown-mode . fci-mode))

;; vim mode
(use-package evil
  :ensure t
  :init
  (setq evil-toggle-key "C-~") ;; so C-z works for background
  (setq evil-want-C-d-scroll t)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; completion for swiper
(use-package ivy
  :ensure t
  :diminish
  :bind (("C-s" . swiper) ; TODO: possibly map this to / at some point?
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . Ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

;; org mode
(use-package org
  :ensure t
  ;; C-c C-t org rotate
  :general
  (vim-leader-def 'normal 'global
    "oci" 'org-clock-in
    "oco" 'org-clock-out
    "oa"  'org-agenda
    "oca" 'org-capture)
  :config
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
  (setq org-agenda-files (quote ("~/org")))
  (setq org-directory "~/org")
  :init
  (setq org-todo-keywords '((sequence "TODO" "PROGRESS" "|" "DONE")))
  (setq org-log-done 'time)
  (setq org-capture-templates
	(quote (("j" "Japanese" entry (file "~/org/japanese.org") "* TODO %?\n")
		("u" "University" entry (file "~/org/uni.org") "* TODO %?\n")
		("p" "Personal" entry (file "~/org/personal.org") "* TODO %?\n")))))

(use-package org-bullets
  :ensure t
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Development Packages

;; giiiiiiiiit
(use-package magit
  :ensure t
  :general
  (vim-leader-def 'normal 'global
    "gj" 'magit-blame
    "gc" 'magit-commit
    "gp" 'magit-push
    "gu" 'magit-pull
    "gs" 'magit-status
    "gd" 'magit-diff
    "gl" 'magit-log
    "gc" 'magit-checkout
    "gb" 'magit-branch))

;; Treemacs
(use-package treemacs
  :ensure t
  :defer t
  :config
  (progn
    (setq
     treemacs-follow-after-init t
     treemacs-persist-file (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
     treemacs-width 40)
    (treemacs-follow-mode t))
  :bind
  (:map global-map
    ("C-x t t" . treemacs)))

;; C-c C-p -> projectile
;; C-c C-w -> workspace

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

;; Lsp
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-l")
  (setq gc-cons-threshold 100000000) ;; 100 mb
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  :config
  (lsp-enable-which-key-integration t)
  (setq lsp-rust-server 'rust-analyzer)
  (setq lsp-auto-guess-root t)
  (setq lsp-idle-delay 1.)
  :hook
  (rust-mode . lsp)
  (java-mode . lsp)
  (python-mode . lsp)
  (haskell-mode . lsp))

;; ui integration for lsp
(use-package lsp-ui
  :ensure t
  :config
  (setq lsp-ui-peek-enable nil)
  (setq lsp-ui-sideline-show-code-actions nil)
  (setq lsp-modeline-code-actions-enable nil)
  (setq lsp-ui-doc-enable nil))

;; tags
(use-package lsp-ivy
  :ensure t
  :after lsp-mode
  :bind(:map lsp-mode-map ("C-l g a" . lsp-ivy-workspace-symbol)))

;; completion for lsp
(use-package company
  :ensure t
  :hook
  (lsp-mode . company-mode)
  (prog-mode . company-mode)
  (LaTeX-mode . company-mode)
  (org-mode . company-mode)
  :custom
  (company-minimum-prefix-length 2)
  (company-idle-delay 0.1)
  :bind (:map company-active-map
	      ("C-j" . company-select-next-or-abort) ;; down
	      ("C-k" . company-select-previous-or-abort) ;; up
	      ("C-l" . company-complete-selection) ;; right, as in complete towards the right
	      ))

;; frontend for company
(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))

;; project support
(use-package projectile
  :ensure t
  :config
  (setq projectile-completion-system 'ivy)
  (projectile-mode +1))

;; ui for projectline
(use-package counsel-projectile
  :ensure t
  :init
  (define-key projectile-mode-map (kbd "M-p") 'projectile-command-map))

;; snippet support
(defun company-mode/backend-with-yas (backend)
  (if (and (listp backend) (member 'company-yasnippet backend))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(defun company-mode/add-yasnippet ()
  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends)))

(use-package yasnippet
  :ensure t
  :init
  :hook
  (company-mode . yas-minor-mode)
  (company-mode . company-mode/add-yasnippet))

(use-package yasnippet-snippets
  :quelpa ((yasnippet-snippets :fetcher github :repo "hargoniX/yasnippet-snippets")))

;; compiling for lsp
(use-package flycheck
  :ensure t)

;; rust
(use-package rust-mode
  :ensure t
  :hook
  (rust-mode . prettify-symbols-mode)
  (rust-mode . (lambda ()
		 (push '("->" . ?→) prettify-symbols-alist)
		 (push '("=>" . ?⇒) prettify-symbols-alist)
		 (push '("!=" . ?≠) prettify-symbols-alist)
		 (push '("<=" . ?≤) prettify-symbols-alist)
                 (push '(">=" . ?≥) prettify-symbols-alist))))

;; LaTeX
(use-package auctex
  :ensure t
  :defer t
  :init
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq preview-scale-function 1.5))

;; Fix math input
(use-package unicode-fonts
  :ensure t
  :hook
  (unicode-fonts-setup))

;; Math Symbols
(use-package math-symbol-lists
  :ensure t
  :config
  (quail-define-package "math" "UTF-8" "Ω" t)
  (quail-define-rules ; add whatever extra rules you want to define here...
   ; Equality
   ("<="        ?≤)
   (">="        ?≥)
   ("~="        ?≠)
   ; Logic
   ("~"         ?¬)
   ("->"        ?→)
   ("=>"        ?⇒)
   ("<->"       ?↔)
   ("<=>"       ?⇔)
   ; sets of numbers
   ("\\nats"    ?ℕ)
   ("\\ints"    ?ℤ)
   ("\\rats"    ?ℚ)
   ("\\reals"   ?ℝ)
   ("\\complex" ?ℂ)
   ("\\primes"  ?ℙ)
  )
  (mapc (lambda (x)
          (if (cddr x)
              (quail-defrule (cadr x) (car (cddr x)))))
        (append math-symbol-list-basic math-symbol-list-extended math-symbol-list-superscripts math-symbol-list-subscripts))
  )

;; Java
(use-package lsp-java
  :ensure t
  :config
  (setq lsp-java-format-on-type-enabled nil))

(add-hook 'java-mode-hook 'prettify-symbols-mode)
(add-hook 'java-mode-hook (lambda ()
		 (push '("!=" . ?≠) prettify-symbols-alist)
		 (push '("<=" . ?≤) prettify-symbols-alist)
		 (push '(">=" . ?≥) prettify-symbols-alist)))

;; Haskell
(use-package haskell-mode
  :ensure t
  :hook
  (haskell-mode . interactive-haskell-mode))

(use-package lsp-haskell
  :ensure t
  :hook
  (haskell-mode . lsp)
  (haskell-literate-mode . lsp))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("4a8d4375d90a7051115db94ed40e9abb2c0766e80e228ecad60e06b3b397acab" "a3bdcbd7c991abd07e48ad32f71e6219d55694056c0c15b4144f370175273d16" "e074be1c799b509f52870ee596a5977b519f6d269455b84ed998666cf6fc802a" "8f5a7a9a3c510ef9cbb88e600c0b4c53cdcdb502cfe3eb50040b7e13c6f4e78e" "fce3524887a0994f8b9b047aef9cc4cc017c5a93a5fb1f84d300391fba313743" default))
 '(package-selected-packages
   '(dashboard org-bullets ein fill-column-indicator lsp-haskell haskell-mode lsp-java auctex rust-mode flycheck yasnippet counsel-projectile projectile company-box company lsp-ivy lsp-ui lsp-mode magit counsel evil-collection evil which-key general all-the-icons doom-themes use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
