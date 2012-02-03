/*
class: ProgressDialog
wraps the *IProgressDialog* interface and exposes methods to create, control and display a progress dialog.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lgpl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/AHK_Lv1.1/ProgressDialog)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/bb775248)

Requirements:
	AutoHotkey - AHK_L v1.1+
	OS - Windows 2000 Professional / Windows XP or Windows Server 2003 or higher.
	Base classes - _CCF_Error_Handler_, Unknown
	Helper classes - PROGDLG, PDTIMER
*/
class ProgressDialog extends Unknown
{
	/*
	Field: CLSID
	This is CLSID_ProgressDialog. It is required to create an instance.
	*/
	static CLSID := "{F8383852-FCD3-11d1-A6B9-006097DF5BD4}"

	/*
	Field: IID
	This is IID_IProgressDialog. It is required to create an instance.
	*/
	static IID := "{EBBC7C04-315E-11d2-B62F-006097DF5BD4}"

	/*
	Method: StartProgressDialog
	starts displaying the progress dialog.

	Parameters:
		[opt] UINT flags - a combination of flags modifying the dialog. You can use the fields of the PROGDLG class for convenience.
		[opt] HWND hParent - the handle to a window to make the dialog box modal to. You must set the appropriate flag to make this work.

	Returns:
		BOOL success - true on success, false otherwise

	Example:
		(start code)
		MyProgress := new ProgressDialog()
		MyProgress.StartProgressDialog()
		(end code)
	*/
	StartProgressDialog(flags = 0, hParent = 0)
	{
		return this._Error(DllCall(NumGet(this.vt+03*A_PtrSize), "Ptr", this.ptr, "UInt", hParent, "Ptr", 0, "UInt", flags, "UInt", 0))
	}

	/*
	Method: StopProgressDialog
	stops displaying the dialog box.

	Returns:
		BOOL success - true on success, false otherwise

	Example:
		(start code)
		MyProgress := new ProgressDialog()
		MyProgress.StartProgressDialog()
		sleep 10000
		MyProgress.StopProgressDialog()
		(end code)
	*/
	StopProgressDialog()
	{
		return this._Error(DllCall(NumGet(this.vt+04*A_PtrSize), "Ptr", this.ptr))
	}

	/*
	Method: SetTitle
	sets the title of the dialog box, either before or while displaying it.

	Parameters:
		STR title - the title to set.

	Returns:
		BOOL success - true on success, false otherwise

	Example:
>	MyProgress.SetTitle("my new title")
	*/
	SetTitle(title)
	{
		return this._Error(DllCall(NumGet(this.vt+05*A_PtrSize), "Ptr", this.ptr, "wstr", title))
	}

	/*
	Method: HasUserCanceled
	checks whether the user canceled the dialog box.

	Returns:
		BOOL hasCanceled - true if the user canceled, false otherwise

	Example:
>	canceled := MyProgress.HasUserCanceled()
	*/
	HasUserCanceled()
	{
		this._Error(0)
		return DllCall(NumGet(this.vt+07*A_PtrSize), "Ptr", this.ptr)
	}

	/*
	Method: SetProgress
	sets the progress amount.

	Parameters:
		INT percent - the new progress value, in percent

	Returns:
		BOOL success - true on success, false otherwise

	Example:
>	MyProgress.SetProgress(50)
	*/
	SetProgress(percent)
	{
		return this._Error(DllCall(NumGet(this.vt+08*A_PtrSize), "Ptr", this.ptr, "UInt", percent, "UInt", 100))
	}

	/*
	Method: SetLine
	sets the text in a specific line of the dialog box.

	Parameters:
		INT line - the line whose text should be set (1 - 3)
		STR text - the text to set
		[opt] BOOL compact - true to compact path strings if they are too large to fit on a line. The paths are compacted with "PathCompactPath".

	Returns:
		BOOL success - true on success, false otherwise

	Example:
>	MyProgress.SetLine(1, "This is line 1")
	*/
	SetLine(line, text, compact = false)
	{
		return this._Error(DllCall(NumGet(this.vt+10*A_PtrSize), "Ptr", this.ptr, "UInt", line, "wstr", text, "UInt", compact, "UInt", 0)) ; msdn: last param is reserved
	}

	/*
	Method: SetCancelMsg
	sets the message that is displayed in the dialog box when the user cancels.

	Parameters:
		STR text - the text to display

	Returns:
		BOOL success - true on success, false otherwise

	Example:
>	MyProgress.SetCancelMsg("You canceled")
	*/
	SetCancelMsg(text)
	{
		return this._Error(DllCall(NumGet(this.vt+11*A_PtrSize), "Ptr", this.ptr, "wstr", text, "UInt", 0)) ; msdn: last param is reserved
	}

	/*
	Method: Timer
	performs an action on the ProgressDialog's timer

	Parameters:
		UINT action - the action to perform. You may use the fields of the PDTIMER class for convenience.

	Returns:
		BOOL success - true on success, false otherwise

	Remarks:
		Instead of specifying the operation, you may also use one of the methods <ResetTimer>, <PauseTimer> or <ResetTimer>.
	*/
	Timer(action)
	{
		return this._Error(DllCall(NumGet(this.vt+12*A_PtrSize), "Ptr", this.ptr, "UInt", action, "UInt", 0)) ; msdn: last param is reserved
	}

	/*
	Method: ResetTimer
	resets the timer the dialog box calculates to display the estimated remaining time.

	Returns:
		BOOL success - true on success, false otherwise

	Example:
>	MyProgress.ResetTimer()
	*/
	ResetTimer()
	{
		return this.Timer(PDTIMER.RESET)
	}

	/*
	Method: PauseTimer
	pauses the timer in the dialog box. *It will also stop the progress bar, regardless of any call to <SetProgress>.*
	This remains until <ResumeTimer> is called.

	Returns:
		BOOL success - true on success, false otherwise

	Example:
>	MyProgress.PauseTimer()
	*/
	PauseTimer()
	{
		return this.Timer(PDTIMER.PAUSE)
	}

	/*
	Method: ResumeTimer
	resumes the timer if it was previously paused.

	Returns:
		BOOL success - true on success, false otherwise

	Example:
>	MyProgress.ResumeTimer()
	*/
	ResumeTimer()
	{
		return this.Timer(PDTIMER.RESUME)
	}
}
