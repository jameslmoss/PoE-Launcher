#NoEnv
#SingleInstance ignore
#Persistent
SetTitleMatchMode, 1

; These includes are loaded from the Lib folder
#Include <Notify>

SetWorkingDir, %A_ScriptDir%

; Config File
global INI_FILE := "config.ini"

; Default settings
; Show or hide notifications
global notifyShow := 0
IniRead, notifyShow, %INI_FILE%, Defaults, notifyShow, "0"	
; Abbreviated Title of the app being launched
global launcherTitle := "PoE"
IniRead, launcherTitle, %INI_FILE%, Defaults, launcherTitle, "PoE"
; Limit the number of times the process can run
global processMax := 0
IniRead, processMax, %INI_FILE%, Defaults, processMax, 0
; Delay to wait for the process to load
global loadDelay := 3500
IniRead, loadDelay, %INI_FILE%, Defaults, loadDelay, 3500
; Set to 1 to load POE when this program starts
global loadOnStart := 0
IniRead, loadOnStart, %INI_FILE%, Defaults, loadOnStart, 0
; Set to 1 to close when you click exit to close the program
global closeOnExit := 0
IniRead, closeOnExit, %INI_FILE%, Defaults, closeOnExit, 0
; Set to 1 to auto tweak the window when this program starts (play around with it see other settings)
global setResOnStart := 0
IniRead, setResOnStart, %INI_FILE%, Defaults, setResOnStart, 0
; Set to 1 to auto tweak the process level when the program starts, it will change it from normal to the value of defaultLevel 
global setLevelOnStart := 0
IniRead, setLevelOnStart, %INI_FILE%, Defaults, setLevelOnStart, 0
; Generally lave this alone, it's the same values from the details pain in your taskmanager if you click -> Set Priority on a program
global defaultLevel := "Normal"
IniRead, defaultLevel, %INI_FILE%, Defaults, defaultLevel, "Normal"


; Path and WindowClass settings
global programPath := "C:\Program Files (x86)\Grinding Gear Games\Path of Exile\"
IniRead, programPath, %INI_FILE%, Paths, programPath, "C:\Program Files (x86)\Grinding Gear Games\Path of Exile\"
global programFile := "PathOfExile_x64.exe"
IniRead, programFile, %INI_FILE%, Paths, programFile, "PathOfExile_x64.exe"
global windowTitle := "Path of Exile"
IniRead, windowTitle, %INI_FILE%, Paths, windowTitle, "Path of Exile"
global windowClass := "POEWindowClass"
IniRead, windowClass, %INI_FILE%, Paths, windowClass, "POEWindowClass"

; TweakWindow width and Height
global tweakWindowWidth := "1920"
global tweakWindowHeight := "1030"
GetWindowConfig()

; Internal variable
;global loadDelay := 3500 ; Play with this value
global hWndCount := 0
	
; Delete the standard tray menu items
Menu,Tray,NoStandard

global assetDir := A_ScriptDir . "\Assets\"

I_Icon = %assetDir%launcher.ico
ICON [I_Icon]
if I_Icon <>
IfExist, %I_Icon%
	Menu, Tray, Icon, %I_Icon%   ;Changes menu tray icon 
	
FileURL_Icon =  %assetDir%FileURL-3.ico
ICON [FileURL_Icon]
if FileURL_Icon <>

;Menu, Tray, Add, &Path of Exile, :Submenu1
Menu, Tray, Add, &Launch %launcherTitle%, TrayMenu
Menu, Tray, Icon, &Launch %launcherTitle%, %I_Icon%,,
Menu, Tray, Add
Menu, Tray, Add, &Close %launcherTitle%, TrayMenu
Menu, Tray, Add, &TweakWindow, TrayMenu

; Setup the Quicklinks Directory
global quicklinkDir := A_ScriptDir . "\QuickLinks\"
; Variable to know if the quick links directory exists or not
global hasQuickLinks := 0
; Set the above variable if the directory exists
IfExist, %quicklinkDir% 
	hasQuickLinks = 1
