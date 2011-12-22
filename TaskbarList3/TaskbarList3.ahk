/*
class: TaskbarList3
implements the ITaskbarList3 interface and exposes methods that support the unified launching and switching taskbar button functionality added in Windows 7. This functionality includes thumbnail representations and switch targets based on individual tabs in a tabbed application, thumbnail toolbars, notification and status overlays, and progress indicators.

Requirements:
	AutoHotkey - AHK_L v1.1+
	OS - Windows 7, Windows Server 2008 R2 or higher
	Base classes - Unknown, TaskbarList, TaskbarList2
	Helper classes - TBPFLAG, THUMBBUTTON, RECT

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/dd391692)
*/
class TaskbarList3 extends TaskbarList2
{
	/*
	Field: CLSID
	This is CLSID_TaskbarList. It is required to create an instance.
	*/
	static CLSID := "{56FDF344-FD6D-11d0-958A-006097C9A090}"

	/*
	Field: IID
	This is IID_ITaskbarList3. It is required to create an instance.
	*/
	static IID := "{ea1afb91-9e28-4b86-90e9-9e9f8a5eefaf}"

	/*
	Method: SetProgressValue
	sets the current value of a taskbar progressbar

	Parameters:
		HWND hWin - the window handle of your gui
		INT value - the value to set, in percent

	Returns:
		BOOL success - true on success, false otherwise.

	Example:
		(start code)
		ITBL3 := new TaskbarList3()
		ITBL3.HrInit()
		Gui +LastFound
		ITBL3.SetProgressValue(WinExist(), 50)
		(end code)
	*/
	SetProgressValue(hWin, value)
	{
		return this._Error(DllCall(NumGet(this.vt+09*A_PtrSize), "Ptr", this.ptr, "uint", hWin, "int64", value, "int64", 100))
	}

	/*
	Method: SetProgressState
	sets the current state and thus the color of a taskbar progressbar

	Parameters:
		HWND hWin - the window handle of your gui
		UINT state - the state to set. You may use the fields of the TBPFLAG class for convenience.

	Returns:
		BOOL success - true on success, false otherwise.

	Example:
		(start code)
		ITBL3 := new TaskbarList3()
		ITBL3.HrInit()
		Gui +LastFound
		ITBL3.SetProgressState(hWin, TBPFLAG.PAUSED)
		(end code)

	Remarks:
		- There's still a difference between setting progress to 0 or turning it off.
		- original function by Lexikos
	*/
	SetProgressState(hWin, state)
	{
		return this._Error(DllCall(NumGet(this.vt+10*A_PtrSize), "Ptr", this.ptr, "uint", hWin, "uint", state))
	}

	/*
	Method: RegisterTab
	Informs the taskbar that a new tab or document thumbnail has been provided for display in an application's taskbar group flyout.

	Parameters:
		HWND hTab - the handle to the window to be registered as a tab
		HWND hWin - the handle to thew window to hold the tab.

	Returns:
		BOOL success - true on success, false otherwise.

	Example:
		(start code)
		ITBL3 := new TaskbarList3()
		ITBL3.HrInit()
		ITBL3.RegisterTab(WinExist("Firefox"), WinExist())
		(end code)
	*/	
	RegisterTab(hTab, hWin)
	{
		return this._Error(DllCall(NumGet(this.vt+11*A_PtrSize), "Ptr", this.ptr, "UInt", hTab, "UInt", hWin))
	}

	/*
	Method: UnRegisterTab
	Removes a thumbnail from an application's preview group when that tab or document is closed in the application.

	Parameters:
		HWND hTab - the handle to the window whose thumbnail gonna be removed.

	Returns:
		BOOL success - true on success, false otherwise.

	Example:
		(start code)
		ITBL3 := new TaskbarList3()
		ITBL3.HrInit()
		ITBL3.UnRegisterTab(WinExist("ahk_class AutoHotkey"))
		(end code)
	*/
	UnRegisterTab(hTab)
	{
		return this._Error(DllCall(NumGet(this.vt+12*A_PtrSize), "Ptr", this.ptr, "UInt", hTab))
	}

