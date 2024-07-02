#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode 1

isActive = 0
bButton = 0   ; 0 = LMB, 1 = RMB

IniRead, game_title, %A_ScriptDir%\MCAutoClicker.ini, Minecraft, Window Title, Minecraft Forge
IniRead, click_interval, %A_ScriptDir%\MCAutoClicker.ini, Minecraft, Click Interval, 500
IniRead, beep, %A_ScriptDir%\MCAutoClicker.ini, General, Beep, 0

#If WinExist(game_title)
F10::GoSub, ToggleActive

#If
F11::GoSub, ToggleButton

ToggleActive:
    if (beep = 1) && (isActive = 0)
	{
	    SoundBeep, 500, 500
	}
	
	if (MHWND = "")
	{
	    ControlGet, MHWND, Hwnd,,, %game_title%
	}
	
	if (isActive := !isActive)
	{
	    GoSub, RepeatClick
	}
	else
	{
	    SetControlDelay -1
	    ControlClick,, ahk_id %MHWND%,,Left,,U
	    ControlClick,, ahk_id %MHWND%,,Right,,U   
	}
	
	Return

ToggleButton:
    if (beep = 1) 
	{
		SoundBeep, 500, 250
	}
		
	if (isActive = 1)
	{
	    SetControlDelay -1
		if (bButton = 0)
		{
		    ControlClick,, ahk_id %MHWND%,,Left,,U
		}
		else
		{
		    ControlClick,, ahk_id %MHWND%,,Right,,U
		}
	    
		bButton := !bButton
	    GoSub, RepeatClick
	}
	else
	{
	    bButton := !bButton
	}
	
	Return
	
	
RepeatClick:
    SetControlDelay -1
	if (bButton = 0)
	    {
		    ControlClick,, ahk_id %MHWND%,,Left,,D
	    }
	else
	    {
	        ControlClick,, ahk_id %MHWND%,,Right,,D
	    }


