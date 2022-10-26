(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)

(add-hook 'after-make-frame-functions
	  (lambda (f)
	    (set-face-attribute 'default nil
				:font "Iosevka 15"
				:weight 'medium)))
(set-face-attribute 'default nil
		    :font "Iosevka 15"
		    :weight 'medium)

(use-package doom-themes :straight t)
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
(load-theme 'doom-tokyo-night t)

;; Line Numbers
(column-number-mode)
(global-display-line-numbers-mode t)
(dolist(mode '(
	       org-mode-hook
	       term-mode-hook
	       vterm-mode-hook
	       shell-mode-hook
	       eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Mode Line
(use-package mood-line :straight t)
(mood-line-mode)

(setq inhibit-startup-message t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(set-fringe-mode 15)
(recentf-mode 1)
(setq use-dialog-box nil)
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)
;; GCMH
(straight-use-package 'gcmh)
(gcmh-mode)

;; Backup Dir
(setq backup-directory-alist
        `((".*" . ,temporary-file-directory)))

(use-package which-key :straight t)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(use-package general :straight t)
(general-create-definer jc/leader-keys
  :prefix "C-SPC")
(general-auto-unbind-keys)

(jc/leader-keys
  "ot" 'org-babel-tangle
  "mm" 'set-mark-command
  "mj" 'exchange-point-and-mark
  "nf" 'org-roam-node-find
  "ni" 'org-roam-node-insert)

(use-package org :straight t)
(require 'org-tempo)
(use-package org-modern :straight t)
(global-org-modern-mode)

(use-package sly :straight t)
(setq inferior-lisp-program "sbcl")
(add-hook 'lisp-mode 'prettify-symbols-mode)
(straight-use-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(use-package magit :straight t)

(dolist (mode '(
		zig-mode
		haskell-mode
		rust-mode
		go-mode))
  (straight-use-package mode))

;; Vertico
(use-package vertico :straight t)
(vertico-mode)

;; Marginalina
(use-package marginalia :straight t)
(marginalia-mode)

;; Orderless
(use-package orderless :straight t)
(setq completion-styles '(orderless basic))
(setq completion-category-overrides '((file (styles basic partial-completion))))

(use-package corfu
  :straight t
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.0)
  :init 
  (global-corfu-mode))

(setq org-babel-lisp-eval-fn #'sly-eval)
(org-babel-do-load-languages
 'org-babel-load-languages '((C . t)
			     (lisp . t)))

(use-package pdf-tools :straight t)
