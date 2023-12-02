#!/bin/sh

if [[ "$MAC_PREF" -eq 1 ]]; then
    echo "Configuring MacOS preferences"

    # Close any open System Preferences panes, to prevent them from overriding
    # settings we’re about to change
    osascript -e 'tell application "System Preferences" to quit'

    # Use dark menu bar and dock.
    defaults write NSGlobalDomain AppleInterfaceStyle Dark  

    # Increase sound quality for Bluetooth headphones/headsets
    defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

    # hide spotlight icon on menubar
    defaults write com.apple.Spotlight "NSStatusItem Visible Item-0" -bool false

    # Don't play sounds for UI actions
    defaults write com.apple.systemsound "com.apple.sound.uiaudio.enabled" -int 0

    # Stop iTunes from responding to the keyboard media keys
    launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

    # Get time from network server
    sudo systemsetup -setusingnetworktime on

    # control centre icons
    defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool false
    defaults write com.apple.controlcenter "NSStatusItem Visible Sound" -bool true
    defaults write com.apple.controlcenter "NSStatusItem Preferred Position Battery" -float 174
    defaults write com.apple.controlcenter "NSStatusItem Preferred Position BentoBox" -float 140
    defaults write com.apple.controlcenter "NSStatusItem Preferred Position WiFi" -float 216

    # Do not autogather large files when submitting a report
    defaults write com.apple.appleseed.FeedbackAssistant "Autogather" -bool "false"

    # Restart automatically if the computer freezes
    sudo systemsetup -setrestartfreeze on

    # Disable machine sleep while charging
    sudo pmset -c sleep 0

    # Expand save panel by default
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

    # Expand print panel by default
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

    # Automatically quit printer app once the print jobs complete
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

    # Enable Subpixel Anti-Aliasing (Font Smoothing)
    defaults write -g CGFontRenderingFontSmoothingDisabled -bool false

    # enable tabbing through dialogs
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

    # enable startup chime
    sudo nvram StartupMute=%00

    # immediately ask for password once screen saver starts
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0

    # set time on menu bar
    sudo defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM HH:mm"

    # disable dashboard
    defaults write com.apple.dashboard mcx-disabled -boolean TRUE

    # display to sleep after 15 minutes of no activity
    sudo pmset displaysleep 15

    # chime when charger is connected
    defaults write com.apple.PowerChime ChimeOnNoHardware -bool true
    open /System/Library/CoreServices/PowerChime.app &

    # Disable Photos.app from starting everytime a device is plugged in
    defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

    ###############################################################################
    # Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
    ###############################################################################

    # Turn off keyboard illumination when computer is not used for 2 minutes
    defaults write com.apple.BezelServices kDimTime -int 120

    # Setting trackpad & mouse speed to a reasonable number
    defaults write -g com.apple.trackpad.scaling 2
    defaults write -g com.apple.mouse.scaling 2.5

    # Trackpad: Haptic feedback (light, silent clicking)
    defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
    defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -int 0
    defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

    # Trackpad: map bottom right corner to right-click (requires restart!)
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
    defaults write NSGlobalDomain ContextMenuGesture -int 1

    # Enable press-and-hold for keys instead of key repeat
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool true

    # Set a blazingly fast keyboard repeat rate, and make it happen more quickly.
    # (The KeyRepeat option requires logging out and back in to take effect.)
    defaults write NSGlobalDomain InitialKeyRepeat -int 20
    defaults write NSGlobalDomain KeyRepeat -int 1
    defaults write com.apple.Accessibility KeyRepeatDelay -float 0.3
    defaults write com.apple.Accessibility KeyRepeatInterval -float 0.016

    # Disable auto-correct
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

    ###############################################################################
    # Screen                                                                      #
    ###############################################################################

    # Save screenshots to Downloads folder.
    defaults write com.apple.screencapture location -string "${HOME}/Downloads"

    # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
    defaults write com.apple.screencapture type -string "png"

    # Disable shadow in screenshots
    defaults write com.apple.screencapture disable-shadow -bool true

    ###############################################################################
    # Finder                                                                      #
    ###############################################################################

    # Set Desktop as the default location for new Finder windows
    # For other paths, use `PfLo` and `file:///full/path/here/`
    defaults write com.apple.finder NewWindowTarget -string "PfLo"
    defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

    # Show icons for hard drives, servers, and removable media on the desktop
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

    # Finder: disable window animations and Get Info animations
    defaults write com.apple.finder DisableAllAnimations -bool true

    # Finder: show hidden files by default
    defaults write com.apple.finder AppleShowAllFiles -bool false

    # Finder: show all filename extensions
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    # Finder: show status bar
    defaults write com.apple.finder ShowStatusBar -bool true
    defaults write com.apple.finder ShowSideBar -bool true
    defaults write com.apple.finder SidebarDevicesSectionDisclosedState -bool true
    defaults write com.apple.finder SidebarPlacesSectionDisclosedState -bool true
    defaults write com.apple.finder SidebarShowingSignedIntoiCloud -bool true
    defaults write com.apple.finder SidebarShowingiCloudDesktop -bool true
    defaults write com.apple.finder SidebariCloudDriveSectionDisclosedState -bool true

    # Finder: show path bar
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder ShowRecentTags -bool false

    # show scroll bar when scrolling
    defaults write -g AppleShowScrollBars -string "WhenScrolling"

    # Finder: allow text selection in Quick Look
    defaults write com.apple.finder QLEnableTextSelection -bool true

    # Keep folders on top when sorting by name
    defaults write com.apple.finder _FXSortFoldersFirst -bool true

    # Display full POSIX path as Finder window title
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

    # When performing a search, search the current folder by default
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

    # Disable the warning when changing a file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

    # Enable spring loading for directories
    defaults write NSGlobalDomain com.apple.springing.enabled -bool true

    # Remove the spring loading delay for directories
    defaults write NSGlobalDomain com.apple.springing.delay -float 0.1

    # Avoid creating .DS_Store files on network volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

    # Enable snap-to-grid for icons on the desktop and in other icon views
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

    # Show item info near icons on the desktop and in other icon views? (y/n)
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

    # Set the size of icons on the desktop and in other icon views
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist

    # Use column view in all Finder windows by default
    # Four-letter codes for the other view modes: `icnv`, `Nlsv`, `clmv`, `Flwv`
    defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
    defaults write com.apple.finder FXRemoveOldTrashItems -bool true

    ###############################################################################
    # Dock, Dashboard, and hot corners                                            #
    ###############################################################################

    # System Preferences > Dock > Minimize windows into application icon
    defaults write com.apple.dock minimize-to-application -bool true

    # Change minimize/maximize window effect
    defaults write com.apple.dock mineffect -string "scale"

    # Enable spring loading for all Dock items
    defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

    # don't show notifications when a new song starts playing
    defaults write com.apple.Music "userWantsPlaybackNotifications" -bool "false" && killall Music

    # Show indicator lights for open applications in the Dock
    defaults write com.apple.dock show-process-indicators -bool true

    # Enable highlight hover effect for the grid view of a stack (Dock)
    defaults write com.apple.dock mouse-over-hilite-stack -bool true

    # bounce icons on dock when attention needed
    defaults write com.apple.dock no-bouncing -bool false

    # lock dock size
    defaults write com.apple.Dock size-immutable -bool true

    # Auto hide dock
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock expose-group-apps -bool true

    # Remove the auto-hiding Dock delay
    defaults write com.apple.dock autohide-delay -float 0

    # Remove the animation when hiding/showing the Dock
    defaults write com.apple.dock autohide-time-modifier -float 0

    # Don’t show recent applications in Dock
    defaults write com.apple.dock show-recents -bool false

    # Set the icon size of Dock items
    defaults write com.apple.dock tilesize -int 30
    defaults write com.apple.dock largesize -float 89
    defaults write com.apple.dock magnification -bool true


    # Speed up Mission Control animations
    defaults write com.apple.dock expose-animation-duration -float 0.15
    defaults write com.apple.dock expose-group-by-app -bool true

    # window manager
    defaults write com.apple.WindowManager AppWindowGroupingBehavior -int 1
    defaults write com.apple.WindowManager AutoHide -bool true
    defaults write com.apple.WindowManager HideDesktop -bool true
    defaults write com.apple.WindowManager StageManagerHideWidgets -bool true
    defaults write com.apple.WindowManager StandardHideWidgets -bool false

    # show airplay in menu bar if present
    defaults write com.apple.airplay showInMenuBarIfPresent -bool true

    # Make Dock icons of hidden applications translucent
    defaults write com.apple.dock showhidden -bool true

    # Hot corners
    # Possible values:
    #  0: no-op
    #  2: Mission Control
    #  3: Show application windows
    #  4: Desktop
    #  5: Start screen saver
    #  6: Disable screen saver
    #  7: Dashboard
    # 10: Put display to sleep
    # 11: Launchpad
    # 12: Notification Center

    # Bottom right screen corner → Show Desktop
    defaults write com.apple.dock wvous-br-corner -int 4
    defaults write com.apple.dock wvous-br-modifier -int 0
    # Top right screen corner → Nothing
    defaults write com.apple.dock wvous-tr-corner -int 0
    defaults write com.apple.dock wvous-tr-modifier -int 0
    # Top left screen corner → Mission Control
    defaults write com.apple.dock wvous-tl-corner -int 2
    defaults write com.apple.dock wvous-tl-modifier -int 0
    # Bottom left screen corner → Start Screensaver
    defaults write com.apple.dock wvous-bl-corner -int 5
    defaults write com.apple.dock wvous-bl-modifier -int 0

    ###############################################################################
    # Safari & WebKit                                                             #
    ###############################################################################

    # Making Safari's search banners default to Contains instead of Starts With
    defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

    # Removing useless icons from Safari's bookmarks bar
    defaults write com.apple.Safari ProxiesInBookmarksBar "()"

    # Enable the Develop menu and the Web Inspector in Safari
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
    defaults write com.apple.Safari IncludeDevelopMenu -bool true
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
    defaults write -g WebKitDeveloperExtras -bool true

    # Add a context menu item for showing the Web Inspector in web views
    defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

    ###############################################################################
    # Spotlight                                                                   #
    ###############################################################################

    # Disable Spotlight indexing for any volume that gets mounted and has not yet
    # been indexed before.
    # Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
    sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

    ###############################################################################
    # Activity Monitor                                                            #
    ###############################################################################

    # Show the main window when launching Activity Monitor
    defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

    # Show all processes in Activity Monitor
    defaults write com.apple.ActivityMonitor ShowCategory -int 0

    ###############################################################################
    # App Store                                                                   #
    ###############################################################################

    # Disable in-app rating requests from apps downloaded from the App Store.
    defaults write com.apple.appstore InAppReviewEnabled -int 0

    ###############################################################################
    # TextEdit                                                                    #
    ###############################################################################

    # Create an Untitled Document at Launch
    defaults write com.apple.TextEdit NSShowAppCentricOpenPanelInsteadOfUntitledFile -bool false

    # Use Plain Text Mode as Default
    defaults write com.apple.TextEdit "RichText" -bool "false"

    ###############################################################################
    # Time Machine                                                                #
    ###############################################################################

    # Prevent Time Machine from prompting to use new hard drives as backup volume
    defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

    # Disable
    sudo tmutil disable

    ###############################################################################
    # Terminal
    ###############################################################################

    # Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default
    defaults write com.apple.terminal StringEncodings -array 4
    defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
    defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

fi