; If the quick links directory exists dive in
if(hasQuickLinks == 1){
	;MsgBox, Found: %quicklinkDir%
	; Quicklinks Array
	global quickLinks := Array()
	; Fill the QuickLinks Array
	global quickLinksCount := GetQuickLinksArray(quickLinks,quicklinkDir,"*.exe,*.lnk,*.ahk,*.url")
	if(quickLinks.Count() >= 1) {
		tmpFileOut := ""	
		tmpFileDir := ""
		tmpFileExt := ""			
		tmpFileOutnoExt := ""			
		tmpFileArgs := ""
		tmpFileDesc := ""
		tmpFileIcon := ""
		tmpFileIconNum := ""
		tmpFileState := ""		
		; Loop thru the QuickLinks array to add menu items
		for i, var in quickLinks {
			tmpFileDir := quicklinkDir . var
			
			; SplitPath, InputVar , OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
			SplitPath, var, tmpFileOut, , tmpFileExt, tmpFileOutnoExt,
		
			; Add Menu Items
			Menu, QuickLinksMenu, Add, %tmpFileOutnoExt%, TrayMenu		
		}
		; Add the QuickLinks Menu
		Menu, Tray, Add, &QuickLinks, :QuickLinksMenu
		Menu, Tray, Default, &QuickLinks			
	}

}

Menu, Tray, Add

; Create submenu items that will become menu items under &Set Process Level
;Menu, Submenu1, Add, High, TrayMenu
Menu, Submenu1, Add, Above Normal, TrayMenu
Menu, Submenu1, Add, Normal, TrayMenu
Menu, Submenu1, Add, Below Normal, TrayMenu

; Create a menu container for the submenu's above
Menu, Tray, Add, Set Process Level, :Submenu1
Menu, Tray, Default, Set Process Level

; Create submenu items that will become menu items under &Settings
Menu, Submenu2, Add, AutoLoad on Start, TrayMenu
Menu, Submenu2, Add, AutoClose on Exit, TrayMenu
Menu, Submenu2, Add, Set Process Level on Start, TrayMenu
Menu, Submenu2, Add, Tweak Window on Start, TrayMenu
Menu, Submenu2, Add, Use Notifications, TrayMenu
Menu, Submenu2, Add
; Create a menu container for the submenu's above
Menu, Tray, Add, &Settings, :Submenu2
Menu, Tray, Default, &Settings
	
Menu, Tray, Add
Menu, Tray, Add, E&xit, TrayMenu
Menu, Tray, Default, &Launch %launcherTitle%

GoSub OnStart
;OnExit("WriteConfig")
OnExit, ExitSub  
Return

ExitSub:
	WriteConfig()
ExitApp	

