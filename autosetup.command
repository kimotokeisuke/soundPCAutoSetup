#!/bin/sh

### Desktop & Screen Saver


# Desktopを黒に
# echo "Change Desctop Pictures"
# osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Library/Desktop Pictures/Solid Colors/Solid Gray Dark.png"'

# ScreenSaver Kill
echo "Disable screensaver"
defaults write com.apple.screensaver idleTime -int 0
defaults -currentHost write com.apple.screensaver idleTime -int 0


### Dock

echo "Set Dock to left hand side"
defaults write com.apple.dock orientation -string 'bottom'
killall dock

# # Dockの中身を SystemPreferences, Terminal, ActivityMonitor のみにする
# cd `dirname $0`
# sudo cp com.apple.dock.plist ~/Library/Preferences/com.apple.dock.plist
# killall Dock

#チームビュアーのインストール
echo "Install TeamViewer"
cd `dirname $0`
hdiutil mount TeamViewer.dmg
sudo installer -pkg /Volumes/TeamViewer/Install\ TeamViewer.pkg -target /
hdiutil detach /Volumes/TeamViewer

echo "Install Max7"
cd `dirname $0`
hdiutil mount Max735_180307.dmg
sudo cp -r /Volumes/Max7_180307_be88c5a/Max.app ~/Applications/Max.app
hdiutil detach /Volumes/Max7_170301_5d15e6b

#ドライバーのインストール
echo "Install RME Fireface USB Driver"
cd `dirname $0`
sudo installer -pkg FirefaceUSB.pkg -target /

### Mission Control

# Display作業スペース分割OFF
echo "Displays have separate Spaces"
defaults write com.apple.spaces spans-displays -bool FALSE


### Notifications

echo "Disable Notification center."
launchctl unload /System/Library/LaunchAgents/com.apple.notificationcenterui.plist


### Energy Saver

echo "Disable system sleep"
sudo pmset sleep 0

echo "Disable display sleep"
sudo pmset displaysleep 0

echo "Enable wake on ethernet"
sudo pmset womp 1



# 右クリックON
echo "Secondary click"
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string 'TwoButton'
defaults write com.apple.driver.AppleHIDMouse Button2 -int 2


# 自動ログイン
echo "Setup auto login."
sudo defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser $(whoami)


### App Store

# 自動更新OFF
echo "Disable : SystemPreferences -> AppStore -> Automatically check for updates"
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool FALSE

### utility

# Libraryフォルダ表示
echo "Show the ~/Library folder"
chflags nohidden ~/Library

# Dashboard無効化
echo "Disable dashboard"
defaults write com.apple.dashboard mcx-disabled -boolean YES

# network上に.DS_Store作らない
echo "Avoid creating .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

# 拡張子変更時のwarningを出さない
echo "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool FALSE

# 未承認のアプリも右クリックなく開ける
echo "Disable Warning on opening new App."
spctl --master-disable

# 起動時のクラッシュワーニングを出さない
echo "Disable crash working on application start."
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool FALSE

# ウィンドウ復元無効化
echo "Disable resume on start"
defaults write -g ApplePersistenceIgnoreState YES

# クラッシュレポーター出さない
echo "Disable crash reporter"
defaults write com.apple.CrashReporter DialogType none
defaults write com.apple.CrashReporter UseUNC 1

sudo reboot

