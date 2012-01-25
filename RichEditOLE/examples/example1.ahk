/*
	THIS EXAMPLE IS INCOMPLETE!!!
*/
#SingleInstance force
#include ..\..\_CCF_Error_Handler_\_CCF_Error_Handler_.ahk
#include ..\..\Unknown\Unknown.ahk
#include ..\RichEditOLE.ahk

DllCall("LoadLibrary", "Str", "Msftedit.dll", "Uint")

Gui +LastFound
hCtrl := DllCall("CreateWindowEx"
                  , "Uint", 0
                  , "str" , "RICHEDIT50W"
                  , "str" , ""
                  , "Uint", 0x40000000|0x10000000
                  , "int" , 5
                  , "int" , 5
                  , "int" , 200
                  , "int" , 200
                  , "Uint", WinExist()
                  , "Uint", 0
                  , "Uint", 0
                  , "Uint", 0)
edit := RichEditOLE.FromHWND(hCtrl)

Gui Show, w210 h210, test
return

GuiClose:
ExitApp
return