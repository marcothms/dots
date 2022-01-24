;;; -*- lexical-binding: t -*-

(defun tangle-init ()
  (when (equal (buffer-file-name)
               (expand-file-name (concat (getenv "HOME") "/dots/files/init.org")))
    ;; Avoid running hooks when tangling.
    (let ((prog-mode-hook nil))
      (org-babel-tangle))))

(add-hook 'after-save-hook 'tangle-init)

(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
  (lambda ()
    (setq gc-cons-threshold (* 32 1024 1024))))

(setq read-process-output-max (* 3 1024 1024))

(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)

(setq bidi-inhibit-bpa t)

(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

(setq idle-update-delay 1.0)

(setq redisplay-skip-fontification-on-input t)

(setq make-backup-files nil
      auto-mode-case-fold nil
      auto-save-default nil
      inhibit-startup-screen t
      tramp-default-method "ssh"
      initial-major-mode 'fundamental-mode
      initial-scratch-message nil
      fast-but-imprecise-scrolling t)

(add-hook 'doc-view-mode-hook 'auto-revert-mode)

(fset 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(global-visual-line-mode t)

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

(setq package-enable-at-startup nil)
(straight-use-package 'use-package)

(use-package general
  :straight t
  :init
  (general-create-definer vim-leader-def :prefix "SPC"))

(use-package which-key
  :straight t
  :init
  (which-key-mode)
  :diminish
  (which-key-mode)
  :config
  (setq which-key-idle-delay 1))

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

(use-package evil-matchit
  :straight t
  :after evil
  :config
  (global-evil-matchit-mode 1))

(set-face-attribute 'default nil :font "JuliaMono" :height 110)
(set-fontset-font t 'unicode "Noto Color Emoji" nil 'prepend)
(set-fontset-font t 'unicode "Noto Sans Mono CJK JP" nil 'append)

(set-face-attribute 'variable-pitch nil :family "Roboto")
(set-face-attribute 'fixed-pitch nil :family "JuliaMono")

(use-package mixed-pitch
  :straight t
  :hook
  (text-mode . mixed-pitch-mode))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(show-paren-mode t)
(setq show-paren-style 'paranthesis)

(setq-default display-line-numbers 'relative
              display-line-numbers-widen t
              ;; this is the default
              display-line-numbers-current-absolute t)

;; Display absolute numbers, when in normal mode
(defun noct:relative ()
  (setq-local display-line-numbers 'relative))

(defun noct:absolute ()
  (setq-local display-line-numbers t))

(add-hook 'evil-insert-state-entry-hook #'noct:absolute)
(add-hook 'evil-insert-state-exit-hook #'noct:relative)

(use-package doom-themes
  :straight (doom-themes :type git :host github :repo "hlissner/emacs-doom-themes"
                                :fork (:host github :repo "CramMK/emacs-doom-themes"))
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-ayu-light t)
  (doom-themes-org-config)
  (doom-themes-treemacs-config))

(use-package doom-modeline
  :straight t
  :config
  (doom-modeline-mode 1)
  (setq doom-modeline-indent-info t
        doom-modeline-buffer-file-name-style 'file-name))

(use-package all-the-icons
  :straight t)

(use-package nyan-mode
  :straight t
  :init
  (nyan-mode)
  (nyan-start-animation)
  ;; (nyan-toggle-wavy-trail)
  :config
  (setq nyan-cat-face-number 4))

(use-package rainbow-mode
  :straight t
  :hook
  (prog-mode . rainbow-mode))

(global-whitespace-mode t)
(setq whitespace-style '(face trailing tabs tab-mark))
(add-hook 'before-save-hook 'whitespace-cleanup)

(use-package fill-column-indicator
  :straight t
  :defer 1
  :diminish
  (fci-mode)
  :config
  (setq fci-rule-width 1
        fci-rule-column 80
        fci-rule-color "#A6CC70")
  :hook
  (prog-mode . fci-mode)
  (markdown-mode . fci-mode))

(use-package treemacs
  :straight t
  :defer t
  :config
  (setq treemacs-follow-after-init t
        treemacs-persist-file (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
        treemacs-width 50
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
    (set-face-attribute face nil :family "JuliaMono" :height 110))
  :bind
  (:map global-map
    ("C-x t t" . treemacs)))

;; C-c C-p -> projectile
;; C-c C-w -> workspace

(use-package treemacs-evil
  :after (treemacs evil)
  :straight t)

(use-package ivy
  :straight t
  :diminish
  :bind (("C-s" . swiper)
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
         ("C-x C-g" . counsel-git)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

(use-package org
  :straight t
  :general
  (vim-leader-def 'normal 'global
    "oci" 'org-clock-in
    "oco" 'org-clock-out
    "oa"  'org-agenda
    "oca" 'org-capture
    "oes" 'org-edit-src-code
    "oti" 'org-toggle-inline-images
    "odi" 'org-display-inline-images)
  :hook
  (org-mode . (lambda () (electric-indent-local-mode -1)))   ;; dont make real spaces at the start of a line
  (org-mode . org-indent-mode)                               ;; add virtual spaces
  :config
  (define-key evil-normal-state-map (kbd "TAB") 'org-cycle)) ;; use TAB to FOLD in every evil-mode

(setq ;; org-hidden-keywords '(title)           ;; hide title
      org-startup-with-inline-images t       ;; start with inline images enabled
      org-image-actual-width nil             ;; rescale inline images
      org-directory "~/org"                  ;; set org file directory
      org-agenda-files (quote ("~/org"))     ;; indexed files by org agenda
      org-edit-src-content-indentation 0     ;; don't indent stupidly in org-edit-src-code
      org-log-done nil                       ;; just mark DONE without a time stamp
      org-log-repeat nil                     ;; don't set a time after marking sth DONE
      org-agenda-start-on-weekday nil        ;; my week starts on a monday
      calendar-week-start-day 1              ;; my week starts on a monday
)

(setq org-todo-keywords '((sequence "TODO" "PROGRESS" "REVIEW" "|" "DONE"))
      org-todo-keyword-faces '(("TODO" . "#cc241d") ("PROGRESS" . "#a6cc70") ("REVIEW" . "#b16286") ("DONE" . "#abb0b6")))

(setq org-capture-templates
  (quote (("w" "Work" entry (file "~/org/work.org") "* TODO %?\n" :empty-lines-before 1)
          ("u" "University" entry (file "~/org/uni.org") "* TODO %?\n" :empty-lines-before 1)
          ("p" "Personal" entry (file "~/org/personal.org") "* TODO %?\n" :empty-lines-before 1))))

(org-babel-do-load-languages 'org-babel-load-languages '((python . t)
                                                         (shell . t)
                                                         (haskell . t)
                                                         (C . t)
                                                         (dot . t)))

(use-package sage-shell-mode
  :straight t)

(use-package ob-sagemath
  :straight t)

(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f")
      org-latex-inputenc-alist '(("utf8" . "utf8x"))
      org-latex-default-packages-alist (cons '("mathletters" "ucs" nil) org-latex-default-packages-alist)
      org-format-latex-options (plist-put org-format-latex-options :scale 1.5))

(defun mth/beamer-bold (contents backend info)
  (when (eq backend 'beamer)
    (replace-regexp-in-string "\\`\\\\[A-Za-z0-9]+" "\\\\textbf" contents)))

(use-package ox
  :after org
  :config
  (add-to-list 'org-export-filter-bold-functions 'mth/beamer-bold)
  (add-to-list 'org-latex-logfiles-extensions "tex"))

(use-package org-fragtog
  :straight t
  :hook
  (org-mode . org-fragtog-mode))

(use-package graphviz-dot-mode
  :straight t
  :hook
  (graphviz-dot-mode . (lambda () (set-input-method "math")))
  :config
  (setq graphviz-dot-indent-width 4))

(set-face-attribute 'org-document-title nil :family "Roboto" :weight 'bold :inherit 'default :height 250)
(setq org-ellipsis " ⮷"                    ;; folding icon
      ;; org-hide-emphasis-markers t          ;; hide markers such as *, =, _
)

(use-package org-superstar
  :straight t
  :after org
  :hook
  (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-remove-leading-stars t))

(use-package org-super-agenda
  :straight t
  :after org
  :config
  (setq org-super-agenda-groups '((:auto-group t)))
  (org-super-agenda-mode))

(use-package dtrt-indent
  :straight t
  :hook
  (prog-mode . dtrt-indent-mode)
  (text-mode . dtrt-indent-mode)
  (org-mode . dtrt-indent-mode)
  (markdown-mode . dtrt-indent-mode))

(use-package electric-pair
  :config
  (setq electric-pair-open-newline-between-pairs nil)
  :hook
  (prog-mode . electric-pair-mode)
  (text-mode . electric-pair-mode)
  (org-mode . electric-pair-mode)
  (markdown-mode . electric-pair-mode))

(use-package magit
  :straight t
  :general
  (vim-leader-def 'normal 'global
    "gb" 'magit-branch
    "gc" 'magit-checkout
    "gc" 'magit-commit
    "gd" 'magit-diff
    "gg" 'counsel-git-grep
    "gi" 'magit-gitignore-in-topdir
    "gj" 'magit-blame
    "gl" 'magit-log
    "gp" 'magit-push
    "gs" 'magit-status
    "gu" 'magit-pull))

(use-package treemacs-magit
  :after (treemacs magit)
  :straight t)

(use-package hl-todo
  :straight t
  :hook
  (prog-mode . hl-todo-mode)
  :config
  (defface hl-todo-TODO
    '((t :background "#cc241d" :foreground "#ffffff"))
    "TODO Face")
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-color-background t
        hl-todo-keyword-faces '(("TODO"  . hl-todo-TODO)
                                ("XXX"   . hl-todo-TODO)
                                ("FIXME" . hl-todo-TODO))))

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
              ("C-j" . company-select-next-or-abort)
              ("C-k" . company-select-previous-or-abort)
              ("C-l" . company-complete-selection)))

(use-package company-box
  :straight t
  :config
  (setq company-box-doc-delay 2.0
        company-box-max-candidates 10)
  :hook
  (company-mode . company-box-mode))

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
                                             :repo "marcothms/yasnippet-snippets"))
  :after yasnippet)

(use-package lsp-mode :straight t
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
  (python-mode . lsp)
  (haskell-mode . lsp)
  (c++-mode . lsp))

(use-package flycheck
  :straight t
  :after lsp)

(use-package lsp-ivy
  :straight t
  :after lsp-mode
  :bind(:map lsp-mode-map ("C-l g a" . lsp-ivy-workspace-symbol)))

(use-package projectile
  :straight t
  :after lsp
  :config
  (setq projectile-completion-system 'ivy)
  (projectile-mode +1))

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

(use-package dap-mode
  :straight t)

(require 'dap-python)

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

(use-package math-symbol-lists
  :straight t
  :config
  (quail-define-package "math" "UTF-8" "Ω" t)
  (quail-define-rules
   ; Equality and order
   ("<=" ?≤) (">=" ?≥) ("\\prec" ?≺) ("\\preceq" ?≼) ("\\succ" ?≻)
   ("\\succeq" ?≽)
   ("/=" ?≠) ("\\neq" ?≠) ("\\=n" ?≠)("\\equiv" ?≡) ("\\nequiv" ?≢)
   ("\\approx" ?≈) ("\\~~" ?≈) ("\\t=" ?≜) ("\\def=" ?≝)

   ; Set theory
   ("\\sub" ?⊆) ("\\subset" ?⊂) ("\\subseteq" ?⊆) ("\\in" ?∈)
   ("\\inn" ?∉) ("\\:" ?∈) ("\\cap" ?∩) ("\\inter" ?∩)
   ("\\cup" ?∪) ("\\uni" ?∪) ("\\emptyset" ?∅) ("\\empty" ?∅)
   ("\\times" ?×) ("\\x" ?×)

   ; Number stuff
   ("\\mid" ?∣) ("\\infty" ?∞) ("\\sqrt" ?√) ("\\Im" ?ℑ) ("\\Re" ?ℜ)

   ; Logic
   ("\\/" ?∨) ("\\and" ?∧) ("/\\" ?∧) ("\\or" ?∨) ("~" ?¬) ("\neg" ?¬)
   ("|-" ?⊢) ("|-n" ?⊬) ("\\bot" ?⊥) ("\\top" ?⊤)
   ("\\r" ?→) ("\\lr" ?↔)
   ("\\R" ?⇒) ("\\Lr" ?⇔)
   ("\\qed" ?∎)

   ; Predicate logic
   ("\\all" ?∀) ("\\ex" ?∃) ("\\exn" ?∄)

   ; functions
   ("\\to" ?→) ("\\mapsto" ?↦) ("\\circ" ?∘) ("\\comp" ?∘) ("\\integral" ?∫)
   ("\\fun" ?λ)

   ; Sets of numbers
   ("\\nat" ?ℕ) ("\\N" ?ℕ) ("\\int" ?ℤ) ("\\Z" ?ℤ) ("\\rat" ?ℚ) ("\\Q" ?ℚ)
   ("\\real" ?ℝ) ("\\R" ?ℝ) ("\\complex" ?ℂ) ("\\C" ?ℂ) ("\\prime" ?ℙ)
   ("\\P" ?ℙ)

   ; Complexity
   ("\\bigo" ?𝒪)

   ; Greek
   ("\\Ga" ?α) ("\\GA" ?Α) ("\\a" ?α)
   ("\\Gb" ?β) ("\\GB" ?Β) ("\\b" ?β)
   ("\\Gg" ?γ) ("\\GG" ?Γ) ("\\g" ?γ) ("\\Gamma" ?Γ)
   ("\\Gd" ?δ) ("\\GD" ?Δ) ("\\delta" ?δ) ("\\Delta" ?Δ)
   ("\\Ge" ?ε) ("\\GE" ?Ε) ("\\epsilon" ?ε)
   ("\\Gz" ?ζ) ("\\GZ" ?Ζ)
   ("\\Gh" ?η) ("\\Gh" ?Η) ("\\mu" ?μ)
   ("\\Gth" ?θ) ("\\GTH" ?Θ) ("\\theta" ?θ) ("\\Theta" ?Θ)
   ("\\Gi" ?ι) ("\\GI" ?Ι) ("\\iota" ?ι)
   ("\\Gk" ?κ) ("\\GK" ?Κ)
   ("\\Gl" ?λ) ("\\GL" ?Λ) ("\\lam" ?λ)
   ("\\Gm" ?μ) ("\\GM" Μ) ("\\mu" ?μ)
   ("\\Gx" ?ξ) ("\\GX" ?Ξ) ("\\xi" ?ξ) ("\\Xi" ?Ξ)
   ("\\Gp" ?π) ("\\GP" ?Π) ("\\pi" ?π) ("\\Pi" ?Π)
   ("\\Gr" ?ρ) ("\\GR" ?Ρ) ("\\rho" ?ρ)
   ("\\Gs" ?σ) ("\\GS" ?Σ) ("\\sig" ?σ) ("\\Sig" ?Σ)
   ("\\Gt" ?τ) ("\\GT" ?Τ) ("\\tau" ?τ)
   ("\\Gph" ?ϕ) ("\\GPH" ?Φ) ("\\phi" ?ϕ) ("\\Phi" ?Φ)
   ("\\Gc" ?χ) ("\\GC" ?Χ) ("\\chi" ?χ)
   ("\\Gp" ?ψ) ("\\GP" ?Ψ) ("\\psi" ?ψ)
   ("\\Go" ?ω) ("\\GO" ?Ω) ("\\omega" ?ω) ("\\Omega" ?Ω)
  )
  (mapc (lambda (x)
          (if (cddr x)
              (quail-defrule (cadr x) (car (cddr x)))))
        (append math-symbol-list-superscripts
                math-symbol-list-subscripts)))

(use-package pdf-tools
  :straight t
  :config
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward-regexp))

;; load necessary things, when a PDF gets opened
(pdf-tools-install)
