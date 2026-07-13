;;; melange-light-theme.el --- Melange light theme for Emacs -*- lexical-binding: t -*-

;; Commentary:
;; Port of the Neovim melange colorscheme (light variant).

;;; Code:

(require 'my-theme-common)

(deftheme melange-light
  "Melange light theme, ported from the Neovim colorscheme.")

(my-theme-set-faces
 'melange-light
 '((bg . "#F1F1F1")
   (fg . "#54433A")
   (bg-alt . "#E9E1DB")
   (fg-alt . "#A98A78")
   (comment . "#A98A78")
   (keyword . "#C77B8B")
   (string . "#6E9B72")
   (function . "#7892BD")
   (type . "#BE79BB")
   (constant . "#BC5C00")
   (variable . "#54433A")
   (builtin . "#739797")
   (warning . "#BC5C00")
   (error . "#BF0021")
   (info . "#739797")
   (success . "#6E9B72")
   (modeline-bg . "#E9E1DB")
   (modeline-fg . "#54433A")
   (region . "#D9D3CE")
   (cursor . "#54433A")
   (line-number . "#A98A78")
   (line-number-current . "#54433A")
   (diff-added . "#D0E9D1")
   (diff-removed . "#F1DEDF")
   (diff-changed . "#CCA478")
   (border . "#D9D3CE")))

(provide-theme 'melange-light)
;;; melange-light-theme.el ends here
