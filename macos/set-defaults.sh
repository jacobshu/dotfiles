# Sets reasonable macOS defaults.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# Run ./set-defaults.sh and you'll be good to go.

# Switch to dark mode
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to 1'

# Set clock format
defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE d MMM HH:mm:ss\"" 

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Always open everything in Finder's column view.
defaults write com.apple.Finder FXPreferredViewStyle clmv

# Show the ~/Library folder.
chflags nohidden ~/Library

# Show hidden files.
defaults write com.apple.finder AppleShowAllFiles true

# Set a really fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 1

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show file extensions
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# Finder: sort by type, folder then file
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop" -bool "true"

# Finder: clear old items in trash
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true"

# Finder: disable warning for file extension changes
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"


# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Hide recent apps from Dock
defaults write com.apple.dock show-recents -bool false

# Disable screenshot shadows
defaults write com.apple.screencapture disable-shadow -bool true

# Create and set screenshot location
mkdir -p ~/Desktop/screenshots
defaults write com.apple.screencapture location ~/Desktop/screenshots

# Run the screensaver if we're in the bottom-left hot corner.
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Hide Safari's bookmark bar.
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Set up Safari for development.
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true 
killall Finder
