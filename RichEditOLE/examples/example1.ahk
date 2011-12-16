#SingleInstance force
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

A_LastError(error="t") ; by Bentschi (german forum), slightly modified
{
  buffer_size := VarSetCapacity(buffer, 1024, 0)
  Loop, % DllCall("FormatMessageA", "uint", 0x1200, ptr := (A_PtrSize) ? "ptr" : "uint", 0, "uint", error != "t" ? error : A_LastError, "uint", 0x10000, ptr, &buffer, "uint", buffer_size, ptr, 0)
    error_msg .= Chr(NumGet(buffer, A_Index-1, "uchar"))
  return (error != "t" ? error : A_LastError) " - " error_msg
}