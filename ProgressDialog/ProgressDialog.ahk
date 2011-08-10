/**************************************************************************************************************
class: ProgressDialog
exposes methods to create, control and display a progress dialog via COM interface IProgressDialog.

Requirements:
	- This requires AHK v2 alpha (may also work with v1.1)
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
		[opt] uint flags - any binary combination of the flags listed in the Remarks.
		[opt] handle hParent - the handle to a window to make the dialog box modal to. You must set the appropriate flags.
		
	Returns:
		bool success - true on success, false otherwise
		
	Example:
>	MyProgress.StartProgressDialog()
		
	Remarks (valid flags):
			PROGDLG_NORMAL (0x00000000) - Normal progress dialog box behavior. [default]
			PROGDLG_MODAL (0x00000001) - The progress dialog box will be modal to the window specified by hwndParent. By default, a progress dialog box is modeless.
			PROGDLG_AUTOTIME (0x00000002) - Automatically estimate the remaining time and display the estimate on line 3. If this flag is set, <SetLine> can be used only to display text on lines 1 and 2.
			PROGDLG_NOTIME (0x00000004) - Do not show the "time remaining" text.
			PROGDLG_NOMINIMIZE (0x00000008) - Do not display a minimize button on the dialog box's caption bar.
			PROGDLG_NOPROGRESSBAR (0x00000010) - Do not display the progress bar.
			
			PROGDLG_MARQUEEPROGRESS (0x00000020) - *Windows Vista and later.* Sets the progress bar to marquee mode. This causes the progress bar to scroll horizontally, similar to a marquee display. Use this when you wish to indicate that progress is being made, but the time required for the operation is unknown.
			PROGDLG_NOCANCEL (0x00000040) - *Windows Vista and later.* No cancel button (operation cannot be canceled). Use this only when absolutely necessary.
	***************************************************************************************************************	
	*/
	StartProgressDialog(flags=0, hParent=0){
		return this.__Error(DllCall(NumGet(this.vt+03*A_PtrSize), "Ptr", this.ptr, "UInt", hParent, "Ptr", 0, "UInt", flags, "UInt", 0))
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
		return this.__Error(DllCall(NumGet(this.vt+04*A_PtrSize), "Ptr", this.ptr))
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
		return this.__Error(DllCall(NumGet(this.vt+05*A_PtrSize), "Ptr", this.ptr, "str", title))
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
		this.__Error(0)
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
		return this.__Error(DllCall(NumGet(this.vt+08*A_PtrSize), "Ptr", this.ptr, "UInt", percent, "UInt", 100))
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
		return this.__Error(DllCall(NumGet(this.vt+10*A_PtrSize), "Ptr", this.ptr, "UInt", line, "str", text, "UInt", 0, "UInt", 0))
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
		return this.__Error(DllCall(NumGet(this.vt+11*A_PtrSize), "Ptr", this.ptr, "str", msg, "UInt", 0))
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
		return this.__Error(DllCall(NumGet(this.vt+12*A_PtrSize), "Ptr", this.ptr," UInt", 0x00000001, "UInt", 0))
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
	PauseTimer() {
		return this.__Error(DllCall(NumGet(this.vt+12*A_PtrSize), "Ptr", this.ptr," UInt", 0x00000002, "UInt", 0))
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
		return this.__Error(DllCall(NumGet(this.vt+12*A_PtrSize), "Ptr", this.ptr," UInt", 0x00000003, "UInt", 0))
		}
	
	}