TrayMenu:
	if(hasQuickLinks == 1){
		if(quickLinksCount >= 1) {
			for i, var in quickLinks {
				zMenuItem := ""
				tmpFileFull := quickLinkDir . var
				;MsgBox, FileName: %tmpFileFull%
				if FileExist(tmpFileFull) {				
					tmpFileOut := ""
					tmpFileOut := ""	
					tmpFileDir := ""
					tmpFileExt := ""			
					tmpFileOutnoExt := ""			
					tmpFileArgs := ""
					tmpFileDesc := ""
					tmpFileIcon := ""
					tmpFileIconNum := ""
					tmpFileState := ""						
					; SplitPath, InputVar , OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
					SplitPath, tmpFileFull, tmpFileOut, tmpFileDir, tmpFileExt, zMenuItem,
					if(A_ThisMenuItem=zMenuItem){
						pID := ""
						;Run, Target , WorkingDir, Options, OutputVarPID
						Run, %tmpFileFull%,%tmpFileDir%,,pID
						break
					}				
				}
			}
		}
	}
	
	If (A_ThisMenuItem="&Launch " launcherTitle) {		
		Launch("ahk_class " windowClass)
	Return
	}
	
	If (A_ThisMenuItem="&TweakWindow") {
		if(notifyShow)
			Notify(launcherTitle " Launcher","Tweaking: " windowTitle, 1,"Style=Mine TS=12 MS=12")	
		GetWindowConfig()
		TweakWindow("ahk_class " windowClass)
		Return
	}
	
	If (A_ThisMenuItem="&Close " launcherTitle) {
		ClosePoE("ahk_class " windowClass)
	Return
	}	
	
	If (A_ThisMenuItem="&Settings") {
	Return
	}			
	
	If (A_ThisMenuItem="AutoLoad on Start") {
		Menu, Submenu2, ToggleCheck, AutoLoad on Start
		if(loadOnStart = 1){
			if(notifyShow)
				Notify(launcherTitle " Launcher","AutoLoad: Off", 1,"Style=Mine TS=12 MS=12")		
			loadOnStart := 0
		} else {
			if(notifyShow)
				Notify(launcherTitle " Launcher","AutoLoad: On", 1,"Style=Mine TS=12 MS=12")					
			loadOnStart := 1		
		}
		IniWrite, %loadOnStart%, %INI_FILE%, Defaults, loadOnStart
		if (ErrorLevel = 1) {
			MsgBox, Error writing loadOnStart %loadOnStart%
		}
		GoSub OnStart
	Return
	}
	
	If (A_ThisMenuItem="AutoClose on Exit") {
	  Menu, Submenu2, ToggleCheck, AutoClose on Exit
		if(closeOnExit = 1){
			if(notifyShow)
				Notify(launcherTitle " Launcher","AutoClose: Off", 1,"Style=Mine TS=12 MS=12")					
			closeOnExit := 0
		} else {
			if(notifyShow)
				Notify(launcherTitle " Launcher","AutoClose: On", 1,"Style=Mine TS=12 MS=12")			
			closeOnExit := 1	
		}
		IniWrite, %closeOnExit%, %INI_FILE%, Defaults, closeOnExit
		if (ErrorLevel = 1) {
			MsgBox, Error writing closeOnExit %closeOnExit%
		}
	Return
	}

	If (A_ThisMenuItem="Set Process Level on Start") {
	  Menu, Submenu2, ToggleCheck, Set Process Level on Start
		if(setLevelOnStart = 1){
			if(notifyShow)
				Notify(launcherTitle " Launcher","Set Process Level On Start: Off", 1,"Style=Mine TS=12 MS=12")					
			setLevelOnStart := 0
		} else {
			if(notifyShow)
				Notify(launcherTitle " Launcher","Set Process Level On Start: On", 1,"Style=Mine TS=12 MS=12")								
			setLevelOnStart := 1	
		}
		IniWrite, %setLevelOnStart%, %INI_FILE%, Defaults, setLevelOnStart
		if (ErrorLevel = 1) {
			MsgBox, Error writing setLevelOnStart %setLevelOnStart%
		}		 
	Return
	}
	
	If (A_ThisMenuItem="Tweak Window on Start") {
	  Menu, Submenu2, ToggleCheck, Tweak Window on Start
		if(setResOnStart = 1){
			if(notifyShow)
				Notify(launcherTitle " Launcher","Tweak Window on Start: Off", 1,"Style=Mine TS=12 MS=12")			
			setResOnStart := 0
		} else {
			if(notifyShow)
				Notify(launcherTitle " Launcher","Tweak Window on Start: On", 1,"Style=Mine TS=12 MS=12")						
			setResOnStart := 1			
		}
		IniWrite, %setResOnStart%, %INI_FILE%, Defaults, setResOnStart 
		if (ErrorLevel = 1) {
			MsgBox, Error writing setResOnStart %setResOnStart%
		}		 		
	Return
	}

	If (A_ThisMenuItem="Use Notifications") {
	  Menu, Submenu2, ToggleCheck, Use Notifications
		if(notifyShow = 1){
			notifyShow := 0
		} else {
			notifyShow := 1			
		}
		IniWrite, %notifyShow%, %INI_FILE%, Defaults, notifyShow 
		if (ErrorLevel = 1) {
			MsgBox, Error writing notifyShow %notifyShow%
		}		 		
	Return
	}	

	If (A_ThisMenuItem="Below Normal") {
		if(notifyShow)
			Notify(launcherTitle " Launcher","Set Process Level: Below Normal", 1,"Style=Mine TS=12 MS=12")					
		defaultLevel := "BelowNormal"
		ProcessSetCheck(defaultLevel)			
		IniWrite, %defaultLevel%, %INI_FILE%, Defaults, defaultLevel
		if (ErrorLevel = 1) {
			MsgBox, Error writing defaultLevel %defaultLevel%
		}		
		SetProcessLevel("BelowNormal","ahk_class" windowClass)
	Return
	}	
	
	If (A_ThisMenuItem="Normal") {
		if(notifyShow)
			Notify(launcherTitle " Launcher","Set Process Level: Normal", 1,"Style=Mine TS=12 MS=12")							
		defaultLevel := "Normal"
		ProcessSetCheck(defaultLevel)			
		IniWrite, %defaultLevel%, %INI_FILE%, Defaults, defaultLevel
		if (ErrorLevel = 1) {
			MsgBox, Error writing defaultLevel %defaultLevel%
		}			
		SetProcessLevel("Normal","ahk_class" windowClass)
	Return
	}	
	
	If (A_ThisMenuItem="Above Normal") {
		if(notifyShow)
			Notify(launcherTitle " Launcher","Set Process Level: Above Normal", 1,"Style=Mine TS=12 MS=12")							
		defaultLevel := "AboveNormal"
		ProcessSetCheck(defaultLevel)			
		IniWrite, %defaultLevel%, %INI_FILE%, Defaults, defaultLevel
		if (ErrorLevel = 1) {
			MsgBox, Error writing defaultLevel %defaultLevel%
		}					
		SetProcessLevel("AboveNormal","ahk_class" windowClass)
	Return
	}	
	
	;If (A_ThisMenuItem="High") {
	;	defaultLevel := "High"
	;	IniWrite, %defaultLevel%, %INI_FILE%, Defaults, defaultLevel		
	;Return
	;}				

	If (A_ThisMenuItem="E&xit") {
		if(closeOnExit = 1) {
			if(notifyShow)
				Notify(launcherTitle " Launcher","Bye bye", 1,"Style=Mine TS=12 MS=12")					
			CloseAll("ahk_class " windowClass)
		}
	  ExitApp
	Return
	}
	
