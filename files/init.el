;
;   ___ _ __ ___   __ _  ___ ___
;  / _ \ '_ ` _ \ / _` |/ __/ __|
; |  __/ | | | | | (_| | (__\__ \
;  \___|_| |_| |_|\__,_|\___|___/
;
; ~ M. Thomas

(let ((file-name-handler-alist nil))

;; Set the gc threshold high initially so the init.el can just be
;; loaded in one move
(setq gc-cons-threshold most-positive-fixnum) ; 2^61 bytes

;; Lower the gc threshold again afterwards
(add-hook 'emacs-startup-hook
  (lambda ()
    (setq gc-cons-threshold (* 32 1024 1024))))

;; This is important for e.g. lsp mode
(setq read-process-output-max (* 3 1024 1024))

(setq make-backup-files nil
      auto-mode-case-fold nil
      auto-save-default nil
      inhibit-startup-screen t
      tramp-default-method "ssh"
      initial-major-mode 'fundamental-mode
      initial-scratch-message nil
      fast-but-imprecise-scrolling t)

;; Disable bidirectional text scanning for a modest performance boost. I've set
;; this to `nil' in the past, but the `bidi-display-reordering's docs say that
;; is an undefined state and suggest this to be just as good:
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)

;; Disabling the BPA makes redisplay faster, but might produce incorrect display
;; reordering of bidirectional text with embedded parentheses and other bracket
;; characters whose 'paired-bracket' Unicode property is non-nil.
(setq bidi-inhibit-bpa t)  ; Emacs 27 only

;; Reduce rendering/line scan work for Emacs by not rendering cursors or regions
;; in non-focused windows.
(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

;; Emacs "updates" its ui more often than it needs to, so slow it down slightly
(setq idle-update-delay 1.0)  ; default is 0.5

;; Introduced in Emacs HEAD (b2f8c9f), this inhibits fontification while
;; receiving input, which should help a little with scrolling performance.
(setq redisplay-skip-fontification-on-input t)

;; remove ugly bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; show matching parenthesis
(show-paren-mode t)
(setq show-paren-style 'paranthesis)

;; Font
; default font
(set-face-attribute 'default nil :font "SFMono Nerd Font Mono" :height 110)
(set-fontset-font t 'unicode "Source Code Pro" nil 'prepend)
(set-fontset-font t 'unicode "Noto Color Emoji" nil 'append)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Relative line numbers
(setq-default display-line-numbers 'relative
              display-line-numbers-widen t
              ;; this is the default
              display-line-numbers-current-absolute t)

;; soft wrap
(global-visual-line-mode t)

;; display absolute numbers, when in normal mode
(defun noct:relative ()
  (setq-local display-line-numbers 'visual))

(defun noct:absolute ()
  (setq-local display-line-numbers t))

(add-hook 'evil-insert-state-entry-hook #'noct:absolute)
(add-hook 'evil-insert-state-exit-hook #'noct:relative)

;; Whitespace
(global-whitespace-mode t)
(setq whitespace-style '(face trailing tabs tab-mark))

;; straight.el bootstrap
(setq straight-check-for-modifications 'live)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; inhibit package.el load
(setq package-enable-at-startup nil)

(straight-use-package 'use-package)

;; Packages

;; Copy environment
(use-package exec-path-from-shell
  :straight t
  :config
  (setq exec-path-from-shell-arguments '("-l"))
  (exec-path-from-shell-copy-envs '("PATH" "SSH_AGENT_PID" "SSH_AUTH_SOCK")))

;; Spellchecker
(use-package ispell
  :straight t
  :if (executable-find "hunspell")
  :config
  (setq ispell-program-name "hunspell"
        ispell-dictionary "de_DE,en_GB,en_US")
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "de_DE,en_GB,en_US")
  :hook
  (org-mode . flyspell-mode)
  (markdown-mode . flyspell-mode)
  (text-mode . flyspell-mode))

;; Themes and icons
(use-package doom-themes
  :straight t
  :config
  (setq doom-gruvbox-light-variant "soft")
  (load-theme 'doom-gruvbox-light t)
  (doom-themes-org-config)
  (doom-themes-treemacs-config))

;; Cool mode line
(use-package doom-modeline
  :straight t
  :config
  (doom-modeline-mode 1)
  (setq doom-modeline-indent-info t))

;; Cool dashboard
(use-package dashboard
  :straight t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "Welcome back, Marc."
        dashboard-startup-banner 'logo
        dashboard-items '((agenda . 20))
        dashboard-item-names '(("Agenda for the coming week:" . "Agenda:"))
        dashboard-center-content t))

;; show color codes
(use-package rainbow-mode
  :straight t
  :hook
  (prog-mode . rainbow-mode))

;; icons
(use-package all-the-icons
  :straight t)

;; NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA NYA
(use-package nyan-mode
  :straight t
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
  :straight t
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
  :straight t
  :init
  ;; Space as leader key
  (general-create-definer vim-leader-def :prefix "SPC"))

;; Help to find keybindings
(use-package which-key
  :straight t
  :init
  (which-key-mode)
  :diminish
  (which-key-mode)
  :config
  (setq which-key-idle-delay 1))

;; column line
(use-package fill-column-indicator
  :straight t
  :defer 1
  :diminish
  (fci-mode)
  :config
  (setq fci-rule-width 1
        fci-rule-column 100
        fci-rule-color "#cc241d")
  :hook
  (prog-mode . fci-mode)
  (markdown-mode . fci-mode))

;; Vim bindings
(use-package evil
  :straight t
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
  :straight t
  :after evil
  :config
  (evil-collection-init))

;; Completion for swiper
(use-package ivy
  :straight t
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
  :straight t
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

;; I dont want \alert to be my bold text in TeX
(defun hbv/beamer-bold (contents backend info)
  (when (eq backend 'beamer)
    (replace-regexp-in-string "\\`\\\\[A-Za-z0-9]+" "\\\\textbf" contents)))

;; Org
(use-package org
  :straight t
  ;; C-c C-t org rotate
  :general
  (vim-leader-def 'normal 'global
    "oci" 'org-clock-in
    "oco" 'org-clock-out
    "oa"  'org-agenda
    "oca" 'org-capture
    "oes" 'org-edit-src-code
    "obe" 'org-babel-execute-src-block
    "oti" 'org-toggle-inline-images
    "odi" 'org-display-inline-images
    "olp" 'org-latex-preview)
  :hook
  ;; dont make real spaces at the start
  (org-mode . (lambda () (electric-indent-local-mode -1)))
  ;; add virtual spaces
  (org-mode . org-indent-mode)
  :config
  ;; fonts
  (set-face-attribute 'org-document-title nil :font "Product Sans" :weight 'bold :inherit 'default :height 250)
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5)
        org-hidden-keywords '(title)
        org-image-actual-width nil
        org-agenda-files (quote ("~/org"))
        calendar-week-start-day 1
        org-directory "~/org"
        org-latex-listings 'minted
        org-latex-packages-alist '(("" "minted"))
        org-latex-pdf-process
        '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
  (org-babel-do-load-languages 'org-babel-load-languages '((python . t)
                                                           (shell . t)
                                                           (C . t)
                                                           (dot . t)))
  (setq org-todo-keywords '((sequence "TODO" "PROGRESS" "|" "DONE"))
        org-log-done 'time
        org-capture-templates
        (quote (("j" "Japanese" entry (file "~/org/japanese.org") "* TODO %?\n")
                ("w" "Work" entry (file "~/org/work.org") "* TODO %?\n")
                ("u" "University" entry (file "~/org/uni.org") "* TODO %?\n")
                ("p" "Personal" entry (file "~/org/personal.org") "* TODO %?\n")))
        org-edit-src-content-indentation 0))

(use-package ox
  :after org
  :config
  (add-to-list 'org-export-filter-bold-functions 'hbv/beamer-bold))

;; fancy bullets for org
(use-package org-superstar
  :straight t
  :after org
  :hook
  (org-mode . org-superstar-mode)
  :config
  ;; uncomment if slowdown happens
  ;;(setq inhibit-compacting-font-caches t)
  ;; base config, as i wont use level 8
  (set-face-attribute 'org-level-8 nil :font "Product Sans" :weight 'bold :inherit 'default)
  ;; make first 3 bigger
  (set-face-attribute 'org-level-3 nil :inherit 'org-level-8 :height 1.1)
  (set-face-attribute 'org-level-2 nil :inherit 'org-level-8 :height 1.25)
  (set-face-attribute 'org-level-1 nil :inherit 'org-level-8 :height 1.5)
  ;; Low levels are unimportant => no scaling
  (set-face-attribute 'org-level-7 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-6 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-5 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-4 nil :inherit 'org-level-8))

;; auto latex rendering in org-mode
(use-package org-fragtog
  :straight t
  :hook
  (org-mode . org-fragtog-mode))

;; Development Packages

;; git
(use-package magit
  :straight t
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
  :straight t
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
  (treemacs-follow-mode t)
  (treemacs-load-theme "Default")
  (dolist (face '(treemacs-root-face
                  treemacs-git-unmodified-face
                  treemacs-git-modified-face
                  treemacs-git-renamed-face
                  treemacs-git-ignored-face
                  treemacs-git-untracked-face
                  treemacs-git-added-face
                  treemacs-git-conflict-face
                  treemacs-directory-face
                  treemacs-directory-collapsed-face
                  treemacs-file-face
                  treemacs-tags-face))
    (set-face-attribute face nil :family "Product Sans" :height 120))
  :bind
  (:map global-map
    ("C-x t t" . treemacs)))

;; C-c C-p -> projectile
;; C-c C-w -> workspace

(use-package treemacs-evil
  :after (treemacs evil)
  :straight t)

(use-package treemacs-magit
  :after (treemacs magit)
  :straight t)

;; Lsp
(use-package lsp-mode
  :straight t
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-l")
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

;; Tags
(use-package lsp-ivy
  :straight t
  :after lsp-mode
  :bind(:map lsp-mode-map ("C-l g a" . lsp-ivy-workspace-symbol)))

;; Completion for Lsp
(use-package company
  :straight t
  :hook
  (lsp-mode . company-mode)
  (prog-mode . company-mode)
  (LaTeX-mode . company-mode)
  (org-mode . company-mode)
  :custom
  (company-minimum-prefix-length 3)
  (company-idle-delay 0.5)
  :bind (:map company-active-map
              ("C-j" . company-select-next-or-abort) ;; down
              ("C-k" . company-select-previous-or-abort) ;; up
              ("C-l" . company-complete-selection))) ;; right, as in complete towards the right

;; Frontend for company
(use-package company-box
  :straight t
  :config
  (setq company-box-doc-delay 2.0
        company-box-max-candidates 10)
  :hook
  (company-mode . company-box-mode))

;; project support
(use-package projectile
  :straight t
  :after lsp
  :config
  (setq projectile-completion-system 'ivy)
  (projectile-mode +1))

;; snippet support
(defun company-mode/backend-with-yas (backend)
  (if (and (listp backend) (member 'company-yasnippet backend))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(defun company-mode/add-yasnippet ()
  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends)))

(use-package yasnippet
  :straight t
  :init
  :bind (:map yas-minor-mode-map
              ("C-y" . yas-expand))
  :hook
  (company-mode . yas-minor-mode)
  (company-mode . company-mode/add-yasnippet))

(use-package yasnippet-snippets
  :straight (yasnippet-snippets :type git :host github :repo "AndreaCrotti/yasnippet-snippets"
                                :fork (:host github
                                             :repo "crammk/yasnippet-snippets"))
  :after yasnippet)

;; compiling for lsp
(use-package flycheck
  :straight t
  :after lsp)

;; rust
(use-package rust-mode
  :straight t
  :hook
  (rust-mode . prettify-symbols-mode)
  (rust-mode . (lambda ()
                 (push '("->" . ?→) prettify-symbols-alist)
                 (push '("=>" . ?⇒) prettify-symbols-alist)
                 (push '("!=" . ?≠) prettify-symbols-alist)
                 (push '("<=" . ?≤) prettify-symbols-alist)
                 (push '(">=" . ?≥) prettify-symbols-alist))))

(use-package wgsl-mode
  :straight (wgsl-mode :type git :host github :repo "CramMK/wgsl-mode")
  :mode ("\\.wgsl\\'" . wgsl-mode))

;; LaTeX
(use-package auctex
  :straight t
  :defer t
  :init
  (setq TeX-auto-save t
        TeX-parse-self t
        preview-scale-function 1.5))

;; Math Symbols
(use-package math-symbol-lists
  :straight t
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
  :straight t
  :after lsp
  :config
  (setq lsp-java-format-on-type-enabled nil))

(add-hook 'java-mode-hook 'prettify-symbols-mode)
(add-hook 'java-mode-hook (lambda ()
                            (push '("!=" . ?≠) prettify-symbols-alist)
                            (push '("<=" . ?≤) prettify-symbols-alist)
                            (push '(">=" . ?≥) prettify-symbols-alist)))

;; Haskell
(use-package haskell-mode
  :straight t
  :hook
  (haskell-mode . interactive-haskell-mode))

(use-package lsp-haskell
  :straight t
  :after lsp
  :hook
  (haskell-mode . lsp)
  (haskell-literate-mode . lsp))

;; Graphs
(use-package graphviz-dot-mode
  :straight t
  :hook
  (graphviz-dot-mode . (lambda () (set-input-method "math")))
  :config
  (setq graphviz-dot-indent-width 4))

(use-package hl-todo
  :straight t
  :hook
  (prog-mode . hl-todo-mode)
  :config
  (defface hl-todo-TODO
    '((t :background "#cc241d" :foreground "#f2e5bc" :inherit (hl-todo)))
    "TODO Face")
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-color-background t
        hl-todo-keyword-faces '(("TODO"  . hl-todo-TODO)
                                ("XXX"   . hl-todo-TODO)
                                ("FIXME" . hl-todo-TODO))))

(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key (kbd "C-c <right>") 'hs-show-block)
(global-set-key (kbd "C-c <left>") 'hs-hide-block)


;; load local file
(when (file-exists-p "~/.emacs.d/local.el")
  (message "Loading ~/.emacs.d/local.el")
  (load-file "~/.emacs.d/local.el"))

) ;; close performance let