	/*
	Method: SetTabOrder
	Inserts a new thumbnail into an application's group flyout or moves an existing thumbnail to a new position in the application's group.

	Parameters:
		HWND hTab - the handle to the window to be inserted or moved.
		HWND hBefore - the handle of the tab window whose thumbnail that hwndTab is inserted to the left of.

	Returns:
		BOOL success - true on success, false otherwise.

	Example:
		(start code)
		ITBL3 := new TaskbarList3()
		ITBL3.HrInit()
		ITBL3.SetTabOrder(WinExist("ahk_class AutoHotkey"))
		(end code)
	*/

	SetTabOrder(hTab, hBefore = 0)
	{
		return this._Error(DllCall(NumGet(this.vt+13*A_PtrSize), "Ptr", this.ptr, "UInt", hTab, "UInt", hBefore))
	}

	/*
	Method: SetTabActive
	Informs the taskbar that a tab or document window has been made the active window.

	Parameters:
		HWND hTab - the handle to the tab to become active.
		HWND hWin - the handle to the window holding that tab.

	Returns:
		BOOL success - true on success, false otherwise.

	Example:
		(start code)
		ITBL3 := new TaskbarList3()
		ITBL3.HrInit()
		ITBL3.SetTabActive(WinExist("ahk_class AutoHotkey"), WinExist())
		(end code)
	*/
	SetTabActive(hTab, hWin)
	{
		return this._Error(DllCall(NumGet(this.vt+14*A_PtrSize), "Ptr", this.ptr, "UInt", hTab, "UInt", hWin, "UInt", 0))
	}

	/*
	Method: ThumbBarAddButtons
	Adds a thumbnail toolbar with a specified set of buttons to the thumbnail image of a window in a taskbar button flyout.

	Parameters:
		HWND hWin - the handle to the window to work on
		THUMBBUTTON[] array - an array of THUMBBUTTON instances (see the bottom of this page).

	Returns:
		BOOL success - true on success, false otherwise.

	Remarks:
		- You cannot delete buttons later, and you *cannot add buttons later*. Only call this method 1 time!
		- The array may not have more than 7 members.
	*/
	ThumbBarAddButtons(hWin, array)
	{
		return this._Error(DllCall(NumGet(this.vt + 15 * A_PtrSize), "ptr", this.ptr, "uptr", hWin, "UInt", array.MaxIndex(), "UPtr", this.ParseArray(array)))
	}

	/*
	Method: ThumbBarUpdateButtons
	Shows, enables, disables, or hides buttons in a thumbnail toolbar as required by the window's current state.

	Parameters:
		HWND hWin - the handle to the window to work on
		THUMBBUTTON[] array - an array of THUMBBUTTON instances (see the bottom of this page).

	Returns:
		BOOL success - true on success, false otherwise.
	*/
	ThumbBarUpdateButtons(hWin, array)
	{
		return this._Error(DllCall(NumGet(this.vt + 16 * A_PtrSize), "ptr", this.ptr, "uptr", hWin, "UInt", array.MaxIndex(), "UPtr", this.ParseArray(array)))
	}

	/*
	Method: ThumbBarSetImageList
	Specifies an image list that contains button images for the toolbar

	Parameters:
		HWND hWin - the handle to the window to work on
		HIMAGELIST il - the handle to the imagelist

	Returns:
		BOOL success - true on success, false otherwise.
	*/
	ThumbBarSetImageList(hWin, il)
	{
		return this._Error(DllCall(NumGet(this.vt+17*A_PtrSize), "Ptr", this.ptr, "uint", hWin, "uint", il))
	}

