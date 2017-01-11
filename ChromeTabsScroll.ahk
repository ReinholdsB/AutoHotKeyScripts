; ---- ChromeTabsScroll.ahk for AutoHotKey -----
; Switch tabs by scroll and maximize window by double click on tab for Google Chrome
; works on Vista/Win7 with any recent chrome verion (3.x or 4.x)
; for XP or without Aero you might need to adjust topMin/topMax variables

#NoEnv
#SingleInstance force

IsChromeTabBar(winmax, xaxis, yaxis) {
	; boundaries for normal window on vista/win7
	topMin = 4
	topMax = 42
	if (winmax == 1) {
		; with Aero top edge is offscreen
		topMin = 4
		topMax = 30
	}
	
	; TODO also clip on left or right < 8
	if (yaxis >= topMin and yaxis <= topMax)
		return 1
	else
		return 0
}

#IfWinActive ahk_class Chrome_WidgetWin_1
	; scroll on tab bar to switch tabs
	~$WheelDown::
	~$WheelUp::
		MouseGetPos,, yaxis,winid
		WinGet, winmax,MinMax,ahk_id %winid%
		if not IsChromeTabBar(winmax,-1,yaxis)
			return
		ifEqual, A_ThisHotkey,~$WheelDown, Send ^{PgDn}
		else Send ^{PgUp}
		return
	; double click on tab to maximize
	~LButton::
		MouseGetPos,, yaxis,winid
		if (A_PriorHotkey == A_ThisHotkey and A_TimeSincePriorHotkey < 320) {
			if not IsChromeTabBar(winMaxOld,-1,yaxis)
				return
			Sleep 100
			WinGet, winMaxNew,MinMax,ahk_id %winid%
			if (winMaxOld == winMaxNew) {
				if (winMaxNew == 0)
					WinMaximize
				else
					WinRestore
			}
		} else {
			WinGet, winMaxOld,MinMax,ahk_id %winid%
		}
		return
#IfWinActive

#IfWinActive #IfWinActive ahk_class MozillaWindowClass
	; scroll on tab bar to switch tabs
	~$WheelDown::
	~$WheelUp::
		MouseGetPos,, yaxis,winid
		WinGet, winmax,MinMax,ahk_id %winid%
		if not IsChromeTabBar(winmax,-1,yaxis)
			return
		ifEqual, A_ThisHotkey,~$WheelDown, Send ^{PgDn}
		else Send ^{PgUp}
		return
	; double click on tab to maximize
	~LButton::
		MouseGetPos,, yaxis,winid
		if (A_PriorHotkey == A_ThisHotkey and A_TimeSincePriorHotkey < 320) {
			if not IsChromeTabBar(winMaxOld,-1,yaxis)
				return
			Sleep 100
			WinGet, winMaxNew,MinMax,ahk_id %winid%
			if (winMaxOld == winMaxNew) {
				if (winMaxNew == 0)
					WinMaximize
				else
					WinRestore
			}
		} else {
			WinGet, winMaxOld,MinMax,ahk_id %winid%
		}
		return
#IfWinActive
