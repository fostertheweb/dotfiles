;;; olive-crt-light-theme.el --- Olive CRT light theme for Emacs -*- lexical-binding: t -*-

;; Commentary:
;; Port of the Neovim olive-crt colorscheme (light variant).

;;; Code:

(require 'my-theme-common)

(deftheme olive-crt-light
  "Olive CRT light theme, ported from the Neovim colorscheme.")

(my-theme-set-faces
 'olive-crt-light
 '((bg . "#d7d9d3")
   (fg . "#282c26")
   (bg-alt . "#c9cec3")
   (fg-alt . "#9ea68f")
   (comment . "#9ea68f")
   (keyword . "#4f6718")
   (string . "#286257")
   (function . "#282c26")
   (type . "#72579f")
   (constant . "#985300")
   (variable . "#282c26")
   (builtin . "#116a92")
   (warning . "#985300")
   (error . "#88413c")
   (info . "#116a92")
   (success . "#4f6718")
   (modeline-bg . "#c3c9be")
   (modeline-fg . "#282c26")
   (region . "#b6bdae")
   (cursor . "#181b16")
   (line-number . "#9ea68f")
   (line-number-current . "#282c26")
   (diff-added . "#ccd7ba")
   (diff-removed . "#dfc4bc")
   (diff-changed . "#d5cfb8")
   (border . "#98a08f")))

(provide-theme 'olive-crt-light)
;;; olive-crt-light-theme.el ends here
