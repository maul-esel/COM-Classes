/**************************************************************************************************************
class: ProgressDialog
exposes methods to create, control and display a progress dialog via COM interface IProgressDialog.

Requirements:
	- This requires AHK_L v1.1
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
		[opt] variant flags - see the Remarks.
		[opt] handle hParent - the handle to a window to make the dialog box modal to. You must set the appropriate flags.
		
	Returns:
		bool success - true on success, false otherwise
		
	Example:
>	MyProgress.StartProgressDialog()
		
	Remarks:
		For flags, you can either pass a binary combination or a combination of strings (separated by space or |). The valid flags are:
			Normal (0x00000000) - Normal progress dialog box behavior. [default]
			Modal (0x00000001) - The progress dialog box will be modal to the window specified by hwndParent. By default, a progress dialog box is modeless.
			AutoTime (0x00000002) - Automatically estimate the remaining time and display the estimate on line 3. If this flag is set, <SetLine> can be used only to display text on lines 1 and 2.
			NoTime (0x00000004) - Do not show the "time remaining" text.
			NoMinimize (0x00000008) - Do not display a minimize button on the dialog box's caption bar.
			NoProgressBar (0x00000010) - Do not display the progress bar.
			MarqueeProgress (0x00000020) - *Windows Vista and later.* Sets the progress bar to marquee mode.
			NoCancel (0x00000040) - *Windows Vista and later.* No cancel button (operation cannot be canceled).
	***************************************************************************************************************	
	*/
	StartProgressDialog(flags = 0, hParent = 0){
		static PROGDLG := { "normal" : 0x00000000, "modal" : 0x00000001, "autotime" : 0x00000002, "notime" : 0x00000004
							, "nominimize" : 0x00000008, "noprogressbar" : 0x00000010, "marqueeprogress" : 0x00000020, "nocancel" : 0x00000040 }
		if flags is not integer
			{
			_flags := 0
			Loop, Parse flags, %A_Space%|
				{
				if (PROGDLG.HasKey(A_LoopField))
					_flags |= PROGDLG[A_LoopField]
				}
			}
		else
			_flags := flags
	
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
		return this._Error(DllCall(NumGet(this.vt+05*A_PtrSize), "ptr", this.ptr, "str", this._ToUnicode(title)))
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
		return this._Error(DllCall(NumGet(this.vt+10*A_PtrSize), "Ptr", this.ptr, "UInt", line, (A_IsUnicode ? "str" : "ptr"), A_IsUnicode ? text : this._ToUnicode(text), "UInt", 0, "UInt", 0))
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
		return this._Error(DllCall(NumGet(this.vt+11*A_PtrSize), "Ptr", this.ptr, "ptr", this._ToUnicode(text), "UInt", 0))
		}
	
	/**************************************************************************************************************
	Function: Timer
	performs an action on the ProgressDialog's timer
	
	Parameters:
		variant action - the action to perform
		
	Returns:
		bool success - true on success, false otherwise
		
	Remarks:
		For action, you can either pass a string or its flag representation. Valid flags are:
		Reset (0x00000001) - the timer is resetted (default).
		Pause (0x00000002) - the timer is paused.
		Resume (0x00000003) - the timer is resumed.
	***************************************************************************************************************	
	*/
	Timer(action){
		static PDTimer := { "reset" : 0x00000001, "pause" : 0x00000002, "resume" : 0x00000003 }
		
		if action is not integer
			{
			if (PDTimer.HasKey(action))
				action := PDTimer[action]
			else
				action := PDTimer["reset"]
			}
	
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
		static PDTimer_RESET := 0x00000001
		return this._Error(DllCall(NumGet(this.vt+12*A_PtrSize), "Ptr", this.ptr, "UInt", PDTimer_RESET, "UInt", 0))
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
		static PDTimer_PAUSE := 0x00000002
		return this._Error(DllCall(NumGet(this.vt+12*A_PtrSize), "Ptr", this.ptr, "UInt", PDTimer_PAUSE, "UInt", 0))
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
		static PDTimer_RESUME := 0x00000003
		return this._Error(DllCall(NumGet(this.vt+12*A_PtrSize), "Ptr", this.ptr, "UInt", PDTimer_RESUME, "UInt", 0))
		}
	
	}