#include ..\..\Unknown\Unknown.ahk
#include ..\OperationsProgressDialog.ahk

op := new OperationsProgressDialog
op.StartProgressDialog()
op.SetOperation("downloading")
Loop 100
	{
	op.UpdateProgress(A_Index / 4, 25, A_Index, 100, A_Index / 2, 50)
	sleep 1000
	}
op.StopProgressDialog()
op.Release()