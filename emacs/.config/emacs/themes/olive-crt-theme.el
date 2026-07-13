;;; olive-crt-theme.el --- Olive CRT dark theme for Emacs -*- lexical-binding: t -*-

;; Commentary:
;; Port of the Neovim olive-crt colorscheme (dark variant).

;;; Code:

(require 'my-theme-common)

(deftheme olive-crt
  "Olive CRT dark theme, ported from the Neovim colorscheme.
A dark green-tinted CRT-inspired theme.")

(my-theme-set-faces
 'olive-crt
 '((bg . "#171a15")
   (fg . "#fbfcf6")
   (bg-alt . "#232720")
   (fg-alt . "#99a293")
   (comment . "#99a293")
   (keyword . "#bccd80")
   (string . "#a5d6cb")
   (function . "#fbfcf6")
   (type . "#dac3ed")
   (constant . "#f7c775")
   (variable . "#fbfcf6")
   (builtin . "#90dde4")
   (warning . "#f7c775")
   (error . "#ea938b")
   (info . "#90dde4")
   (success . "#bccd80")
   (modeline-bg . "#20241d")
   (modeline-fg . "#fbfcf6")
   (region . "#363c34")
   (cursor . "#fbfcf7")
   (line-number . "#99a293")
   (line-number-current . "#fbfcf6")
   (diff-added . "#2d4227")
   (diff-removed . "#653633")
   (diff-changed . "#564d30")
   (border . "#858d80")))

(provide-theme 'olive-crt)
;;; olive-crt-theme.el ends here