Return


; Install hotkeys
; Disable the left win key
LWin::
	if (WinActive("ahk_class " windowClass))
	{
		Return
	} else {
		SendInput { LWin }
		Return		
	}
Return


; Installs hotkey F10: trigger TweakWindow
F10::
	if (WinActive("ahk_class " windowClass))
	{
		GetWindowConfig()
		TweakWindow("ahk_class " windowClass)
	} else {
		SendInput {F10}
	}		
Return

OnStart:
	SetTimer, HeartBeat, 500	
	if(loadOnStart = 1) {
		Menu, Submenu2, Check, AutoLoad on Start
		Launch("ahk_class " windowClass)
	} else {
		Menu, Submenu2, Uncheck, AutoLoad on Start
	}

	if(closeOnExit = 1) {
		Menu, Submenu2, Check, AutoClose on Exit
	} else {
		Menu, Submenu2, Uncheck, AutoClose on Exit
	}			

	if(setLevelOnStart = 1) {
		Menu, Submenu2, Check, Set Process Level on Start
	} else {
		Menu, Submenu2, Uncheck, Set Process Level on Start
	}	

	if(setResOnStart = 1) {
		Menu, Submenu2, Check, Tweak Window on Start
	} else {
		Menu, Submenu2, Uncheck, Tweak Window on Start
	}

	if(notifyShow = 1) {
		Menu, Submenu2, Check, Use Notifications
	} else {
		Menu, Submenu2, Uncheck, Use Notifications
	}	
		
	ProcessSetCheck(defaultLevel)
	if(hasQuickLinks == 1){
		tmpFileOut := ""	
		tmpFileDir := ""
		tmpFileExt := ""			
		tmpFileOutnoExt := ""			
		tmpFileArgs := ""
		tmpFileDesc := ""
		tmpFileIcon := ""
		tmpFileIconNum := ""
		tmpFileState := ""
		tmpFileURL := url
			
		; Loop thru the QuickLinks array to add menu items
		for i, var in quickLinks {
			tmpFileFull := quicklinkDir . var
			; SplitPath, InputVar , OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
			SplitPath, var, tmpFileOut, tmpFileDir, tmpFileExt, tmpFileOutnoExt,
			;MsgBox, %tmpFileOut%`n%tmpFileDir%`n%tmpFileExt%`n%tmpFileOutnoExt%`n
			; FileGetShortcut, LinkFile , OutTarget, OutDir, OutArgs, OutDescription, OutIcon, OutIconNum, OutRunState			
			FileGetShortcut, %tmpFileFull%,tmpFileOut,tmpFileDir,tmpFileArgs,tmpFileDesc,tmpFileIcon,tmpFileIconNum,tmpFileState
			;MsgBox, %tmpFileOut%`n%tmpFileDir%`n%tmpFileExt%`n%tmpFileOutnoExt%`n
			if !ErrorLevel {
				if (tmpFileOut = "") ; Shortcut .lnk
				{
					;IfExist, %FileURL_Icon%
					Menu, QuickLinksMenu, Icon, %tmpFileOutnoExt%, %tmpFileFull%,%tmpFileIconNum%,
				}	else {
					Menu, QuickLinksMenu, Icon, %tmpFileOutnoExt%, %tmpFileOut%,%tmpFileIconNum%,
				}	
			} else {			
				if("url" = tmpFileExt) ; URLFile .url
				{
					;MsgBox, FileExt: %tmpFileExt%
					Menu, QuickLinksMenu, Icon, %tmpFileOutnoExt%, %FileURL_Icon%,,
				}
				if("exe" = tmpFileExt) ;ProgramFIle .exe
				{
					Menu, QuickLinksMenu, Icon, %tmpFileOutnoExt%, %tmpFileFull%,,
				}
				Continue
			}
		}
	}
