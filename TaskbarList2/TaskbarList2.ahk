/**************************************************************************************************************
class: TaskbarList2
extends TaskbarList

Requirements:
	- This requires AHK v2 alpha
	- It also requires Windows XP, Windows 2000 Server or higher
***************************************************************************************************************	
*/
class TaskbarList2 extends TaskbarList
	{
	/**************************************************************************************************************
	Variable: CLSID
	This is CLSID_TaskbarList. It is required to create the object.
	***************************************************************************************************************	
	*/
	static CLSID := "{56FDF344-FD6D-11d0-958A-006097C9A090}"
		
	/**************************************************************************************************************
	Variable: IID
	This is IID_ITaskbarList2. It is required to create the object.
	***************************************************************************************************************	
	*/
	static IID := "{602D4995-B13A-429b-A66E-1935E44F4317}"
	
	/**************************************************************************************************************
	Function: MarkFullScreen
	Marks a window as full-screen.

	Parameters:
		handle hGui - the window handle of your gui
		bool ApplyRemove - determines whether to apply or remove fullscreen property

	Returns:
		bool success - true on success, false otherwise.
		
	Example:
>	Gui 2: +LastFound
>	ITBL2.MarkFullScreen(WinExist())
	***************************************************************************************************************	
	*/
	MarkFullScreen(hWin, ApplyRemove){
		return this.__Error(DllCall(NumGet(this.vt+08*A_PtrSize), "Ptr", this.ptr, "Uint", hWin, "UInt", ApplyRemove))
		}
	}