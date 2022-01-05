(require 'org)
(find-file (concat user-emacs-directory "init.org"))
(org-babel-tangle)
(load-file (concat user-emacs-directory "init.el"))
