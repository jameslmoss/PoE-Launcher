#  PoE Launcher
*  Version: 1.0.3
*  [Download](https://github.com/jameslmoss/PoE-Launcher/releases/latest "Download") the latest version

PoE Launcher was born because I got tired of manually setting the process priority of Path of Exile to Above Normal. So I descided to automate that task with a [autohotkey](https://www.autohotkey.com) script.
PoE Launcher can automate launching, closing and tweaking the client window. 
It also can load links to files from a QuickLinks folder for easy access to often used tools. 

Menu Functionality
- Click for a popup that will ask to close the launched program windows
- Click to Tweak the Window Resolution (Hotkey: F10)
- QuickLink menu for related shortcut/tools
    - You can add *.lnk, *url, *.exe files into the Quicklinks folder
    - If the Quicklinks folder is empty or doesn't exist it won't be included in the menu's.
- Set Process Level: AboveNormal, Normal, BelowNormal

Settings Menu Options: 
- AutoLoad the target program on Startup (checked=on, unchecked=off)
- AutoClose the target program on Exit (checked=on, unchecked=off)
- AutoSet Process Level on Startup of the target program on Startup (checked=on, unchecked=off)
- AutoTweak the target program window on Startup (checked=on, unchecked=off)

By default everything is turned off, so you need to edit the config.ini or run the app once and configure the settings then restart it.
If you click on a menu item, it will trigger the action and save any potential settings 
If a menu item is checked/bold that means it is on/active other wise it is off/disabled.

Other settings exist and are detailed briefly in config.ini, edit carefully

The code is mostly not tied to just 'path of exile' so if you'd like to try it for other games that should work fine. I would just use other icons and a unique program name/title. 
To try it copy the folder/files replace the icons as needed, and edit config.ini. 
You'll need to edit the paths and will require a program like [**winspy**](http://www.catch22.net/software/winspy) to help you find find the **windowTitle** and **windowClass** values.

## PoE Launcher Menu, QuickLinks
![Alt text](https://i.imgur.com/i1xarZw.png "TrayIcon Menu, QuickLinks")

## PoE Launcher Menu, Set Process Level
![Alt text](https://i.imgur.com/SZvFB0S.png "PoE Launcher Menu, Set Process Level")

## PoE Launcher Menu, Settings
![Alt text](https://i.imgur.com/LGMXBss.png "PoE Launcher Menu, Settings")

## Credits:
- [Path of Exile](https://www.pathofexile.com)
    - The Game itself
- [AutoHotkey](https://www.autohotkey.com)
    - PoE Launcher was created with autohotkey
- [TriPolarBear](https://www.youtube.com/watch?v=p1BLjmfC6e0)
    - He showcased the HD Resolution autohotkey macro on his youtube channel that I cleaned up and adapted for the tweakwindow function.
- [@denolfe](https://github.com/denolfe)
    - Using his version of [Notify.ahk]((https://github.com/denolfe/AutoHotkey/blob/master/lib/Notify.ahk))