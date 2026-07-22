;;; init.el --- Emacs configuration -*- lexical-binding: t; no-byte-compile: t -*-

;;; Commentary:
;;; My personal Emacs configuration.

;;; Code:

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)
(require 'package)

;; Add MELPA before `package-initialize' so its contents are included in
;; `package-archive-contents'.  Otherwise packages from MELPA cannot be found.
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Initialize package system (automatic on Emacs 27+, harmless to call again).
(package-initialize)

;; Refresh archive contents if they are missing or don't include MELPA packages.
;; `package-archive-contents' can be non-nil from GNU ELPA only, so we check
;; for known MELPA packages to decide whether a refresh is needed.
(when (or (null package-archive-contents)
          (not (assoc 'apheleia package-archive-contents))
          (not (assoc 'consult package-archive-contents)))
  (package-refresh-contents))

;; Ensure `use-package' is available.  It is built-in from Emacs 29, but
;; older versions need it installed from MELPA.
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Make `use-package' install packages by default.  Built-in packages must
;; explicitly use `:ensure nil'.
(setq use-package-always-ensure t)

;; Load custom themes from the `themes' subdirectory.
(let ((themes-dir (locate-user-emacs-file "themes")))
  (add-to-list 'load-path themes-dir)
  (add-to-list 'custom-theme-load-path themes-dir))

(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))

(setq-default line-spacing 0.25)

;;; Basic behaviour

(setq-default tab-width 2
              standard-indent 2
              indent-tabs-mode nil)

(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

(defun prot/keyboard-quit-dwim ()
  "Do-What-I-Mean behaviour for a general `keyboard-quit'.

The generic `keyboard-quit' does not do the expected thing when
the minibuffer is open.  Whereas we want it to close the
minibuffer, even without explicitly focusing it.

The DWIM behaviour of this command is as follows:

- When the region is active, disable it.
- When a minibuffer is open, but not focused, close the minibuffer.
- When the Completions buffer is selected, close it.
- In every other case use the regular `keyboard-quit'."
  (interactive)
  (cond
   ((region-active-p)
    (keyboard-quit))
   ((derived-mode-p 'completion-list-mode)
    (delete-completion-window))
   ((> (minibuffer-depth) 0)
    (abort-recursive-edit))
   (t
    (keyboard-quit))))

(define-key global-map (kbd "C-g") #'prot/keyboard-quit-dwim)

;;; Tweak the looks of Emacs

(global-display-line-numbers-mode t)
(column-number-mode t)
(recentf-mode t)
(global-hl-line-mode 1)

(use-package south-theme
  :vc (:url "https://github.com/SophieBosio/south"
            :rev :newest
            :branch "main")
  :config (load-theme 'south t))

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

;;; Configure the minibuffer and completions

(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode))

(use-package marginalia
  :ensure t
  :hook (after-init . marginalia-mode))

(use-package orderless
  :ensure t
  :config
  (orderless-define-completion-style orderless-strict
    (orderless-matching-styles '(orderless-literal orderless-regexp)))

  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides
        '((consult-line (styles orderless-strict))))
  (setq orderless-matching-styles
        '(orderless-literal orderless-regexp orderless-flex)))

(use-package savehist
  :ensure nil ; it is built-in
  :hook (after-init . savehist-mode))

(use-package corfu
  :ensure t
  :hook (after-init . global-corfu-mode)
  :bind (:map corfu-map ("<tab>" . corfu-complete))
  :config
  (setq tab-always-indent 'complete)
  (setq corfu-preview-current nil)
  (setq corfu-min-width 20)

  (setq corfu-popupinfo-delay '(1.25 . 0.5))
  (corfu-popupinfo-mode 1) ; shows documentation after `corfu-popupinfo-delay'

  ;; Sort by input history (no need to modify `corfu-sort-function').
  (with-eval-after-load 'savehist
    (corfu-history-mode 1)
    (add-to-list 'savehist-additional-variables 'corfu-history)))

;;; The file manager (Dired)

(use-package dired
  :ensure nil
  :commands (dired)
  :hook
  ((dired-mode . dired-hide-details-mode)
   (dired-mode . hl-line-mode))
  :config
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-dwim-target t))

(use-package dired-subtree
  :ensure t
  :after dired
  :bind
  ( :map dired-mode-map
    ("<tab>" . dired-subtree-toggle)
    ("TAB" . dired-subtree-toggle)
    ("<backtab>" . dired-subtree-remove)
    ("S-TAB" . dired-subtree-remove))
  :config
  (setq dired-subtree-use-backgrounds nil))

(use-package trashed
  :ensure t
  :commands (trashed)
  :config
  (setq trashed-action-confirmer 'y-or-n-p)
  (setq trashed-use-header-line t)
  (setq trashed-sort-key '("Date deleted" . t))
  (setq trashed-date-format "%Y-%m-%d %H:%M:%S"))

(use-package which-key
  :init (which-key-mode)
  :config (setq which-key-idle-delay 0.3))

(use-package copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
	            ("C-f" . copilot-accept-completion))
  :config
  ;; Silence native-compiler warning about `project-root'.
  (require 'project))

(use-package consult
  :bind (("C-s"         . consult-line)
         ("C-x b"       . consult-buffer)
         ("C-x 4 b"     . consult-buffer-other-window)
         ("C-x 5 b"     . consult-buffer-other-frame)
         ("C-x r b"     . consult-bookmark)
         ("C-x r m"     . bookmark-set)
         ("C-c g"       . consult-ripgrep)
         ("C-c o"       . consult-outline)
         ("C-c i"       . consult-imenu)
         ("C-c n"       . consult-flymake)
         ("C-x C-r"     . consult-recent-file)
         ("M-y"         . consult-yank-pop)
         ("C-x C-x"     . consult-mark))
  :custom
  ;; Search hidden files but keep respecting .gitignore (fd/rg ignore VCS by default)
  (consult-ripgrep-args
   (concat "rg --null --line-buffered --color=never --max-columns=1000 "
           "--path-separator / --smart-case --no-heading --with-filename "
           "--line-number --search-zip --hidden"))
  :config
  (consult-customize consult-line :category 'consult-line))

(use-package embark
  :bind (("C-."   . embark-act)
         ("C-;"   . embark-dwim)
         ("C-h B" . embark-bindings))
  :init (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :after (embark consult)
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package diff-hl
  :hook (prog-mode . diff-hl-mode)
  :config
  (setq diff-hl-draw-borders nil)
  (diff-hl-dired-mode 1)
  (diff-hl-flydiff-mode 1)
  ;; Use the theme's diff faces for fringe/margin indicators.
  (set-face-attribute 'diff-hl-insert nil :inherit 'diff-added :background nil)
  (set-face-attribute 'diff-hl-delete nil :inherit 'diff-removed :background nil)
  (set-face-attribute 'diff-hl-change nil :inherit 'diff-changed :background nil))

(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

(use-package ghostel
  :bind (("C-x m" . ghostel)
         :map ghostel-semi-char-mode-map
         ("C-s"  . consult-line)
         ("C-k"  . my/ghostel-send-C-k-and-kill)
         ;; ;; I'm used to go up/down the shell history with M-n/p from eshell
         ;; ;; Simulate this behavior in ghostel by sending C-p and C-n
         ("M-p" . (lambda () (interactive) (ghostel-send-key "p" "ctrl")))
         ("M-n" . (lambda () (interactive) (ghostel-send-key "n" "ctrl")))
         :map project-prefix-map
         ("m" . ghostel-project)
         ("M" . ghostel-project-list-buffers))
  :config
  (defun my/disable-line-numbers-in-ghostel ()
    "Disable line numbers after entering `ghostel-mode'."
    (when (derived-mode-p 'ghostel-mode)
      (display-line-numbers-mode -1)))

  ;; Globalized minor modes run after major-mode hooks, so disable line
  ;; numbers from the later hook to prevent them from being re-enabled.
  (add-hook 'after-change-major-mode-hook
            #'my/disable-line-numbers-in-ghostel t)

  (defun my/ghostel-send-C-k-and-kill ()
    "Send `C-k' to ghostel.
Like normal Emacs `C-k'.  Kill to end of line and put content in kill-ring."
    (interactive)
    (kill-ring-save (point) (line-end-position))
    (ghostel-send-key "k" "ctrl"))

  (add-to-list 'project-switch-commands '(ghostel-project "Ghostel") t)
  (add-to-list 'project-switch-commands '(ghostel-project-list-buffers "Ghostel buffers") t)
  (add-to-list 'ghostel-eval-cmds '("magit-status-setup-buffer" magit-status-setup-buffer))

  ;; Download the Ghostel native module if it is missing.
  (unless (file-exists-p (expand-file-name
                          "ghostel-module.dylib"
                          (file-name-directory (locate-library "ghostel"))))
    (ghostel-download-module)))

;; vim-like behaviors
(use-package crux
  :ensure t
  :bind (("S-C-o" . crux-smart-open-line-above)
         ("C-o" . crux-smart-open-line))) ; This opens a line below and indents

(use-package avy
  :bind (("M-j" . avy-goto-char-timer))
  :config
  (setq avy-timeout-seconds 0.3)
  (setq avy-keys '(?e ?t ?o ?v ?x ?q ?p ?d ?y ?g ?f ?b ?l ?z ?h ?c ?k ?i ?s ?u ?r ?a ?n)))

;; LSP
(use-package lsp-mode
  :init (setq lsp-keymap-prefix "C-c l"
	            lsp-completion-provider :corfu
	            lsp-idle-delay 0.3
	            lsp-log-io nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  :hook ((prog-mode . lsp-deferred))
  :commands (lsp lsp-deferred)
  :config
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  (define-key lsp-mode-map (kbd "C-c r") #'lsp-rename)
  ;; (define-key lsp-mode-map (kbd "C-c d") #'lsp-find-definition)
  (define-key lsp-mode-map (kbd "C-c a") #'lsp-execute-code-action)
  (define-key lsp-mode-map (kbd "C-c f") #'lsp-format-buffer)
  (setq lsp-warn-no-matched-clients nil)
  (setq lsp-eslint-enable t))

(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config (setq lsp-ui-doc-enable t
                lsp-ui-sideline-enable t))

(use-package indent-guide
  :ensure t
  :hook (prog-mode . indent-guide-mode)
  :config
  (setq indent-guide-char "│"))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq-local lsp-disabled-clients '(elisp-ls))))
(add-hook 'emacs-lisp-mode-hook #'eldoc-mode)

(use-package apheleia
  :ensure t
  :hook ((prog-mode . apheleia-mode)))

(use-package flycheck
  :ensure t
  :config
  (with-eval-after-load 'lsp-mode
    (setq lsp-diagnostics-provider :flycheck))
  :hook (prog-mode . (lambda ()
                       (when (buffer-file-name)
                         (flycheck-mode)))))

;; Treesitter
(use-package treesit
  :ensure nil
  :config
  ;; Run once: M-x treesit-install-language-grammar
  ;; Install: css go html javascript json jsx lua markdown ruby rust tsx typescript
  )

(add-hook 'prog-mode-hook #'electric-pair-mode)

(use-package solaire-mode
  :ensure t
  :config
  (solaire-global-mode +1))

(use-package org
  :ensure t
  :bind
  ;; Global keybindings to access core Org features anywhere in Emacs
  (("C-c x" . org-store-link)
   ("C-c t" . org-agenda)
   ("C-c c" . org-capture))
  :config
  ;; Tell Org where to find your agenda files
  (setq org-agenda-files '("~/org/"))
  ;; Enable clean indentation mode visually
  (setq org-startup-indented t))

(provide 'init)
;;; init.el ends here
