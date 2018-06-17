(setq inhibit-startup-message t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package better-defaults
  :ensure t)

;; Org-mode
(use-package org
  :mode (("\\.org$" . org-mode))
  :ensure org-plus-contrib
  :config
  (progn
    (setq org-latex-pdf-process '("latexmk -pdf -f %f"))
    (setq org-todo-keywords
          '((sequence "TODO" " "WAITING" "|" "DONE" "CANCELED")))
    (setq org-agenda-files '("~/workspace/notes/todo.org"))
    (setq org-ref-bib-html "<h2 class='org-ref-bib-h2'>Bibliography</h2>")
    ))


(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(use-package color-theme
  :ensure t)
(use-package goose-theme
  :ensure t
  :config (load-theme 'goose t))

(put 'upcase-region 'disabled nil)
