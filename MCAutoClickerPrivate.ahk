#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode 1

isActive = 0
bButton = 0 ; 0 = LMB, 1 = RMB

IniRead, game_title, %A_ScriptDir%\MCAutoClicker.ini, Minecraft, Window Title, Minecraft Forge
; IniRead, click_interval, %A_ScriptDir%\MCAutoClicker.ini, Minecraft, Click Interval, 500
IniRead, beep, %A_ScriptDir%\MCAutoClicker.ini, General, Beep, 0

#If WinExist(game_title)
F10::GoSub, ToggleActive

#If
F11::GoSub, ToggleButton

ToggleActive:
    If (beep = 1) && (isActive = 0)
	{
	    SoundBeep, 500, 500
	}
	
	If (MHWND = "")
	{
	    ControlGet, MHWND, Hwnd,,, %game_title%
	}
	
	If (isActive := !isActive)
	{
	    GoSub, RepeatClick
	}
	Else
	{
	    GoSub, ResetClick
	}
	
	Return

ToggleButton:
    If (beep = 1) 
	{
		SoundBeep, 500, 250
	}
		
	If (isActive = 1)
	{
		GoSub, ResetClick
		bButton := !bButton
	    GoSub, RepeatClick
	}
	Else
	{
	    bButton := !bButton
	}
	
	Return
	
	
RepeatClick:
	If (bButton = 0)
	{
		ControlClick,, ahk_id %MHWND%,,Left,,D
	}
	Else
	{
	    ControlClick,, ahk_id %MHWND%,,Right,,D
	}
	
	Return
	
ResetClick:
    If (bButton = 0)
	{
	    ControlClick,, ahk_id %MHWND%,,Left,,U
	}
	Else
	{
		ControlClick,, ahk_id %MHWND%,,Right,,U
	}
	
	Return
