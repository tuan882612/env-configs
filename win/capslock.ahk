#IfWinActive ahk_exe WindowsTerminal.exe
*CapsLock::
    Send {Blind}{Ctrl Down}
    cDown := A_TickCount
Return

*CapsLock up::
    If ((A_TickCount-cDown)<200)
        Send {Blind}{Ctrl Up}{Esc}
    Else
        Send {Blind}{Ctrl Up}
Return
#IfWinActive

; Apply to Warp Terminal
#IfWinActive ahk_exe Warp.exe
*CapsLock::
    Send {Blind}{Ctrl Down}
    cDown := A_TickCount
Return
*CapsLock up::
    If ((A_TickCount-cDown)<270)
        Send {Blind}{Ctrl Up}{Esc}
    Else
        Send {Blind}{Ctrl Up}
Return
#IfWinActive

; Apply to Browsers with LeetCode check
#IfWinActive, ahk_exe Arc.exe || ahk_exe waterfox.exe
CapsLock::
    WinGetTitle, Title, A
    if InStr(Title, "leetcode") or InStr(Title, "LeetCode")
    {
        Send {Esc}
    }
    else
    {
        ; For non-LeetCode sites, use KeyWait for dual behavior
        Send {Ctrl Down}
        KeyWait, CapsLock
        Send {Ctrl Up}
        
        ; If it was a quick tap, also send Escape
        if (A_TimeSinceThisHotkey < 200)
        {
            Send {Esc}
        }
    }
Return
#IfWinActive
