/*
Example: Demonstrates the usage of *ImageList.ahk*
	* Image list manipulation using the ImageList class
	* Loading system bitmaps, icons and cursors into the image list
	* Show the result in a listview

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lgpl-2.1.txt)

Requirements:
	AutoHotkey - AHK_L v1.1+
	OS - Windows XP / Windows Server 2003 or higher
	Classes - CCF (see #include directives for more details)
*/
#SingleInstance force
#include ..\..\_CCF_Error_Handler_\_CCF_Error_Handler_.ahk
#Include ..\..\Unknown\Unknown.ahk
#Include ..\ImageList.ahk
#Include ..\..\Helper Classes\OBM.ahk
#Include ..\..\Helper Classes\IDI.ahk
#Include ..\..\Helper Classes\IDC.ahk

myIL := ImageList.FromHIMAGELIST()

myIL.Add(DllCall("LoadBitmap", "uint", 0, "uint", 32747), 0) ; add images manually
myIL.ReplaceIcon(DllCall("LoadIcon", "uint", 0, "uint", 32513)) ; append an icon manually

myIL.AddSystemBitmap(OBM.ZOOMD) ; add system images
myIL.AddSystemIcon(IDI.WINLOGO)
myIL.AddSystemCursor(IDC.WAIT)

il2 := myIL.Clone() ; do a clone
il2.AddSystemBitmap(OBM.ZOOMD) ; add another system image

il2.SetImageCount(il2.GetImageCount() - 2) ; cut
il2.SetImageCount(il2.GetImageCount() + 2) ; re-enlarge list

Gui Add, Listview, h800,ahk
Loop 6
	LV_Add("icon" A_Index, Chr(64 + A_Index))
LV_SetImageList(il2.ptr) ; use Listview to show list

Gui +Resize
Gui Show

ImageList.Unload() ; unload DLL - optional
return

GuiClose:
ExitApp