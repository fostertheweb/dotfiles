;;; init.el --- Emacs configuration -*- lexical-binding: t -*-

;;; Commentary:

;; A novice Emacs user.

;;; Code:

;; Performance tweaks for modern machines
(setq gc-cons-threshold 100000000) ; 100 mb
(setq read-process-output-max (* 1024 1024)) ; 1mb

;; Remove extra UI clutter by hiding the scrollbar, and toolbar.
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Set the font. Note: height = px * 100
(set-face-attribute 'default nil :font "Berkeley Mono" :height 130)

;; Unique buffer names
(require 'uniquify)

;; Automatically insert closing parens
(electric-pair-mode t)

;; Visualize matching parens
(show-paren-mode 1)

;; Automatically save your place in files
(save-place-mode t)

;; Save history in minibuffer to keep recent commands easily accessible
(savehist-mode t)

;; Keep track of open files
(recentf-mode t)

;; Keep files up-to-date when they change outside Emacs
(global-auto-revert-mode t)

;; Display line numbers only when in programming modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Bring in package utilities so we can install packages from the web.
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Unless we've already fetched (and cached) the package archives,
;; refresh them.
(unless package-archive-contents
  (package-refresh-contents))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package nerd-icons
  :ensure t)

(use-package spacious-padding
  :ensure t
  :init (spacious-padding-mode 1))

(use-package ef-themes
  :ensure t
  :config
  (ef-themes-select 'ef-symbiosis))

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((rust-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :config
  (setq lsp-headerline-breadcrumb-enable nil)
  :commands (lsp lsp-deferred))

(use-package lsp-ui :commands lsp-ui-mode)

(add-hook 'after-init-hook 'global-company-mode)

(use-package dap-mode)

(use-package which-key
    :config
    (which-key-mode))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package magit
  :ensure t
  :bind (("C-c g" . magit-status)))

(use-package markdown-mode
  :ensure t
  :hook ((markdown-mode . visual-line-mode)
         (markdown-mode . flyspell-mode))
  :init
  (setq markdown-command "multimarkdown"))

(use-package rust-mode
  :ensure t
  :bind (:map rust-mode-map
	      ("C-c C-r" . 'rust-run)
	      ("C-c C-c" . 'rust-compile)
	      ("C-c C-f" . 'rust-format-buffer)
	      ("C-c C-t" . 'rust-test))
  :hook (rust-mode . prettify-symbols-mode))

;; Separate file for saved customize options
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)

;;; init.el ends here

