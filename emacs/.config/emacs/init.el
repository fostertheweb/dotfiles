(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(when (< emacs-major-version 29)
  (unless (package-installed-p 'use-package)
    (unless package-archive-contents
      (package-refresh-contents))
    (package-install 'use-package)))

(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))

;;; Basic behaviour

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

;; Those three belong in the early-init.el, but I am putting them here
;; for convenience.  If the early-init.el exists in the same directory
;; as the init.el, then Emacs will read+evaluate it before moving to
;; the init.el.
(menu-bar-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(global-display-line-numbers-mode t)
(setq inhibit-startup-screen t)

(let ((mono-spaced-font "IosevkaTerm Nerd Font Mono")
      (proportionately-spaced-font "Sans"))
  (set-face-attribute 'default nil :family mono-spaced-font :height 160)
  (set-face-attribute 'fixed-pitch nil :family mono-spaced-font :height 1.0)
  (set-face-attribute 'variable-pitch nil :family proportionately-spaced-font :height 1.0))

(use-package modus-themes
  :ensure t
  :config
  (load-theme 'modus-vivendi-tinted :no-confirm-loading))

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
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

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

(use-package avy
  :bind (("M-g w" . avy-goto-word-0))
  :config
  (setq avy-style 'at-full)
  (setq avy-background -1)
  (setq avy-keys '(?e ?t ?o ?v ?x ?q ?p ?d ?y ?g ?f ?b ?l ?z ?h ?c ?k ?i ?s ?u ?r ?a ?n)))

(custom-set-faces
 ;; The background of the text you aren't targeting (the dimming effect)
 '(avy-background-face
   ((t (:foreground "#666666" :slant italic)))) ; Use a muted grey/comment color

 ;; The first character of the jump hint (e.g., the 'A' in 'AS')
 '(avy-lead-face
   ((t (:foreground "#00dfff" :weight bold :underline nil))))

 ;; The subsequent characters of the jump hint (e.g., the 'S' in 'AS')
 '(avy-lead-face-0
   ((t (:foreground "#2b8db3" :weight bold :underline nil))))
 
 ;; Ensure avy doesn't draw an ugly box around the characters
 '(avy-lead-face-1
   ((t (:inherit avy-lead-face-0)))))

(use-package which-key
  :init (which-key-mode)
  :config (setq which-key-idle-delay 0.3))

(use-package copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("C-f" . copilot-accept-completion)))

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
           "--line-number --search-zip --hidden")))

(use-package vterm
    :ensure t
    :hook (vterm-mode . (lambda () (display-line-numbers-mode -1))))

(use-package crux
  :ensure t
  :bind (("S-C-o" . crux-smart-open-line-above)
         ("C-o" . crux-smart-open-line))) ; This opens a line below and indents

(use-package better-jumper
  :ensure t
  :init
  (better-jumper-mode +1)
  :bind
  ;; Bind to whatever keys you prefer (e.g., M-o and M-i to avoid overriding defaults)
  (("M-o" . better-jumper-jump-backward)
   ("M-i" . better-jumper-jump-forward)))
