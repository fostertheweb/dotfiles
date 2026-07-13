;;; carvion-theme.el --- Carvion theme for Emacs -*- lexical-binding: t -*-

;; Commentary:
;; Port of the Neovim Carvion colorscheme.

;;; Code:

(require 'my-theme-common)

(deftheme carvion
  "Carvion theme, ported from the Neovim colorscheme.
A dark, low-contrast theme with muted grays and subtle accents.")

(my-theme-set-faces
 'carvion
 '((bg . "#101010")
   (fg . "#E0E0E0")
   (bg-alt . "#151515")
   (fg-alt . "#909090")
   (comment . "#555555")
   (keyword . "#A0A0A0")
   (string . "#8FD8A3")
   (function . "#C8C8C8")
   (type . "#A18BD1")
   (constant . "#6F8FB0")
   (variable . "#E0E0E0")
   (builtin . "#808080")
   (warning . "#D98C3A")
   (error . "#E05A47")
   (info . "#6F8FB0")
   (success . "#8FD8A3")
   (modeline-bg . "#171717")
   (modeline-fg . "#E0E0E0")
   (region . "#262626")
   (cursor . "#E0E0E0")
   (line-number . "#707070")
   (line-number-current . "#E0E0E0")
   (diff-added . "#8FD8A3")
   (diff-removed . "#E05A47")
   (diff-changed . "#6F8FB0")
   (border . "#242424")))

(provide-theme 'carvion)
;;; carvion-theme.el ends here
