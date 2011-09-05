#SingleInstance
#Include ..\..\Unknown\Unknown.ahk
#Include ..\ImageList.ahk

myIL := ImageList.FromHIMAGELIST()

myIL.Add(DllCall("LoadBitmapW", "uint", 0, "uint", 32747), 0)

Gui Add, Listview, h800,ahk
Loop 6
	LV_Add("icon" A_Index, Chr(64 + A_Index))

myIL.ReplaceIcon(DllCall("LoadIconW", "uint", 0, "uint", 32513))

myIL.AddSystemBitmap("zoomd")
myIL.AddSystemIcon("winlogo")
myIL.AddSystemCursor("wait")


il2 := myIL.Clone()
il2.AddSystemBitmap("zoomd")

il2.SetImageCount(il2.GetImageCount() - 2)
il2.SetImageCount(il2.GetImageCount() + 2)

LV_SetImageList(il2.ptr)
Gui +Resize
Gui Show

ImageList.Unload()
return

GuiClose:
ExitApp