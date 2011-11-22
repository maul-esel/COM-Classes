/*
class: THUMBBUTTON
This class represents a THUMBBUTTON struct (<http://msdn.microsoft.com/en-us/library/windows/desktop/dd391559.aspx>)
The THUMBBUTTON structure defines buttons used in a toolbar embedded in a window's thumbnail representation.
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
	converts the instance to a script-usable struct

	Returns:
		ptr - a pointer to the struct in memory
	*/
	ToStructPtr()
	{
		local struct
		VarSetCapacity(struct, 16 + A_PtrSize + 520, 0)

		NumPut(this.dwMask,		struct,	000+0*A_PtrSize,	"UInt")
		NumPut(this.iId,		struct,	004+0*A_PtrSize,	"UInt")
		NumPut(this.iBitmap,	struct,	008+0*A_PtrSize,	"UInt")
		NumPut(this.hIcon,		struct,	012+0*A_PtrSize,	"UPtr")
		StrPut(this.szTip,		&struct+012+1*A_PtrSize,	260)
		NumPut(this.dwFlags,	struct,	532+1*A_PtrSize,	"UInt")

		return &struct
	}

	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class

	Returns:
		instance - the new THUMBBUTTON instance
	*/
	FromStructPtr(ptr)
	{
		local instance := new THUMBBUTTON()

		instance.dwMask		:=	NumGet(ptr,	000+0*A_PtrSize,	"UInt")
		instance.iId		:=	NumGet(ptr,	004+0*A_PtrSize,	"UInt")
		instance.iBitmap	:=	NumGet(ptr,	008+0*A_PtrSize,	"UInt")
		instance.hIcon		:=	NumGet(ptr,	012+0*A_PtrSize,	"UPtr")
		instance.szTip		:=	StrGet(ptr +012+1*A_PtrSize,	260)
		instance.dwFlags	:=	NumGet(ptr,	272+1*A_PtrSize,	"UInt")

		return instance
	}
}