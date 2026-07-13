;;; witchesbrew-theme.el --- Witchesbrew theme for Emacs -*- lexical-binding: t -*-

;; Commentary:
;; Port of the Neovim witchesbrew colorscheme.

;;; Code:

(require 'my-theme-common)

(deftheme witchesbrew
  "Witchesbrew theme, ported from the Neovim colorscheme.
A dark, moody purple/brown theme.")

(my-theme-set-faces
 'witchesbrew
 '((bg . "#11080d")
   (fg . "#e0ddd8")
   (bg-alt . "#1f151c")
   (fg-alt . "#7a7872")
   (comment . "#7a7872")
   (keyword . "#a68295")
   (string . "#94a681")
   (function . "#e0ddd8")
   (type . "#866399")
   (constant . "#d9956f")
   (variable . "#e0ddd8")
   (builtin . "#88b5aa")
   (warning . "#d9a95f")
   (error . "#c85d5d")
   (info . "#8194a6")
   (success . "#8eb574")
   (modeline-bg . "#1f151c")
   (modeline-fg . "#e0ddd8")
   (region . "#524a3c")
   (cursor . "#e0ddd8")
   (line-number . "#7a7872")
   (line-number-current . "#e0ddd8")
   (diff-added . "#5a7548")
   (diff-removed . "#8b4a4a")
   (diff-changed . "#4a3d4a")
   (border . "#524a3c")))

(provide-theme 'witchesbrew)
;;; witchesbrew-theme.el ends here
