;
;   ___ _ __ ___   __ _  ___ ___
;  / _ \ '_ ` _ \ / _` |/ __/ __|
; |  __/ | | | | | (_| | (__\__ \
;  \___|_| |_| |_|\__,_|\___|___/
;
; ~ M. Thomas

(setq make-backup-files nil
      auto-save-default nil
      inhibit-startup-screen t
      tramp-default-method "ssh"
      initial-major-mode 'fundamental-mode
      initial-scratch-message nil)

;; remove ugly bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; smooth scrolling
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;; show matching parenthesis
(show-paren-mode t)
(setq show-paren-style 'paranthesis)

;; Font
; default font
(set-face-attribute 'default nil :font "SFMono Nerd Font Mono" :height 140)
; more fonts
(set-fontset-font t 'unicode "Source Code Pro" nil 'prepend)
(set-fontset-font t 'unicode "Noto Color Emoji" nil 'append)
; fonts for daemon
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

;; Whitespace
(global-whitespace-mode t)
(setq whitespace-style '(face trailing tabs tab-mark))

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("elpa"  . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; Bootstrap use-package
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

;; Copy environment
(use-package exec-path-from-shell
  :ensure t)

(exec-path-from-shell-copy-env "SSH_AGENT_PID")
(exec-path-from-shell-copy-env "SSH_AUTH_SOCK")
(exec-path-from-shell-copy-env "PATH")

;; Spellchecker
(if (executable-find "hunspell")
    (use-package ispell
      :config
      (setq ispell-program-name "hunspell"
            ispell-dictionary "de_DE,en_GB,en_US")
      (ispell-set-spellchecker-params)
      (ispell-hunspell-add-multi-dic "de_DE,en_GB,en_US")
      :hook
      (org-mode . flyspell-mode)
      (markdown-mode . flyspell-mode)
      (text-mode . flyspell-mode)))

;; Themes and icons
(use-package doom-themes
  :ensure t
  :init
  :config
  (setq doom-gruvbox-light-variant "soft")
  (load-theme 'doom-gruvbox-light t)
  (doom-themes-org-config)
  (doom-themes-treemacs-config))

;; Cool mode line
(use-package doom-modeline
  :ensure t
  :init
  (setq doom-modeline-height 25)
  (doom-modeline-mode 1))

;; show color codes
(use-package rainbow-mode
  :ensure t
  :hook
  (prog-mode . rainbow-mode))

;; icons
(use-package all-the-icons
  :ensure t)

;; NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA
(use-package nyan-mode
  :ensure t
  :init
  (nyan-mode)
  (nyan-start-animation)
  (nyan-toggle-wavy-trail)
  :config
  (setq nyan-cat-face-number 4))

;; Indentation for c
(setq-default c-basic-offset 8)

;; Heuristic indentation
(use-package dtrt-indent
  :ensure t
  :hook
  (prog-mode . dtrt-indent-mode)
  (text-mode . dtrt-indent-mode)
  (org-mode . dtrt-indent-mode)
  (markdown-mode . dtrt-indent-mode))

;; Auto parens
(use-package electric-pair
  :config
  (setq electric-pair-open-newline-between-pairs nil)
  :hook
  (prog-mode . electric-pair-mode)
  (text-mode . electric-pair-mode)
  (org-mode . electric-pair-mode)
  (markdown-mode . electric-pair-mode))

;; general
(use-package general
  :ensure t
  :init
  ;; Space as leader key
  (general-create-definer vim-leader-def :prefix "SPC"))

;; Help to find keybindings
(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  :diminish
  (which-key-mode)
  :config
  (setq which-key-idle-delay 1))

;; 80 character limit line in prog mode
(use-package fill-column-indicator
  :ensure t
  :defer 1
  :diminish
  (fci-mode)
  :config
  (setq fci-rule-width 1
        fci-rule-color "#cc241d")
  :hook
  (prog-mode . fci-mode)
  (markdown-mode . fci-mode))

;; Vim bindings
(use-package evil
  :ensure t
  :bind
  (:map evil-motion-state-map
        ("C-y" . nil))
  (:map evil-insert-state-map
        ("C-y" . nil))
  :init
  ;; so C-z works for background
  (setq evil-toggle-key "C-~"
        evil-want-C-d-scroll t
        evil-want-C-u-scroll t
        evil-want-integration t
        evil-want-keybinding nil)
  :config
  (evil-mode))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; Completion for swiper
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
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

;; Org
(use-package org
  :ensure t
  ;; C-c C-t org rotate
  :general
  (vim-leader-def 'normal 'global
    "oci" 'org-clock-in
    "oco" 'org-clock-out
    "oa"  'org-agenda
    "oca" 'org-capture
    "oes" 'org-edit-src-code
    "oti" 'org-toggle-inline-images
    "odi" 'org-display-inline-images
    "olp" 'org-latex-preview)
  :hook
  (org-mode . (lambda () (electric-indent-local-mode -1)))
  :config
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5)
        org-agenda-files (quote ("~/org"))
        org-directory "~/org"
        org-latex-listings 'minted
        org-latex-packages-alist '(("" "minted"))
        org-latex-pdf-process
        '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
  :init
  (setq org-todo-keywords '((sequence "TODO" "PROGRESS" "|" "DONE"))
        org-log-done 'time
        org-capture-templates
        (quote (("j" "Japanese" entry (file "~/org/japanese.org") "* TODO %?\n")
                ("u" "University" entry (file "~/org/uni.org") "* TODO %?\n")
                ("p" "Personal" entry (file "~/org/personal.org") "* TODO %?\n")))
        org-edit-src-content-indentation 0))

;; enable languages for inline evaluation
(org-babel-do-load-languages
 'org-babel-load-languages '((python . t)
                             (shell . t)
                             (C . t)
                             (dot . t)))
; don't ask me every time!
(defun my-org-confirm-babel-evaluate (lang body)
  (not (member lang '("python" "shell" "C" "dot"))))
(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

;; fancy bullets for org
(use-package org-bullets
  :ensure t
  :after org
  :hook
  (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; auto latex rendering in org-mode
(use-package org-fragtog
  :ensure t
  :hook
  (org-mode . org-fragtog-mode))

;; Development Packages

;; git
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
    "gb" 'magit-branch
    "gi" 'magit-gitignore-in-topdir))

;; File bar
(use-package treemacs
  :ensure t
  :defer t
  :config
  (setq treemacs-follow-after-init t
        treemacs-persist-file (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
        treemacs-width 40
        treemacs-project-follow-cleanup t
        treemacs-tag-follow-cleanup t
        treemacs-expand-after-init nil
        treemacs-recenter-after-file-follow t
        treemacs-recenter-after-tag-follow t
        treemacs-tag-follow-delay 1)
  (treemacs-tag-follow-mode t)
  (treemacs-load-theme "doom-atom")
  :bind
  (:map global-map
    ("C-x t t" . treemacs)))

;; C-c C-p -> projectile
;; C-c C-w -> workspace

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

;; Lsp
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-l"
        gc-cons-threshold (* 200 1024 1024)
        read-process-output-max (* 3 1024 1024))
  :config
  (lsp-enable-which-key-integration t)
  (setq lsp-rust-server 'rust-analyzer
        lsp-auto-guess-root t
        lsp-idle-delay 1
        lsp-enable-file-watchers nil)
  :hook
  (rust-mode . lsp)
  (java-mode . lsp)
  (python-mode . lsp)
  (haskell-mode . lsp))

;; Ui integration for Lsp
(use-package lsp-ui
  :ensure t
  :config
  (setq lsp-ui-peek-enable nil
        lsp-ui-sideline-show-code-actions nil
        lsp-modeline-code-actions-enable nil
        lsp-ui-doc-enable nil))

;; Tags
(use-package lsp-ivy
  :ensure t
  :after lsp-mode
  :bind(:map lsp-mode-map ("C-l g a" . lsp-ivy-workspace-symbol)))

;; Completion for Lsp
(use-package company
  :ensure t
  :hook
  (lsp-mode . company-mode)
  (prog-mode . company-mode)
  (LaTeX-mode . company-mode)
  (org-mode . company-mode)
  :custom
  (company-minimum-prefix-length 2)
  (company-idle-delay 0.5)
  :bind (:map company-active-map
              ("C-j" . company-select-next-or-abort) ;; down
              ("C-k" . company-select-previous-or-abort) ;; up
              ("C-l" . company-complete-selection))) ;; right, as in complete towards the right

;; Frontend for company
(use-package company-box
  :ensure t
  :hook
  (company-mode . company-box-mode))

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
  :bind (:map yas-minor-mode-map
              ("C-y" . yas-expand))
  :hook
  (company-mode . yas-minor-mode)
  (company-mode . company-mode/add-yasnippet))

(use-package yasnippet-snippets
  :quelpa ((yasnippet-snippets :fetcher github :repo "CramMK/yasnippet-snippets")))

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
  (setq TeX-auto-save t
        TeX-parse-self t
        preview-scale-function 1.5))

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
   ; Quantoren
   ("\\ex"      ?∃)
   ("\\all"     ?∀)
   ; sets of numbers
   ("\\NN"        ?ℕ)
   ("\\ZZ"        ?ℤ)
   ("\\QQ"        ?ℚ)
   ("\\RR"        ?ℝ)
   ("\\CC"        ?ℂ)
   ("\\PP"        ?ℙ)
  )
  (mapc (lambda (x)
          (if (cddr x)
              (quail-defrule (cadr x) (car (cddr x)))))
        (append math-symbol-list-basic
                math-symbol-list-extended
                math-symbol-list-superscripts
                math-symbol-list-subscripts)))

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

;; Graphs
(use-package graphviz-dot-mode
  :ensure t
  :hook
  (graphviz-dot-mode . (lambda () (set-input-method "math")))
  :config
  (setq graphviz-dot-indent-width 4))

;; use my beauty everywhere
(use-package emacs-everywhere
  :ensure t
  :hook
  (emacs-everywhere-mode . (lambda () (set-input-method "math")))
  :config
  (setq emacs-everywhere-markdown-apps nil
        emacs-everywhere-markdown-windows nil))

;; load local file
(when (file-exists-p "~/.emacs.d/local.el")
  (message "Loading ~/.emacs.d/local.el")
  (load-file "~/.emacs.d/local.el"))
