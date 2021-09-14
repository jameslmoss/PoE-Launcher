; Title: Launcher.ahk
; Version: 1.0.2
; Site: https://www.jameslmoss.com/2021/08/28/poe-launcher/
; Credits: Autohotkey docs and other's mentioned in the code

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

