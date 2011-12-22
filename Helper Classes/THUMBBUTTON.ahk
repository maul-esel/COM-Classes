/*
class: THUMBBUTTON
defines buttons used in a toolbar embedded in a window's thumbnail representation.

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/dd391559)
*/
class THUMBBUTTON
{
	/*
	Field: dwMask
	A combination of THUMBBUTTONMASK values that specify which members of this structure contain valid data; other members are ignored, with the exception of <iId>, which is always required.
	*/
	dwMask := 0

	/*
	Field: iId
	The application-defined identifier (UINT) of the button, unique within the toolbar.
	*/
	iId := 0

	/*
	Field: iBitmap
	The zero-based index of the button image within the image list set through ITaskbarList3::ThumbBarSetImageList.
	*/
	iBitmap := 0

	/*
	Field: hIcon
	The handle of an icon to use as the button image.
	*/
	hIcon := 0

	/*
	Field: szTip
	A wide character array that contains the text of the button's tooltip, displayed when the mouse pointer hovers over the button. Not more than 260 characters.
	*/
	szTip := ""

	/*
	Field: dwFlags
	A combination of THUMBBUTTONFLAGS values that control specific states and behaviors of the button.
	*/
	dwFlags := 0

	/*
	Method: ToStructPtr
	converts the instance to a script-usable struct and returns its memory adress.

	Parameters:
		[opt] UPTR ptr - the fixed memory address to copy the struct to.

	Returns:
		UPTR ptr - a pointer to the struct in memory
	*/
	ToStructPtr(ptr := 0)
	{
		static struct

		if (!ptr)
		{
			VarSetCapacity(struct, A_PtrSize + 536, 0)
			ptr := &struct
		}

		NumPut(this.dwMask,		1*ptr,	000+0*A_PtrSize,	"UInt")
		NumPut(this.iId,		1*ptr,	004+0*A_PtrSize,	"UInt")
		NumPut(this.iBitmap,	1*ptr,	008+0*A_PtrSize,	"UInt")
		NumPut(this.hIcon,		1*ptr,	012+0*A_PtrSize,	"UPtr")
		StrPut(this.szTip,		1*ptr + 012+1*A_PtrSize,	260,	"UTF-16")
		NumPut(this.dwFlags,	1*ptr,	532+1*A_PtrSize,	"UInt")

		return ptr
	}

	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class

	Parameters:
		UPTR ptr - a pointer to a THUMBBUTTON struct in memory

	Returns:
		THUMBBUTTON instance - the new THUMBBUTTON instance
	*/
	FromStructPtr(ptr)
	{
		local instance := new THUMBBUTTON()

		instance.dwMask		:=	NumGet(1*ptr,	000+0*A_PtrSize,	"UInt")
		instance.iId		:=	NumGet(1*ptr,	004+0*A_PtrSize,	"UInt")
		instance.iBitmap	:=	NumGet(1*ptr,	008+0*A_PtrSize,	"UInt")
		instance.hIcon		:=	NumGet(1*ptr,	012+0*A_PtrSize,	"UPtr")
		instance.szTip		:=	StrGet(1*ptr  + 012+1*A_PtrSize,	260,	"UTF-16")
		instance.dwFlags	:=	NumGet(1*ptr,	272+1*A_PtrSize,	"UInt")

		return instance
	}
}