/**************************************************************************************************************
class: ProgressDialog
exposes methods to create, control and display a progress dialog via COM interface IProgressDialog.

Requirements:
	- This requires AHK v2 alpha
	- It also requires Windows 2000 *Professional* / Windows XP or Windows Server 2003 or higher.
	- the Unknown class is needed, too
***************************************************************************************************************	
*/
class ProgressDialog extends Unknown
	{
	/**************************************************************************************************************
	Variable: CLSID
	This is CLSID_ProgressDialog. It is needed to create the object.
	***************************************************************************************************************	
	*/
	static CLSID := "{F8383852-FCD3-11d1-A6B9-006097DF5BD4}"
	
	/**************************************************************************************************************
	Variable: IID
	This is IID_IProgressDialog. It is also needed to create the object.
	***************************************************************************************************************	
	*/
	static IID := "{EBBC7C04-315E-11d2-B62F-006097DF5BD4}"

	/**************************************************************************************************************
	Function: StartProgressDialog
	starts displaying the progress dialog.
	
	Parameters:
		[opt] uint flags - a combination of flags modifying the dialog. You can use the fields of the PROGDLG class for convenience.
		[opt] handle hParent - the handle to a window to make the dialog box modal to. You must set the appropriate flags to make this work.
		
	Returns:
		bool success - true on success, false otherwise
		
	Example:
>	MyProgress.StartProgressDialog()
	***************************************************************************************************************	
	*/
	StartProgressDialog(flags := 0, hParent := 0){
		return this._Error(DllCall(NumGet(this.vt+03*A_PtrSize), "Ptr", this.ptr, "UInt", hParent, "Ptr", 0, "UInt", _flags, "UInt", 0))
		}
		
	/**************************************************************************************************************
	Function: StopProgressDialog
	stops displaying the dialog box.
	
	Returns:
		bool success - true on success, false otherwise
	
	Example:
>	MyProgress.StopProgressDialog()
	***************************************************************************************************************	
	*/	
	StopProgressDialog(){
		return this._Error(DllCall(NumGet(this.vt+04*A_PtrSize), "Ptr", this.ptr))
		}
	
	/**************************************************************************************************************
	Function: SetTitle
	sets the title of the dialog box, either before or while displaying it.
	
	Parameters:
		str title - the title to set.
		
	Returns:
		bool success - true on success, false otherwise
		
	Example:
>	MyProgress.SetTitle("my new title")
	***************************************************************************************************************	
	*/
	SetTitle(title){
		return this._Error(DllCall(NumGet(this.vt+05*A_PtrSize), "Ptr", this.ptr, "str", title))
		}
	
	/**************************************************************************************************************
	Function: HasUserCanceled
	checks whether the user canceled the dialog box.
	
	Returns:
		bool hasCanceled - true if the user canceled, false otherwise
	
	Example:
>	canceled := MyProgress.HasUserCanceled()
	***************************************************************************************************************	
	*/
	HasUserCanceled(){
		this._Error(0)
		return DllCall(NumGet(this.vt+07*A_PtrSize), "Ptr", this.ptr)
		}
	
	/**************************************************************************************************************
	Function: SetProgress
	sets the progress amount.
	
	Parameters:
		int percent - the new progress value, in percent
	
	Returns:
		bool success - true on success, false otherwise
	
	Example:
>	MyProgress.SetProgress(50)
	***************************************************************************************************************	
	*/
	SetProgress(percent){
		return this._Error(DllCall(NumGet(this.vt+08*A_PtrSize), "Ptr", this.ptr, "UInt", percent, "UInt", 100))
		}
	
	/**************************************************************************************************************
	Function: SetLine
	sets the text in a specific line of the dialog box.
	
	Parameters:
		int line - the line whose text should be set (1 - 3)
		str text - the text to set
	
	Returns:
		bool success - true on success, false otherwise
		
	Example:
>	MyProgress.SetLine(1, "This is line 1")
	***************************************************************************************************************	
	*/
	SetLine(line, text){
		return this._Error(DllCall(NumGet(this.vt+10*A_PtrSize), "Ptr", this.ptr, "UInt", line, "str", text, "UInt", 0, "UInt", 0))
		}
	
	/**************************************************************************************************************
	Function: SetCancelMsg
	sets the message that is displayed in the dialog box when the user cancels.
	
	Parameters:
		str text - the text to display
	
	Returns:
		bool success - true on success, false otherwise
	
	Example:
>	MyProgress.SetCancelMsg("You canceled")
	***************************************************************************************************************	
	*/
	SetCancelMsg(text){
		return this._Error(DllCall(NumGet(this.vt+11*A_PtrSize), "Ptr", this.ptr, "str", text, "UInt", 0))
		}
	
	/**************************************************************************************************************
	Function: Timer
	performs an action on the ProgressDialog's timer
	
	Parameters:
		uint action - the action to perform. You may use the fields of the PDTIMER class for convenience.
		
	Returns:
		bool success - true on success, false otherwise
		
	Remarks:
		Instead of specifying the operation, you may also use one of the methods <ResetTimer>, <PauseTimer> or <ResetTimer>.
	***************************************************************************************************************	
	*/
	Timer(action){
		return this._Error(DllCall(NumGet(this.vt+12*A_PtrSize), "Ptr", this.ptr, "UInt", action, "UInt", 0))
		}
	
	/**************************************************************************************************************
	Function: ResetTimer
	resets the timer the dialog box calculates to display the estimated remaining time.
	
	Returns:
		bool success - true on success, false otherwise
	
	Example:
>	MyProgress.ResetTimer()
	***************************************************************************************************************	
	*/
	ResetTimer(){
		return this._Error(DllCall(NumGet(this.vt+12*A_PtrSize), "Ptr", this.ptr, "UInt", PDTIMER.RESET, "UInt", 0))
		}
	
	/**************************************************************************************************************
	Function: PauseTimer
	pauses the timer in the dialog box. *It will also stop the progress bar, regardless of any call to <SetProgress>.*
	This remains until <ResumeTimer> is called.
	
	Returns:
		bool success - true on success, false otherwise
	
	Example:
>	MyProgress.PauseTimer()
	***************************************************************************************************************	
	*/
	PauseTimer(){
		return this._Error(DllCall(NumGet(this.vt+12*A_PtrSize), "Ptr", this.ptr, "UInt", PDTIMER.PAUSE, "UInt", 0))
		}
	
	/**************************************************************************************************************
	Function: ResumeTimer
	resumes the timer if it was previously paused.
	
	Returns:
		bool success - true on success, false otherwise
		
	Example:
>	MyProgress.ResumeTimer()
	***************************************************************************************************************	
	*/
	ResumeTimer() {
		return this._Error(DllCall(NumGet(this.vt+12*A_PtrSize), "Ptr", this.ptr, "UInt", PDTIMER.RESUME, "UInt", 0))
		}
	}
/*
group: dependencies & related
*/
/*
PDTIMER:
	This class requires the PDTIMER enumeration class **(auto-included)**.
*/
#include %A_ScriptDir%\..\Helper Classes\PDTIMER.ahk
/*
PROGDLG:
	You may use the fields of the PROGDLG enumeration class with this class **(not auto-included)**.
*/