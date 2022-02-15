(require 'org)
(find-file (concat (getenv "HOME") "/.dots/files/emacs/.emacs.d/init.org"))
(org-babel-tangle)
(load-file (concat (getenv "HOME") "/.dots/files/emacs/.emacs.d/init.el"))
