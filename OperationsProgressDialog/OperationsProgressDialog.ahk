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
		[opt] variant flags - see Remarks
		[opt] hWnd hParent - the handle to the parent window
		
	Returns:
		bool success - true on success, false otherwise
		
	Remarks:
		For flags, you can either pass a combination of strings (separated by space or |) or a binary combination. Valid flags are:
		
		Normal (0x00000000) - Default, normal progress dialog behavior.
		Modal (0x00000001) - The dialog is modal to its hParent. The default setting is modeless.
		AutoTime (0x00000002) - Update "Line3" text with the time remaining. Present by default.
		NoTime (0x00000004) - Do not show the time remaining.
		NoMinimize (0x00000008) - Do not display the minimize button.
		NoProgressBar (0x00000010) - Do not display the progress bar.
		NoCancel (0x00000040) - Do not display a cancel button because the operation cannot be canceled.
		EnablePause (0x00000080) - Display a pause button.
		AllowUndo (0x000000100) - The operation can be undone through the dialog. The Stop button becomes Undo. If pressed, the Undo button then reverts to Stop.
		DontDisplaySourcePath (0x00000200) - Do not display the path of source file in the progress dialog.
		DontDisplayDestPath (0x00000400) - Do not display the path of the destination file in the progress dialog.
		NoMultiDayEstimates (0x00000800) - *Win7 and later:* If the estimated time to completion is greater than one day, do not display the time.
		DontDisplayLocations (0x00001000) - *Win7 and later:* Do not display the location line in the progress dialog.
	***************************************************************************************************************	
	*/
	StartProgressDialog(flags := 0, hParent := 0){
		static OPROGDLGF := { "normal" : 0x00000000, "modal" : 0x00000001, "autotime" : 0x00000002, "notime" : 0x00000004
							, "nominimize" : 0x00000008, "noprogressbar" : 0x00000010, "nocancel" : 0x00000040, "enablepause" : 0x00000080
							, "allowundo" : 0x000000100, "dontdisplaysourcepath" : 0x00000200, "dontdisplaydestpath" : 0x00000400
							, "nomultidayestimates" : 0x00000800, "dontdisplaylocations" : 0x00001000 }
	
		if flags is not integer
			{
			_flags := 0
			LoopParse flags, %A_Space%|
				{
				if (OPROGDLGF.HasKey(A_LoopField))
					_flags |= OPROGDLGF[A_LoopField]
				}
			}
		else
			_flags := flags
	
		return this.__Error(DllCall(NumGet(this.vt+03*A_PtrSize), "Ptr", this.ptr, "UInt", hParent, "Uint", _flags))
		}
	
	/**************************************************************************************************************
	Function: StopProgressDialog
	Stops the progress dialog.
	
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************	
	*/	
	StopProgressDialog(){
		return this.__Error(DllCall(NumGet(this.vt+04*A_PtrSize), "Ptr", this.ptr))
		}
	
	/**************************************************************************************************************
	Function: SetOperation
	Sets which progress dialog operation is occurring.
	
	Parameters:
		variant operation - the operation to perform
		
	Returns:
		bool success - true on success, false otherwise
		
	Remarks:
		For operation, you can either specify a string or its flag representation. Valid flags are:
		
		None (0) - No action is being performed.
		Moving (1) - Files are being moved.
		Copying (2) - Files are being copied.
		Recycling (3) - Files are being deleted.
		ApplyingAttribs (4) - A set of attributes are being applied to files.
		Downloading (5) - A file is being downloaded from a remote source.
		Searching_Internet (6) - An Internet search is being performed.
		Calculating (7) - A calculation is being performed.
		Uploading (8) - A file is being uploaded to a remote source.
		Searching_File (9) - A local search is being performed.
		Deleting (10) - *Windows Vista and later.* A deletion is being performed.
		Renaming (11) - *Windows Vista and later.* A renaming action is being performed.
		Formatting (12) - *Windows Vista and later.* A formatting action is being performed.
		Copy_Moving (13) - *Windows 7 and later.* A copy or move action is being performed.
	***************************************************************************************************************	
	*/
	SetOperation(operation){
		static SPACTION := { "none" : 0, "moving" : 1, "copying" : 2, "recycling" : 3, "applyingattribs" : 4, "downloading" : 5
							, "searching_internet" : 6, "calculating" : 7, "uploading" : 8, "searching_file" : 9, "deleting" : 10
							, "renaming" : 11, "formatting" : 12, "copy_moving" : 13 }

		if operation is not integer
			if (SPACTION.HasKey(operation))
				operation := SPACTION[operation]
			else
				operation := SPACTION["none"]
		
		return this.__Error(DllCall(NumGet(this.vt+05*A_PtrSize), "Ptr", this.ptr, "UInt", operation))
		}
	
	/**************************************************************************************************************
	Function: SetMode
	Sets progress dialog operations mode.
	
	Parameters:
		variant mode - the operation mode
	
	Returns:
		bool success - true on success, false otherwise
		
	Remarks:
		For mode, you can either specify a string or its flag representation. Valid flags are:
		
		Default (0x00000000) - Use the default progress dialog operations mode.
		Run (0x00000001) - The operation is running.
		Preflight (0x00000002) - The operation is gathering data before it begins, such as calculating the predicted operation time.
		Undoing (0x00000004) - The operation is rolling back due to an Undo command from the user.
		ErrorsBlocking (0x00000008) - Error dialogs are blocking progress from continuing.
		Indeterminate (0x00000010) - The length of the operation is indeterminate. Do not show a timer and display the progress bar in marquee mode.
	***************************************************************************************************************	
	*/
	SetMode(mode){
		static PMODE := { "default" : 0x00000000, "run" : 0x00000001, "preflight" : 0x00000002, "undoing" : 0x00000004
						, "errorsblocking" : 0x00000008, "indeterminate" : 0x00000010 }
						
		if mode is not integer
			if (PMODE.HasKey(mode))
				mode := PMODE[mode]
			else
				mode := PMODE["default"]
	
		return this.__Error(DllCall(NumGet(this.vt+06*A_PtrSize), "Ptr", this.ptr, "Uint", mode))
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
	UpdateProgress(pointsReached, pointsTotal, sizeReached, sizeTotal, itemsReached, itemsTotal){
		return this.__Error(DllCall(NumGet(this.vt+07*A_PtrSize),	"Ptr",		this.ptr
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
	UpdateLocations(source, target, item := 0) {
		return this.__Error(DllCall(NumGet(this.vt+08*A_PtrSize), "Ptr", this.ptr
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
	ResetTimer(){
		return this.__Error(DllCall(NumGet(this.vt+09*A_PtrSize), "Ptr", this.ptr))
		}
	
	/**************************************************************************************************************
	Function: PauseTimer
	Pauses progress dialog timer.
	
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************	
	*/
	PauseTimer(){
		return this.__Error(DllCall(NumGet(this.vt+10*A_PtrSize), "Ptr", this.ptr))
		}
	
	/**************************************************************************************************************
	Function: ResumeTimer
	Resumes progress dialog timer.
	
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************	
	*/
	ResumeTimer(){
		return this.__Error(DllCall(NumGet(this.vt+11*A_PtrSize), "Ptr", this.ptr))
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
	GetMilliseconds(ByRef elapsed, ByRef remaining){
		return this.__Error(DllCall(NumGet(this.vt+12*A_PtrSize), "Ptr", this.ptr, "UInt64*", elapsed, "UInt64*", remaining))
		}
	
	/**************************************************************************************************************
	Function: GetOperationStatus
	Gets operation status for progress dialog.
	
	Returns:
		int status - the dialog's status, one of the following values:
		1 - Running
		2 - Paused
		3 - Cancelled
		4 - Stopped
		5 - Errors
	
	Remarks:
		- To get information about success and failure of this method, check the instance's Error object.
	***************************************************************************************************************	
	*/
	GetOperationStatus(){
		this.__Error(DllCall(NumGet(this.vt+13*A_PtrSize), "Ptr", this.ptr, "UInt*", status))
		return status
		}
	}