### Notes:
- Only known bug/oddity is with the tweakwindow function, it can fail after launch if this happens increase loadDelay to loadDelay=3500 or higher
- look for more typos/inconsistancies/oddities/bugs

## [Unreleased]

## [1.0.3] - 2021-9-17
### Change:
- the quickLinks array and function GetQuickLinksArray handles the array objects more as a proper array instead of a psuedo array now.
### Added:
- added checks to see if the quicklinks array is not empty before taking some actions
### Added:
- System tray Notifications, and config.ini key to turn them on|off
### Changed:
- Updated to a different version of Notify.ahk from https://github.com/denolfe/AutoHotkey/blob/master/lib/Notify.ahk, it supports preset Styles that are handy
### Added:
- added Use Notifications menu, under the Settings menu. Clicking toggles the turning notifications on/off and shows a Checkmark if on

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
