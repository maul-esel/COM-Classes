/**************************************************************************************************************
class: TaskbarList3
extends TaskbarList2

Requirements:
	- This requires AHK v2 alpha
	- It also requires Windows 7, Windows Server 2008 R2 or higher
***************************************************************************************************************	
*/

class TaskbarList3 extends TaskbarList2
	{
	/**************************************************************************************************************
	Variable: CLSID
	This is CLSID_TaskbarList. It is required to create the object.
	***************************************************************************************************************	
	*/
	static CLSID := "{56FDF344-FD6D-11d0-958A-006097C9A090}"
		
	/**************************************************************************************************************
	Variable: IID
	This is IID_ITaskbarList3. It is required to create the object.
	***************************************************************************************************************	
	*/
	static IID := "{ea1afb91-9e28-4b86-90e9-9e9f8a5eefaf}"
	
	/**************************************************************************************************************
	Function: SetProgressValue
	sets the current value of a taskbar progressbar

	Parameters:
		handle hWin - the window handle of your gui
		int value - the value to set, in percent

	Returns:
		bool success - true on success, false otherwise.
				
	Example:
>	Gui +LastFound
>	ITBL3.SetProgressValue(WinExist(), 50)
	***************************************************************************************************************	
	*/
	SetProgressValue(hWin, value)
	{
		return this._Error(DllCall(NumGet(this.vt+09*A_PtrSize), "Ptr", this.ptr, "uint", hWin, "int64", value, "int64", 100))
	}
	
	/**************************************************************************************************************
	Function: SetProgressState
	sets the current state and thus the color of a taskbar progressbar

	Parameters:
		handle hWin - the window handle of your gui
		uint state - the state to set. You may use the fields of the TBPFLAG class for convenience.

	Returns:
		bool success - true on success, false otherwise.

	Example:
>	ITBL3.SetProgressState(hWin, TBPFLAG.PAUSED)

	Remarks:
		- There's still a difference between setting progress to 0 or turning it off.
		- original function by Lexikos
	***************************************************************************************************************	
	*/
	SetProgressState(hWin, state)
	{
		return this._Error(DllCall(NumGet(this.vt+10*A_PtrSize), "Ptr", this.ptr, "uint", hWin, "uint", state))
	}
	/**************************************************************************************************************
	Function: RegisterTab
	Informs the taskbar that a new tab or document thumbnail has been provided for display in an application's taskbar group flyout.

	Parameters:
		handle hTab - the handle to the window to be registered as a tab
		handle hWin - the handle to thew window to hold the tab.
	
	Returns:
		bool success - true on success, false otherwise.
		
	Example:
>	ITBL3.RegisterTab(WinExist(), hWin)
	***************************************************************************************************************	
	*/	
	RegisterTab(hTab, hWin)
	{
		return this._Error(DllCall(NumGet(this.vt+11*A_PtrSize), "Ptr", this.ptr, "UInt", hTab, "UInt", hWin))
	}
	
	/**************************************************************************************************************
	Function: UnRegisterTab
	Removes a thumbnail from an application's preview group when that tab or document is closed in the application.

	Parameters:
		handle hTab - the handle to the window whose thumbnail gonna be removed.
	
	Returns:
		bool success - true on success, false otherwise.
		
	Example:
>	ITBL3.UnRegisterTab(WinExist("ahk_class AutoHotkey"))
	***************************************************************************************************************	
	*/
	UnRegisterTab(hTab)
	{
		return this._Error(DllCall(NumGet(this.vt+12*A_PtrSize), "Ptr", this.ptr, "UInt", hTab))
	}
	
	/**************************************************************************************************************
	Function: SetTabOrder
	Inserts a new thumbnail into an application's group flyout or moves an existing thumbnail
	to a new position in the application's group.

	Parameters:
		handle hTab - the handle to the window to be inserted or moved.
		handle hBefore - the handle of the tab window whose thumbnail that hwndTab is inserted to the left of.
	
	Returns:
		bool success - true on success, false otherwise.
		
	Example:
>	ITBL3.SetTabOrder(hGui)
	***************************************************************************************************************	
	*/
	SetTabOrder(hTab, hBefore := 0)
	{
		return this._Error(DllCall(NumGet(this.vt+13*A_PtrSize), "Ptr", this.ptr, "UInt", hTab, "UInt", hBefore))
	}
	
	/**************************************************************************************************************
	Function: SetTabActive
	Informs the taskbar that a tab or document window has been made the active window.

	Parameters:
		handle hTab - the handle to the tab to become active.
		handle hWin - the handle to the window holding that tab.
	
	Returns:
		bool success - true on success, false otherwise.
		
	Example:
>	ITBL3.SetTabActive(hGui1, hGui2)
	***************************************************************************************************************	
	*/
	SetTabActive(hTab, hWin)
	{
		return this._Error(DllCall(NumGet(this.vt+14*A_PtrSize), "Ptr", this.ptr, "UInt", hTab, "UInt", hWin, "UInt", 0))
	}
	
	/**************************************************************************************************************
	Function: ThumbBarAddButtons
	Adds a thumbnail toolbar with a specified set of buttons to the thumbnail image of a window in a taskbar button flyout.
	
	Parameters:
		handle hWin - the handle to the window to work on
		THUMBBUTTON[] array - an array of THUMBBUTTON instances (see the bottom of this page).
		
	Returns:
		bool success - true on success, false otherwise.
		
	Remarks:
		- You cannot delete buttons later, and you *cannot add buttons later*. Only call this method 1 time!
		- The array may not have more than 7 members.
	***************************************************************************************************************	
	*/
	ThumbBarAddButtons(hWin, array)
	{
		return this._Error(DllCall(NumGet(this.vt + 15 * A_PtrSize), "ptr", this.ptr, "UInt", hWin, "UInt", array.MaxIndex(), "UPtr", this.ParseArray(array)))
	}
	
	/**************************************************************************************************************
	Function: ThumbBarUpdateButtons
	Shows, enables, disables, or hides buttons in a thumbnail toolbar as required by the window's current state.
	
	Parameters:
		handle hWin - the handle to the window to work on
		THUMBBUTTON[] array - an array of THUMBBUTTON instances (see the bottom of this page).
		
	Returns:
		bool success - true on success, false otherwise.
	***************************************************************************************************************	
	*/
	ThumbBarUpdateButtons(hWin, array)
	{
		return this._Error(DllCall(NumGet(this.vt + 16 * A_PtrSize), "ptr", this.ptr, "UInt", hWin, "UInt", array.MaxIndex(), "UPtr", this.ParseArray(array)))
	}

	; private method: parses an array of AHK THUMBBUTTON instances to an array of THUMBBUTTON structures
	ParseArray(array)
	{
		static item_size := A_PtrSize + 536
		local count, struct

		count := array.MaxIndex()
		if (count > 7)
			count := 7
		
		VarSetCapacity(struct, item_size * count, 0)
		for i, button in array ; loop through all button definitions
		{
			NumPut(button.dwMask,	struct,		000 + 0 * A_PtrSize + item_size * (A_Index - 1),	"UInt")
			NumPut(button.iId,		struct,		004 + 0 * A_PtrSize + item_size * (A_Index - 1),	"UInt")
			NumPut(button.iBitmap,	struct,		008 + 0 * A_PtrSize + item_size * (A_Index - 1),	"UInt")
			NumPut(button.hIcon,	struct,		012 + 0 * A_PtrSize + item_size * (A_Index - 1),	"UPtr")
			StrPut(button.szTip,	&struct	+	012 + 1 * A_PtrSize + item_size * (A_Index - 1),	260)
			NumPut(button.dwFlags,	struct,		532 + 1 * A_PtrSize + item_size * (A_Index - 1),	"UInt")
			 
			if (A_Index == 7) ; only 7 buttons allowed
				break
		}

		return &struct
	}
	
	/**************************************************************************************************************
	Function: ThumbBarSetImageList
	Specifies an image list that contains button images for the toolbar
	
	Parameters:
		handle hWin - the handle to the window to work on
		HImageList il - the handle to the imagelist
		
	Returns:
		bool success - true on success, false otherwise.
	***************************************************************************************************************	
	*/
	ThumbBarSetImageList(hWin, il)
	{
		return this._Error(DllCall(NumGet(this.vt+17*A_PtrSize), "Ptr", this.ptr, "uint", hWin, "uint", il))
	}
	
	/**************************************************************************************************************
	Function: SetOverlayIcon
	set the overlay icon for a taskbar button

	params:
		handle hGui - the window handle of your gui
		hIcon Icon - handle to an icon
		str altText - an alt text version of the information conveyed by the overlay, for accessibility purposes.

	Returns:
		bool success - true on success, false otherwise.
		
	Example:
>	ITBL3.SetOverlayIcon(WinExist(), DllCall("LoadIcon", "UInt", 0, "UInt", 32516), "an overlay icon")
	
	Remarks:
		- To get a hIcon, you might use LoadImage (<http://msdn.microsoft.com/de-de/library/ms648045>)
	***************************************************************************************************************	
	*/
	SetOverlayIcon(hWin, Icon, altText := "")
	{
		return this._Error(DllCall(NumGet(this.vt+18*A_PtrSize), "Ptr", this.ptr, "uint", hWin, "uint", Icon, "str", altText))
	}
	
	/**************************************************************************************************************
	Function: SetThumbnailTooltip
	set a custom tooltip for your thumbnail

	Parameters:
		handle hGui - the window handle of your gui
		str Tooltip - the text to set as your tooltip
			
	Returns:
		bool success - true on success, false otherwise.
		
	Example:
>	ITBL3.SetThumbnailTooltip(WinExist(), "my custom tooltip")
	***************************************************************************************************************	
	*/
	SetThumbnailTooltip(hWin, Tooltip)
	{
		return this._Error(DllCall(NumGet(this.vt+19*A_PtrSize), "Ptr", this.ptr, "UInt", hWin, "str", Tooltip))
	}
	
	/**************************************************************************************************************
	Function: SetThumbnailClip
	limit the taskbar thumbnail of a gui to a specified size instead of the whole window

	Parameters:
		handle hGui - the window handle of your gui
		RECT clip - a RECT instance describing the area to show in the taskbar thumbnail

	Returns:
		bool success - true on success, false otherwise.
		
	Example:
>	ITBL3.SetThumbnailClip(hGui, new RECT(0, 0, 100, 100))
	***************************************************************************************************************	
	*/
	SetThumbnailClip(hWin, clip)
	{
		return this._Error(DllCall(NumGet(this.vt+20*A_PtrSize), "Ptr", this.ptr, "UInt", hWin, "UPtr", clip.ToStructPtr()))
	}
		
	/**************************************************************************************************************
	group: More about thumbbar buttons
	
	Reacting to clicks:	
	To react, you must monitor the WM_Command message.
>	OnMessage(0x111, "WM_COMMAND")
>
>	; ... add the thumbbuttons
>
>	WM_COMMAND(wp){
>		static THBN_CLICKED := 0x1800
>		if (HIWORD(wp) = THBN_CLICKED)
>			Msgbox 64,,% "The button with the id " . LOWORD(wp) . " was clicked.", 3
>		}
>
>	HIWORD(lparam){ ; these functions were copied from windows header files
>		return lparam >> 16
>		}
>
>	LOWORD(lparam){
>		return lparam & 0xFFFF
>		}
	***************************************************************************************************************	
	*/
	}