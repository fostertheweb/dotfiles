;;; farout-moon-theme.el --- Farout Moon theme for Emacs -*- lexical-binding: t -*-

;; Commentary:
;; Port of the Neovim farout colorscheme (moon variant).

;;; Code:

(require 'my-theme-common)

(deftheme farout-moon
  "Farout Moon theme, ported from the Neovim colorscheme.")

(my-theme-set-faces
 'farout-moon
 '((bg . "#222436")
   (fg . "#c8d3f5")
   (bg-alt . "#2f334d")
   (fg-alt . "#737aa2")
   (comment . "#545c7e")
   (keyword . "#c099ff")
   (string . "#c3e88d")
   (function . "#82aaff")
   (type . "#ff757f")
   (constant . "#ff966c")
   (variable . "#c8d3f5")
   (builtin . "#86e1fc")
   (warning . "#ffc777")
   (error . "#ff757f")
   (info . "#86e1fc")
   (success . "#c3e88d")
   (modeline-bg . "#1e2030")
   (modeline-fg . "#c8d3f5")
   (region . "#2f334d")
   (cursor . "#c8d3f5")
   (line-number . "#737aa2")
   (line-number-current . "#c8d3f5")
   (diff-added . "#4a5740")
   (diff-removed . "#5a3a40")
   (diff-changed . "#3a4560")
   (border . "#444a73")))

(provide-theme 'farout-moon)
;;; farout-moon-theme.el ends here
