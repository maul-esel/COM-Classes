#SingleInstance
#Include ..\..\Unknown\Unknown.ahk
#include ..\..\TaskbarList\TaskbarList.ahk
#include ..\..\TaskbarList2\TaskbarList2.ahk
#include ..\TaskbarList3.ahk

OnExit GuiClose
OnMessage(0x111, "WM_COMMAND") ;monitor clicks on buttons

Gui +LastFound
hGui := WinExist() ; get window handle
Gui Show, w150 h100 ; show gui

tbl := new TaskbarList3 ; create instance
tbl.HrInit() ; init instance

il := IL_Create() ; create imagelist
IL_Add(il, A_WinDir "\system32\shell32.dll", 45) ; add 1 icon to imagelist
tbl.ThumbBarSetImageList(hGui, il) ; set imagelist for ThumbBar

buttons := 	[{ "iBitmap" : 0, "szTip" : "my tip"}
			, { "hIcon" : DllCall("LoadIconW", "uint", 0, "uint", 32514), "szTip" : "this is the 2nd button"}] ; create button description array
tbl.ThumbBarAddButtons(hGui, buttons) ; add buttons

sleep 10000 ; sleep some time
tbl.ThumbBarUpdateButtons(hGui, [{"dwFlags" : "disabled"}]) ; disable the first button

tbl.Release() ; release the instance

return
GuiClose:
Gui Destroy
ExitApp
return
	
WM_COMMAND(wp){
	static THBN_CLICKED := 0x1800
	if (HIWORD(wp) = THBN_CLICKED) ;if we received a button click:
		Msgbox 64,,% "The ThumbBar button with the id `"" LOWORD(wp) "`" was clicked!", 3 ; show it to the user
	}

HIWORD(val){
	return val >> 16
	}

LOWORD(val){
	return val & 0xFFFF 
	}