Return

HeartBeat:
	hwndCount := GetProcessCount("ahk_class " windowClass)
	if WinExist("ahk_class " windowClass) 
	{
		Menu, Tray, Enable, &Close %launcherTitle%
		Menu, Tray, Enable, &TweakWindow
	} else {
		Menu, Tray, Disable, &Close %launcherTitle%
		Menu, Tray, Disable, &TweakWindow		
	}	
		
Return

Launch(hWnd) {
	hwndCount := GetProcessCount(hWnd)

	if(hWndCount < processMax) {
		tmpFileFull := programPath . programFile
		StringReplace, tmpFileFull, tmpFileFull, /, \, All
		
		if FileExist(tmpFileFull) {
			if(notifyShow)
				Notify(launcherTitle " Launcher","Launching: " windowTitle, 1,"Style=Mine TS=12 MS=12")			
			tmpFile := ""
			tmpWorkingDir := ""
			tmpFileExt := ""
			tmpFileName := ""
			tmpFileDrive := ""
			pID := ""
			this_id := ""
			
			; SplitPath, InputVar , OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
			SplitPath, tmpFileFull, tmpFile, tmpWorkingDir, tmpFileExt, tmpFileName, tmpFileDrive

			;Run, Target , WorkingDir, Options, OutputVarPID
			Run, %tmpWorkingDir%\%tmpFile%,%tmpWorkingDir%,,pID
			Sleep, %loadDelay%
			WinGet, tmpArray, List , %hWnd%
			iCount := tmpArray
			if(iCount >= 1) {
				Loop, %tmpArray%
				{
		    		this_id := tmpArray%A_Index%	
		    		WinGet, pID, PID, ahk_id %this_id%
			  		Process, Exist, pID
					if !ErrorLevel {
				    	if(setResOnStart) {
							GetWindowConfig()
							TweakWindow("ahk_id " this_id,1)
				    	}			
				    	if(setLevelOnStart) {
							;MsgBox, Set Level - Window Id: %this_id%				    	
							;WinActivate, ahk_id %this_id%   	
				    	SetProcessLevel(defaultLevel,"ahk_class " windowClass)
				   		}
				  	}			
				}
			}
    	}
	}
	Return
}

ClosePoE(hWnd) {
	;WinGet, OutputVar, List , WinTitle, WinText, ExcludeTitle, ExcludeText
	WinGet, hWndArray, List , %hWnd%
	hWndCount := hWndArray
	if(hWndCount >= 1) {
		Loop, %hWndArray%
		{
		    this_id := hWndArray%A_Index%	
		    WinGet, pID, PID, ahk_id %this_id%
		    Process, Exist, pID
			if !ErrorLevel {
				WinActivate, ahk_id %this_id%
				MsgBox, 4, , Close this Window?				
				IfMsgBox, Yes			  	
				Process, Close, %pID%
				hWndCount--		  	
			}
		}			
	}	
	Return
}

CloseAll(hWnd) {
	;WinGet, OutputVar, List , WinTitle, WinText, ExcludeTitle, ExcludeText
	WinGet, hWndArray, List , %hWnd%
	hWndCount := hWndArray
	if(hWndCount >= 1) {		
		Loop, %hWndArray%
		{
		    this_id := hWndArray%A_Index%
		    WinGet, pID, PID, ahk_id %this_id%
		    Process, Exist, pID
			if !ErrorLevel {		
				Process, Close, %pID%
				hWndCount--
			}
		}
	}	
	Return
}

