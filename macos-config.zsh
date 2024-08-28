#! /usr/bin/env zsh

# Add US and Swedish keyboard layout
defaults write NSGlobalDomain AppleLanguages -array "en-US" "sv-SE"

# Tap to click with trackpad
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

###########################################################
# Finder
#

# Set default folder
# defaults write com.apple.finder NewWindowTarget -string "PfDo" # Documents
# defaults write com.apple.finder NewWindowTarget -string "PfDe" # Desktop
defaults write com.apple.finder NewWindowTarget -string "PfHm" # Home dir

# show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Automatically empty bin after 30 days
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

############################################################
# Dock, Spaces, menubar
#

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

defaults write com.apple.menuextra.clock ShowSeconds -int 1

killall Dock
killall Finder