	/*
	Method: SetOverlayIcon
	set the overlay icon for a taskbar button

	Parameters:
		HWND hGui - the window handle of your gui
		HICON Icon - handle to an icon
		[opt] STR altText - an alt text version of the information conveyed by the overlay, for accessibility purposes.

	Returns:
		BOOL success - true on success, false otherwise.

	Remarks:
		To get a HICON, you might use LoadImage (http://msdn.microsoft.com/de-de/library/ms648045).

	Example:
		(start code)
		ITBL3 := new TaskbarList3()
		ITBL3.HrInit()
		ITBL3.SetOverlayIcon(WinExist(), DllCall("LoadIcon", "UInt", 0, "UInt", 32516), "an overlay icon")
		(end code)
	*/
	SetOverlayIcon(hWin, Icon, altText = "")
	{
		return this._Error(DllCall(NumGet(this.vt+18*A_PtrSize), "Ptr", this.ptr, "uint", hWin, "uint", Icon, "wstr", altText))
	}

	/*
	Method: SetThumbnailTooltip
	set a custom tooltip for your thumbnail

	Parameters:
		HWND hGui - the window handle of your gui
		STR Tooltip - the text to set as your tooltip

	Returns:
		BOOL success - true on success, false otherwise.

	Example:
		(start code)
		ITBL3 := new TaskbarList3()
		ITBL3.HrInit()
		ITBL3.SetThumbnailTooltip(WinExist(), "my custom tooltip")
		(end code)
	*/
	SetThumbnailTooltip(hWin, Tooltip)
	{
		return this._Error(DllCall(NumGet(this.vt+19*A_PtrSize), "Ptr", this.ptr, "UInt", hWin, "wstr", Tooltip))
	}

	/*
	Method: SetThumbnailClip
	limit the taskbar thumbnail of a gui to a specified size instead of the whole window

	Parameters:
		HWND hGui - the window handle of your gui
		RECT clip - a RECT instance describing the area to show in the taskbar thumbnail

	Returns:
		BOOL success - true on success, false otherwise.

	Example:
		(start code)
		ITBL3 := new TaskbarList3()
		ITBL3.HrInit()
		Gui +LastFound
		ITBL3.SetThumbnailClip(WinExist(), new RECT(0, 0, 100, 100))
		(end code)
	*/
	SetThumbnailClip(hWin, clip)
	{
		return this._Error(DllCall(NumGet(this.vt+20*A_PtrSize), "Ptr", this.ptr, "UInt", hWin, "UPtr", clip.ToStructPtr()))
	}

	/*
	group: private methods

	Method: ParseArray
	parses an array of AHK THUMBBUTTON class instances to an array of THUMBBUTTON memory structures

	Parameters:
		THUMBBUTTON[] array - an array of THUMBBUTTON instances (see the bottom of this page).

	Returns:
		UPTR pointer - the pointer to the array in memory
	*/
	ParseArray(array)
	{
		static item_size := A_PtrSize + 536, struct
		local count := array.MaxIndex()

		if (count > 7)
			count := 7

		VarSetCapacity(struct, item_size * count, 0)
		for each, button in array ; loop through all button definitions
		{
			button.ToStructPtr(&struct + item_size * (A_Index - 1))

			if (A_Index == 7) ; only 7 buttons allowed
				break
		}

		return &struct
	}
		
	/*
	group: More about thumbbar buttons

	Reacting to clicks:	
	To react, you must monitor the WM_Command message.
	(start code)
	OnMessage(0x111, "WM_COMMAND")

	; ... add the thumbbuttons & show

	WM_COMMAND(wp)
	{
		static THBN_CLICKED := 0x1800
		if (HIWORD(wp) = THBN_CLICKED)
			Msgbox 64,,% "The button with the id " . LOWORD(wp) . " was clicked.", 3
	}

	; these functions below were copied from windows header files
	HIWORD(lparam)
	{
		return lparam >> 16
	}

	LOWORD(lparam)
	{
		return lparam & 0xFFFF
	}
	(end code)
	*/
}
