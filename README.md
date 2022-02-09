#  PoE Launcher
*  Version: 1.0.3a
*  [Download](https://github.com/jameslmoss/PoE-Launcher/releases/latest "Download") the latest version

PoE Launcher is similar to a program shortcut but with extra abilities.
PoE Launcher can automate launching, closing and tweaking the client program window. 
It also can load links to files from a QuickLinks folder into a menu for easy access to often used tools. 

## Menu Functionality
- Launch a target Program: Launch PoE
- Click for a popup that will ask to close the launched program windows
- Click to Tweak the Window Resolution (Hotkey: F10)
- QuickLink menu for related shortcut/tools
    - You can add *.exe, *.lnk, *.ahk, *url, files into the Quicklinks folder
    - If the Quicklinks folder is empty or doesn't exist it won't be included in the menu's.
- Set Process Level: AboveNormal, Normal, BelowNormal

## Settings Menu Options: 
- AutoLoad the target program on Startup (checked=on, unchecked=off)
- AutoClose the target program on Exit (checked=on, unchecked=off)
- AutoSet the target program process level on Startup (checked=on, unchecked=off)
- AutoTweak the target program window on Startup (checked=on, unchecked=off)

## Hidden features and Hotkeys:
- The left win key is diabled while the launched process is the active window
- F10 will trigger the TweakWindow function

## Other settings exist and are detailed briefly in config.ini, edit carefully
- launcherTitle=PoE
    - the text shown of what is being launched "**Launch PoE**" for example.
- processMax=1
    - is the number of client processes allowed, default is 1 but this can be any value.
        - Path of Exile allows 2 max client processes
- loadDelay=3500
    - is the delay after runing the client before attempting to do other actions such as "TweakWindow"
        - if TweakWindow on start is not working properly adjust this value (usually increase it).
- Both tweakWindowWidth=1920 and tweakWindowHeight=1030 can be edited/saved and the new values be used in the TweakWindow() functionality.

By default everything is turned off if you run the app and click on a menu item, it will trigger the action and save any potential settings. If a menu item is checked/bold that means it is on/active other wise it is off/disabled.

The code is mostly not tied to just 'path of exile' so if you'd like to try it for other games that should work fine. 
I would just use other icons and a unique program name/title. 
To try it copy the folder/files replace the icons as needed, and edit config.ini. 
You'll need to edit the paths and will require a program like [**winspy**](http://www.catch22.net/software/winspy) to help you find the **windowTitle** and **windowClass** values.

## PoE Launcher Menu, QuickLinks
![PoE Launcher Menu, QuickLinks](https://i.imgur.com/i1xarZw.png "PoE Launcher Menu, QuickLinks")

## PoE Launcher Menu, Set Process Level
![PoE Launcher Menu, Set Process Level](https://i.imgur.com/SZvFB0S.png "PoE Launcher Menu, Set Process Level")

## PoE Launcher Menu, Settings
![PoE Launcher Menu, Settings](https://i.imgur.com/LGMXBss.png "PoE Launcher Menu, Settings")

## Watch a video walk through on youtube
[![Watch on youtube](https://img.youtube.com/vi/7bmw5uZb50o/maxresdefault.jpg "Watch on youtube")](https://youtu.be/7bmw5uZb50oA "Watch on youtube")

## Credits:
- [Path of Exile](https://www.pathofexile.com)
    - The Game itself
- [AutoHotkey](https://www.autohotkey.com)
    - PoE Launcher was created with autohotkey
- [TriPolarBear](https://www.youtube.com/watch?v=p1BLjmfC6e0)
    - He showcased the HD Resolution autohotkey macro on his youtube channel that I cleaned up and adapted for the tweakwindow function.
- [@denolfe](https://github.com/denolfe)
    - Using his version of [Notify.ahk](https://github.com/denolfe/AutoHotkey/blob/master/lib/Notify.ahk)