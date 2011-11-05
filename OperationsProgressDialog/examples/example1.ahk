#include ..\..\Unknown\Unknown.ahk
#include ..\OperationsProgressDialog.ahk
STATUS_CANCELLED := 3

op := new OperationsProgressDialog
op.StartProgressDialog()
op.SetOperation("downloading")
Loop 100
	{
	op.UpdateProgress(A_Index / 4, 25, A_Index, 100, A_Index / 2, 50)
	sleep 1000
	if (op.GetOperationStatus() == STATUS_CANCELLED)
		break
	}
op.StopProgressDialog()
op.Release()