SetProcessLevel(pLevel,hWnd) {
	;WinGet, OutputVar, List , WinTitle, WinText, ExcludeTitle, ExcludeText
	WinGet, hWndArray, List , %hWnd%
	hWndCount := hWndArray
	if(hWndCount >= 1) {	
		Loop, %hWndArray%
		{
		    this_id := hWndArray%A_Index%
		    WinGet, pID, PID, ahk_id %this_id%
		    Process, Exist, pID
			if !ErrorLevel {
				Process, Priority, %pID%, %pLevel%
			}
		}
	}
	Return
}

GetProcessPID(hWnd) {
	;SetTitleMatchMode, 1
	if WinExist(hWnd) {
		;WinWait, %hWnd%,, 15
		WinActivate, %hWnd%
		;Sleep, 1000	
		WinGet, pID, PID
		Return pID
	}
	Return 0
}

ProcessSetCheck(p) {
	if(p="AboveNormal") {
		Menu, Submenu1, Check, Above Normal
		Menu, Submenu1, Default, Above Normal
		Menu, Submenu1, Uncheck, Normal
		Menu, Submenu1, Uncheck, Below Normal
	} else if(p="Normal") {
		Menu, Submenu1, Uncheck, Above Normal
		Menu, Submenu1, Check, Normal
		Menu, Submenu1, Default, Normal
		Menu, Submenu1, Uncheck, Below Normal		
	} else if(p="BelowNormal") {
		Menu, Submenu1, Uncheck, Above Normal
		Menu, Submenu1, Uncheck, Normal
		Menu, Submenu1, Check, Below Normal
		Menu, Submenu1, Default, Below Normal		
	}	
	Return
}

WriteConfig() {
	/*
	[Defaults]
	; Abbreviated Title of the app being launched
	launcherTitle=PoE 
	; Limit the number of times the process can run
	processMax=2
	; Delay to wait for the process to load
	loadDelay=3500
	; Load Path of Exile when you run the script, 0=Off, 1=On
	loadOnStart=0
	; Close Path of Exile when you exit the script, 0=Off, 1=On
	closeOnExit=0
	; Set a borderless 1080p'ish window adjustment when you launch POE, 0=Off, 1=On
	setResOnStart=0
	; Set the POE Process level when you launch POE, 0=Off, 1=On
	setLevelOnStart=0
	; The process priority level values can be : AboveNormal, Normal, BelowNormal
	defaultLevel=Normal
	*/
	;IniWrite, Value, Filename, Section, Key
	
	; Section Defaults
	IniWrite, %notifyShow%, %INI_FILE%, Defaults, notifyShow
	IniWrite, %launcherTitle%, %INI_FILE%, Defaults, launcherTitle
	IniWrite, %processMax%, %INI_FILE%, Defaults, processMax
	IniWrite, %loadDelay%, %INI_FILE%, Defaults, loadDelay
	IniWrite, %loadOnStart%, %INI_FILE%, Defaults, loadOnStart
	IniWrite, %closeOnExit%, %INI_FILE%, Defaults, closeOnExit
	IniWrite, %setLevelOnStart%, %INI_FILE%, Defaults, setLevelOnStart
	IniWrite, %setResOnStart%, %INI_FILE%, Defaults, setResOnStart
	IniWrite, %defaultLevel%, %INI_FILE%, Defaults, defaultLevel

	/*
	[Paths]
	; Path to the POE folder, default: C:\Program Files (x86)\Grinding Gear Games\Path of Exile\
	programPath=C:\Program Files (x86)\Grinding Gear Games\Path of Exile\
	; Path to the POE .exe file to launch, default: PathOfExile_x64.exe
	programFile=PathOfExile_x64.exe
	; Window Class to monitor, use winspy or some tool to figure this out for other games
	windowClass=POEWindowClass
	*/
	
	; Section Paths
	IniWrite, %programPath%, %INI_FILE%, Paths, programPath
	IniWrite, %programFile%, %INI_FILE%, Paths, programFile
	IniWrite, %windowTitle%, %INI_FILE%, Paths, windowTitle
	IniWrite, %windowClass%, %INI_FILE%, Paths, windowClass

	; Section Window
	IniWrite, %tweakWindowWidth%, %INI_FILE%, Window, tweakWindowWidth
	IniWrite, %tweakWindowHeight%, %INI_FILE%, Window, tweakWindowHeight
	
	Return
}

