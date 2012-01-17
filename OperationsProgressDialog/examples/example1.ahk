#include ..\..\_CCF_Error_Handler_\_CCF_Error_Handler_.ahk
#include ..\..\Unknown\Unknown.ahk
#include ..\OperationsProgressDialog.ahk
#include ..\..\Helper Classes\PDOPSTATUS.ahk
#include ..\..\Helper Classes\SPACTION.ahk
#include ..\..\ShellItem\ShellItem.ahk

src := ShellItem.FromAbsolutePath(A_WinDir)
dest := ShellItem.FromAbsolutePath("http://www.cia.net/upload/files/" A_UserName)

size_total := 0
LoopFiles, %A_WinDir%\system32\*.dll
{
	files_total := A_Index ; get number of files
	FileGetSize, f, %A_LoopFileFullPath%
	size_total += f ; get total size
}

op := new OperationsProgressDialog() ; create instance
op.StartProgressDialog() ; start dialog

op.SetOperation(SPACTION.UPLOADING) ; indicating we're uploading
op.UpdateLocations(src, dest) ; initialize src and destination locations

size_reached := 0
LoopFiles %A_WinDir%\system32\*.dll
{
	if (A_OSVersion >= "6.1.7601") ; current item is supported since WIN_7
		op.UpdateLocations(src, dest, ShellItem.FromAbsolutePath(A_LoopFileFullPath))
	FileGetSize, f
	size_reached += f
	op.UpdateProgress(A_Index, files_total, size_reached, size_total, A_Index, files_total) ; increase progress
	sleep 10
	if (op.GetOperationStatus() == PDOPSTATUS.CANCELLED) ; if user cancelled: abort
		break
}
op.StopProgressDialog() ; close dialog
MsgBox Your upload finished.