#include ..\..\Unknown\Unknown.ahk
#include ..\ShellLinkW.ahk
#include ..\..\Helper Classes\SLGP.ahk
#include ..\..\Persist\Persist.ahk
#include ..\..\PersistFile\PersistFile.ahk

link := new ShellLinkW() ; create a shell link

link.SetPath(A_Comspec) ; set the target + other properties of the link
link.SetDescription("this is a test file by an AHK script")
link.SetIconLocation(A_WinDir "\system32\imageres.dll", 23)
link.SetWorkingDirectory(A_MyDocuments)
link.SetArguments("/k `"echo Hi! This is a test.`"")

file := new PersistFile(link.QueryInterface(PersistFile.IID)) ; get a PersistFile instance for the link

file.Save(A_Desktop "\comspec.lnk.lnk", true) ; save the link to a file (somehow the '.lnk' is trucated...)
MsgBox Saved the shell link to %A_Desktop%\comspec.lnk ; report to user