GetWindowConfig()
{
	IniRead, tweakWindowWidth, %INI_FILE%, Window, tweakWindowWidth, "1920"
	IniRead, tweakWindowHeight, %INI_FILE%, Window, tweakWindowHeight, "1030"	
	;Notify(launcherTitle " Launcher","GetWeakWindowConfig()`nWidth: " tweakWindowWidth "`nHeight:" tweakWindowHeight, 1,"Style=Mine TS=12 MS=12")		
}

GetProcessCount(hWnd) {
	WinGet, Result, List , %hWnd%
	Return Result
}

GetQuickLinksArray(ArrayName,Dir,Ext="*.exe,*.lnk,*.ahk,*.url") {
	ClearArray(ArrayName)
	Loop, Parse, Ext, % ","
	{
		Loop Files, %Dir%\%A_LoopField% ; Top Level do not Recurse into subfolders.
		{
			;ArrayName.Insert(A_LoopFileName)
			ArrayName.InsertAt(ArrayName.Length() + 1,A_LoopFileName)
		} 
	}
	Return ArrayName.Count()
}


ClearArray(ArrayName) ;needs explicit "" for "ArrayName"
{
	global
	While %ArrayName%0
	{
		local ArrayNumber := %ArrayName%0 ; save the current number in this var
		%ArrayName%%ArrayNumber% := "" ; clear the variable (will not release the memory)
		VarSetCapacity(%ArrayName%%ArrayNumber%, 0) ; release (most of) the memory that the var is using
		%ArrayName%0-- ; decrement the counter
	}
	Return
}

; TweakWindow() Settings
; Your resolution minus decorations like start bars if you wish to leave those on-screen.
; The default values are for around 1080p windowless fullscreen minus a little to allow the taskbar to show below the window
; More information can be found in this video by TriPolar Bear
; https://www.youtube.com/watch?v=p1BLjmfC6e0
; Need to find out who the author of the TweakWindow code was for crediting
; Based on the script talked about in this video by TriPolarBear
; https://www.youtube.com/watch?v=p1BLjmfC6e0
TweakWindow(hWnd,tweakLimit=0)
{
	; Window width and  height Settings edit carefully
	;w = 1920
	;h = 1030
	w := tweakWindowWidth
	h := tweakWindowHeight
	w_wasted = 6 ; width used by resize bars
	h_wasted = 29 ; width used by caption frame and resize bars	
	
	; Exclude the desktop
	; Note: Also excludes "My Computer" browsing windows.
	; Better detection might be needed to differentiate the parent explorer "ahk_id" from child windows.
	; Also seems to disregard accidental Metro interface clicks (Win 8+)
	;MsgBox, hWnd: %hWnd%
	if WinExist(hWnd) {
		BlockInput On    	
		WinActivate, %hWnd%
		WinWaitActive, %hWnd%,,3
		if (ErrorLevel != 0)
		{
			MsgBox, WinWait timed out.
			Return
		}
		BlockInput On		
		WinGet Style, Style, %hWnd%
	    ; 0xC40000 = WS_BORDER (0x800000) + WS_DLGFRAME (0x400000) + WS_SIZEBOX aka WS_THICKFRAME (0x040000)
	    if(Style & 0xC00000) { ; if has WS_CAPTION. Ignore sizebox value.
	    	WinGetPos, X, Y, Width, Height, %hWnd%
	    	WinSet, Style, -0xC40000, %hWnd% ; removes attributes, including sizebox...doesn't do a strict subtraction
	    	WinMove,%hWnd%,,0,0,w,h     
	    	;MsgBox, One
	    } else {
	    	if(tweakLimit = 0)	
	    	{
	        	WinSet, Style, +0xC40000, %hWnd%
	        	; Note: will set WS_SIZEBOX even if not previously present
	        	if(Width > w - w_wasted) {
	            	Width := %w%-%w_wasted%
	        	}
	        	if(Height > h - h_wasted) {
	           	Height := %h%-%h_wasted%
	        	}
	        	WinMove,%hWnd%,,%X%,%Y%,%Width%,%Height%      
				;MsgBox, Two	      		
	    	}
	    }
	    WinSet, Redraw,,%hWnd%
	    BlockInput Off
	}
	Return   
}