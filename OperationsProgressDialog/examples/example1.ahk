#include ..\..\Unknown\Unknown.ahk
#include ..\OperationsProgressDialog.ahk
#include ..\..\Helper Classes\PDOPSTATUS.ahk
#include ..\..\Helper Classes\SPACTION.ahk

op := new OperationsProgressDialog() ; create instance
op.StartProgressDialog() ; start dialog

op.SetOperation(SPACTION.DOWNLOADING) ; indicating we're downloading
Loop 100
{
	op.UpdateProgress(A_Index / 4, 25, A_Index, 100, A_Index / 2, 50) ; increase progress
	sleep 1000
	if (op.GetOperationStatus() == PDOPSTATUS.CANCELLED) ; if user cancelled: abort
		break
}
op.StopProgressDialog() ; close dialog