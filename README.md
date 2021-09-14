# PoE Launcher
# Version: 1.0.2

Launcher was born because I got tired of manually setting the process priority of Path of Exile, so I descided to automate that task with a script.
Launcher will automate some startup tasks that can be configured & controlled via the system tray icon (see below). 

Menu Functionality
- Click for a popup that will ask to close the launched program windows
- CLick to Tweak the Window Resolution (Hotkey: F10)
- QuickLink menu for related shortcut/tools
- Set Process Level: AboveNormal, Normal, BelowNormal

Settings Menu Options: 
- AutoLoad the target program on Startup (checked=on, unchecked=off)
- AutoClose the target program on Exit (checked=on, unchecked=off)
- AutoSet Process Level on Startup of the target program on Startup (checked=on, unchecked=off)
- AutoTweak the target program window on Startup (checked=on, unchecked=off)

By default everything is turned off, so you need to edit the config.ini or run the app once and configure the settings then restart it.
If you click on a menu item, it will trigger the action and save any potential settings 
If a menu item is checked/bold that means it is on/active other wise it is off/disabled.

Other settings exist and are detailed breafly in config.ini, edit carefully


## [Unreleased]
### Change: 
* the quickLinks array and function GetQuickLinksArray handles the array objects more as a proper array instead of a psuedo array now.
### Added: 
* added checks to see if the quicklinks array is not empty before taking some actions
### Added:
* System tray Notifications, and config.ini key to turn them on|off
### Note:
* Only known bug/oddity is with the tweakwindow function, it can fail after launch if this happens increase loadDelay to loadDelay=3500 or higher
### Note: 
* look for more typos/inconsistancies/oddities/bugs

## [1.0.2] - 2021-9-10
### Changed: 
- the logic in Launch and menu area's that use the Run Command, added checks for file/shortcut path area's
### Added: 
- StrReplace to the Launch function to swap / for \ in file path's just incase it's needed
### Change:
- Launch, SetProcessLevel and Close methods they now work with multiple instances of POE
### Change:
- menu text for the Launcher menu item is now able to Launch the program onclick
### Added: 
- Close function which has a popup to ask if you want to close the active window or not.
### Added: 
- QuinkLinks Menu now has the relevant icon for the program next to the program text.
### Change: 
- GetQuickLinksArray now works with multiple file extentions, currently *.exe, *.lnk, *.url files are parsed
### Added: 
- Menu Icons next to Launcher
### Removed: 
- pTitle from the config file and code, it was made redundant by windowClass
### Added: 
- windowClass="POEWindowClass" to the config, this should make the code agnostic of any particular game change though you need to know how to get a new windowclass value
### Added:
- launcherTitle="PoE" to the config, this should(?) make the code program agnostic just alter the config.ini to run other programs/games
### Added: 
-  loadDelay=2000 to the config, this is used in Launch's run sleep value to give the new window time to load a bit
### Bugfix: 
- Launch was not getting a pID value from the run command, adjusted logic hopefully this and adjusting the loadDelay can fix most issues with TweakWindow()
### Bugfix: 
- Quicklinks was not able to add icons for urls, it now does and uses FileURL.ico from the programs folder, if you want to use a different ico file feel free.
### Change: 
- TweakWindow(hWnd,tweakLimit=0), tweakLimit=0 -> Can trigger the tweak or undo it, this is used for toggling, TweakLimit=1 -> Will only apply the tweak not remove it
### Bugfix: 
- The TweakWindow change above should stop odd situations where tweakwindow will target the wrong window and remove the tweak.
### Change:
- Changed LoadPoE() to Launch() everywhere even in this changelog

## [1.0.1] - 2021-9-3
### Changed: 
- Moved Set Process Level menu's

### Added:
- Added functionality for a Qucklinks folder menu items, just create the folder and throw shortcuts(only) to programs into it.
- Set Process Level menu items now highlight to which ever one is active 

## [1.0.0] - 2021-8-28
### Added
- Initial v1.0 release
