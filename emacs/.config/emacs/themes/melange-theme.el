;;; melange-theme.el --- Melange dark theme for Emacs -*- lexical-binding: t -*-

;; Commentary:
;; Port of the Neovim melange colorscheme (dark variant).

;;; Code:

(require 'my-theme-common)

(deftheme melange
  "Melange dark theme, ported from the Neovim colorscheme.")

(my-theme-set-faces
 'melange
 '((bg . "#292522")
   (fg . "#ECE1D7")
   (bg-alt . "#34302C")
   (fg-alt . "#867462")
   (comment . "#867462")
   (keyword . "#BD8183")
   (string . "#78997A")
   (function . "#7F91B2")
   (type . "#B380B0")
   (constant . "#E49B5D")
   (variable . "#ECE1D7")
   (builtin . "#7B9695")
   (warning . "#E49B5D")
   (error . "#D47766")
   (info . "#7B9695")
   (success . "#78997A")
   (modeline-bg . "#34302C")
   (modeline-fg . "#ECE1D7")
   (region . "#403A36")
   (cursor . "#ECE1D7")
   (line-number . "#867462")
   (line-number-current . "#ECE1D7")
   (diff-added . "#233524")
   (diff-removed . "#7D2A2F")
   (diff-changed . "#8B7449")
   (border . "#403A36")))

(provide-theme 'melange)
;;; melange-theme.el ends here
