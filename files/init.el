(setq make-backup-files nil) ;; We dont need these
(setq auto-save-default nil) ;; Not this one either
(menu-bar-mode -1) ;; The menu bar looks ugly in terminal
(tool-bar-mode -1) ;; Nobody needs this
(toggle-scroll-bar -1) ;; Or this
(setq inhibit-startup-screen t) ;; Leave me alone with your tutorials
(setq tramp-default-method "ssh") ;; speed up tramp mode
(set-face-attribute 'default nil :font "FiraCode Nerd Font Mono" :height 110) ;; Set font size

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

;; Show trailing whitespaces
(setq-default show-trailing-whitespace t)

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
                         ("melpa"     . "https://melpa.org/packages/")
                         ("elpa"       . "http://elpa.gnu.org/packages/")
                         ))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package) ; unless it is already installed
  (package-refresh-contents) ; updage packages archive
  (package-install 'use-package)) ; and install the most recent version of use-package

(eval-when-compile
  (require 'use-package))

;; General things

;; Themes and icons
(use-package doom-themes
  :ensure t
  :init
  (load-theme 'doom-vibrant t))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 10)))

(use-package all-the-icons
  :ensure t)

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
  :diminish fci-mode
  :config
  (setq fci-rule-width 1)
  (setq fci-rule-width 80)
  (setq fci-rule-color "green")
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

;; Development

;; giiiiiiiiit
(use-package magit
  :ensure t
  :general
  (vim-leader-def 'normal 'global
    "gj" 'magit-blame
    "gc" 'magit-commit
    "gp" 'magit-push
    "gs" 'magit-status
    "gd" 'magit-diff
    "gl" 'magit-log
    "gc" 'magit-checkout
    "gb" 'magit-branch))

;; lsp
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
  :custom
  (company-minimum-prefix-length 2)
  (company-idle-delay 0.4)
  :bind (:map company-active-map
	      ("C-j" . company-select-next-or-abort) ;; down
	      ("C-k" . company-select-previous-or-abort) ;; up
	      ("C-l" . company-complete-selection) ;; right, as in complete towards the right
	      ))

;; frontend for company
(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))

;; for lsp workspaces
(use-package projectile
  :ensure t
  :config
  (setq projectile-completion-system 'ivy)
  (projectile-mode +1))

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
 '(package-selected-packages
   '(fill-column-indicator lsp-haskell haskell-mode lsp-java auctex rust-mode flycheck yasnippet counsel-projectile projectile company-box company lsp-ivy lsp-ui lsp-mode magit counsel evil-collection evil which-key general all-the-icons doom-themes use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
