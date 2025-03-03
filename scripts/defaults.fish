#!/usr/bin/env fish

# Save screenshots to specific directory
mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"

# Dock
defaults write com.apple.dock autohide-delay -int 0
defaults write com.apple.dock autohide-time-modifier -float 0.2
defaults write com.apple.dock autohide -bool true
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock showhidden -bool true

# Move windows by dragging any part of the window
defaults write -g NSWindowShouldDragOnGesture -bool true

# Keyboard
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
defaults write com.apple.HIToolbox AppleFnUsageType -int "2" # emoji

# Show scrollbars when scrolling
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Finder
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool false
defaults write com.apple.finder ShowSidebar -bool false
defaults write com.apple.finder ShowToolbar -bool false
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "2"

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

defaults write com.apple.menuextra.clock "DateFormat" -string "\"HH:mm:ss\""

# Use scroll gesture with the Ctrl (^) modifier key to zoom
sudo defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
sudo defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# Follow the keyboard focus while zoomed in
sudo defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true
