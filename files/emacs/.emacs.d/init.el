(require 'org)
(find-file (concat (getenv "HOME") "/dots/files/init.org"))
(org-babel-tangle)
(load-file (concat (getenv "HOME") "/dots/files/init.el"))
