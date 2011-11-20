/**************************************************************************************************************
class: OperationsProgressDialog
extends Unknown

Requirements:
	- This requires AHK v2 alpha
	- It also requires Windows 2000 Professional, Windows XP, Windows 2000 Server or higher
***************************************************************************************************************	
*/

class OperationsProgressDialog extends Unknown
{
	/**************************************************************************************************************
	Variable: CLSID
	This is CLSID_ProgressDialog. It is required to create the object.
	***************************************************************************************************************	
	*/
	static CLSID := "{F8383852-FCD3-11d1-A6B9-006097DF5BD4}"
	
	/**************************************************************************************************************
	Variable: IID
	This is IID_IOperationsProgressDialog. It is required to create the object.
	***************************************************************************************************************	
	*/
	static IID := "{0C9FB851-E5C9-43EB-A370-F0677B13874C}"

	/**************************************************************************************************************
	Function: StartProgressDialog
	Starts the progress dialog.
	
	Parameters:
		[opt] uint flags - a combination fo flags modifying the dialog. You can use the fields of the PROGDLG class for convenience.
		[opt] hWnd hParent - the handle to the parent window
		
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************	
	*/
	StartProgressDialog(flags := 0, hParent := 0)
	{
		return this._Error(DllCall(NumGet(this.vt+03*A_PtrSize), "Ptr", this.ptr, "UInt", hParent, "Uint", flags))
	}
	
	/**************************************************************************************************************
	Function: StopProgressDialog
	Stops the progress dialog.
	
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************	
	*/	
	StopProgressDialog()
	{
		return this._Error(DllCall(NumGet(this.vt+04*A_PtrSize), "Ptr", this.ptr))
	}
	
	/**************************************************************************************************************
	Function: SetOperation
	Sets which progress dialog operation is occurring.
	
	Parameters:
		uint operation - the operation to perform. You can use the fields of the SPACTION class for convenience.
		
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************	
	*/
	SetOperation(operation)
	{
		return this._Error(DllCall(NumGet(this.vt+05*A_PtrSize), "Ptr", this.ptr, "UInt", operation))
	}
	
	/**************************************************************************************************************
	Function: SetMode
	Sets progress dialog operations mode.
	
	Parameters:
		uint mode - the operation mode. You can use the fields of the PMODE class for convenience.
	
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************	
	*/
	SetMode(mode)
	{
		return this._Error(DllCall(NumGet(this.vt+06*A_PtrSize), "Ptr", this.ptr, "Uint", mode))
	}
	
	/**************************************************************************************************************
	Function: UpdateProgress
	
	Parameters:
		int pointsReached - Current points, used for showing progress in points. (progressbar)
		int pointsTotal - Total points, used for showing progress in points.
		int sizeReached - Current size in bytes, used for showing progress in bytes.
		int sizeTotal - total size in bytes, used for showing progress in bytes.
		int itemsReached - Current items, used for showing progress in items.
		int itemsTotal - Specifies total items, used for showing progress in items.
		
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************	
	*/
	UpdateProgress(pointsReached, pointsTotal, sizeReached, sizeTotal, itemsReached, itemsTotal)
	{
		return this._Error(DllCall(NumGet(this.vt+07*A_PtrSize),	"Ptr",		this.ptr
													,	"Uint64",	pointsReached
													,	"Uint64",	pointsTotal
													,	"UInt64",	sizeReached
													,	"UInt64",	sizeTotal
													,	"Uint64",	itemsReached
													,	"Uint64",	itemsTotal))
	}
	
	/**************************************************************************************************************
	Function: UpdateLocations
	Called to specify the text elements stating the source and target in the current progress dialog.
	
	Parameters:
		IShellItem source - the pointer to an IShellItem that represents the source Shell item.
		IShellItem target - the pointer to an IShellItem that represents the target Shell item.
		[opt] IShellItem item - *Win7 and later:* A pointer to an IShellItem that represents the item currently being operated on by the operation engine.
		
	Returns:
		bool success - true on success, false otherwise
		
	Remarks:
		You can either pass raw pointers or ShellItem instances to this method.
	***************************************************************************************************************	
	*/
	UpdateLocations(source, target, item := 0)
	{
		return this._Error(DllCall(NumGet(this.vt+08*A_PtrSize), "Ptr", this.ptr
								, "Ptr", IsObject(source) ? source.ptr : source
								, "Ptr", IsObject(target) ? target.ptr : target
								, "Ptr", IsObject(item) ? item.ptr : item))
	}
	
	/**************************************************************************************************************
	Function: ResetTimer
	Resets progress dialog timer to 0.
	
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************	
	*/
	ResetTimer()
	{
		return this._Error(DllCall(NumGet(this.vt+09*A_PtrSize), "Ptr", this.ptr))
	}
	
	/**************************************************************************************************************
	Function: PauseTimer
	Pauses progress dialog timer.
	
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************	
	*/
	PauseTimer()
	{
		return this._Error(DllCall(NumGet(this.vt+10*A_PtrSize), "Ptr", this.ptr))
	}
	
	/**************************************************************************************************************
	Function: ResumeTimer
	Resumes progress dialog timer.
	
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************	
	*/
	ResumeTimer()
	{
		return this._Error(DllCall(NumGet(this.vt+11*A_PtrSize), "Ptr", this.ptr))
	}

	/**************************************************************************************************************
	Function: GetMilliseconds
	Gets elapsed and remaining time for progress dialog.
	
	Parameters:	
		byref int elapsed - the elapsed time in milliseconds
		byref int remaining - the remaining time in milliseconds
	
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************	
	*/
	GetMilliseconds(ByRef elapsed, ByRef remaining)
	{
		return this._Error(DllCall(NumGet(this.vt+12*A_PtrSize), "Ptr", this.ptr, "UInt64*", elapsed, "UInt64*", remaining))
	}
	
	/**************************************************************************************************************
	Function: GetOperationStatus
	Gets operation status for progress dialog.
	
	Returns:
		int status - the dialog's status. You can compare it to the members of the PDOPSTATUS class.
	
	Remarks:
		- To get information about success and failure of this method, check the instance's Error object.
	***************************************************************************************************************	
	*/
	GetOperationStatus()
	{
		this._Error(DllCall(NumGet(this.vt+13*A_PtrSize), "Ptr", this.ptr, "UInt*", status))
		return status
	}
}
	
/*
group: dependencies & related
*/
/*
PROGDLG:
	You may use the values defined in the PROGDLG enumeration class with this class **(not auto-included)**.
*/
/*
SPACTION:
	You may use the values defined in the SPACTION enumeration class with this class **(not auto-included)**.
*/
/*
PMODE:
	You may use the values defined in the PMODE enumeration class with this class **(not auto-included)**.
*/
/*
PDOPSTATUS:
	You may use the values defined in the PDOPSTATUS enumeration class with this class **(not auto-included)**.
*/