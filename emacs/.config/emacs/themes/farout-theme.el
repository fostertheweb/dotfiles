;;; farout-theme.el --- Farout theme for Emacs -*- lexical-binding: t -*-

;; Commentary:
;; Port of the Neovim farout colorscheme (default/night variant).

;;; Code:

(require 'my-theme-common)

(deftheme farout
  "Farout theme, ported from the Neovim colorscheme.
A dark, earthy theme with orange/brown accents.")

(my-theme-set-faces
 'farout
 '((bg . "#0f0908")
   (fg . "#E0CCAE")
   (bg-alt . "#241816")
   (fg-alt . "#A67458")
   (comment . "#6B4035")
   (keyword . "#a67458")
   (string . "#a4896f")
   (function . "#d47d49")
   (type . "#BF472C")
   (constant . "#f49d69")
   (variable . "#E0CCAE")
   (builtin . "#a67458")
   (warning . "#f2a766")
   (error . "#bf472c")
   (info . "#a67458")
   (success . "#a4896f")
   (modeline-bg . "#1f1311")
   (modeline-fg . "#E0CCAE")
   (region . "#241816")
   (cursor . "#E0CCAE")
   (line-number . "#6B4035")
   (line-number-current . "#E0CCAE")
   (diff-added . "#A4895C")
   (diff-removed . "#BF472C")
   (diff-changed . "#66292F")
   (border . "#392D2B")))

(provide-theme 'farout)
;;; farout-theme.el ends here
