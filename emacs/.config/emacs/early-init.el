;;; early-init.el --- Early initialization -*- lexical-binding: t -*-

;; Commentary:
;; Settings that must take effect before the package system initializes or the
;; first frame is created.

;;; Code:

;; Prevent package.el from initializing before init.el.  We handle package
;; initialization manually in init.el so we can control the archive list and
;; refresh timing.
(setq package-enable-at-startup nil)

;; UI tweaks for the initial frame.
(menu-bar-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-startup-screen t)
(setq-default left-fringe-width 4)

;; Disable tab bars.
(setq ns-use-native-tabs nil)
(tab-bar-mode -1)

;; Fonts: set before the first frame is created to avoid flicker.
(let ((mono-spaced-font "IosevkaTerm Nerd Font Mono")
      (proportionately-spaced-font "Sans"))
  (set-face-attribute 'default nil :family mono-spaced-font :height 160)
  (set-face-attribute 'fixed-pitch nil :family mono-spaced-font :height 1.0)
  (set-face-attribute 'variable-pitch nil :family proportionately-spaced-font :height 1.0))

;;; early-init.el ends here
