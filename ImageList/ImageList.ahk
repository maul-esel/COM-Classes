/**************************************************************************************************************
class: ImageList
exposes methods to manage image lists via COM interface IImageList.

Requirements:
	- This requires AHK v2 alpha
	- the Unknown class is also required
	- Windows XP / Windows Server 2003 or higher
	
Remarks:
	- functions which receive bitmaps as parameters usually call DeleteObject() on them.
	- to get a HBITMAP or a HICON, use a DllCall to LoadImageW, LoadBitmapW, LoadIconW, LoadCursorW, ...
	- the HIMAGELIST (e.g. for LV_SetImageList() or IL_xxx functions) handle can be obtained using ImageList.ptr
***************************************************************************************************************
*/
class ImageList extends Unknown
{
	/**************************************************************************************************************
	Variable: CLSID
	This is CLSID_ImageList.
	***************************************************************************************************************
	*/
	static CLSID := "{7C476BA2-02B1-48f4-8048-B24619DDC058}"
	
	/**************************************************************************************************************
	Variable: IID
	This is IID_IImageList
	***************************************************************************************************************
	*/
	static IID := "{46EB5926-582E-4017-9FDF-E8998DAA0950}"
	
	/**************************************************************************************************************
	Variable: hModule
	The module handle returned by LoadLibrary()
	***************************************************************************************************************
	*/
	static hModule := DllCall("LoadLibrary", "str", "Comctl32.dll")
	
	/**************************************************************************************************************
	group: Constructors
	
	Function: FromHIMAGELIST
	creates a new instance for a given HIMAGELIST handle.
	
	Parameters:
		[opt] HIMAGELIST il - the handle to the image list as returned by IL_Create(). If omitted, a new image list is created
		
	Remarks:
		Although you can create an instance using the usual way:
>>		myIL := new ImageList
		it is recommended to create an instance from this function:
>>		myIL := ImageList.FromHIMAGELIST(IL_CREATE())
		
		The given handle can be obtained using
>>		handle := myIL.Handle
	***************************************************************************************************************
	*/
	FromHIMAGELIST(il := 0)
	{
		if (il == 0)
			il := IL_Create()

		DllCall("Comctl32.dll\HIMAGELIST_QueryInterface", "uint", il, "uint", this._GUID(i, this.IID), "ptr*", ptr)
		return new ImageList(ptr)
	}
	
	/**************************************************************************************************************
	group: IImageList
	
	Function: Add
	adds a bitmap image to an ImageList instance.
	
	Parameters:
		HBITMAP bitmap - the bitmap to add
		[opt] HBITMAP maskbitmap - the bitmap to use as a mask
		
	Returns:
		int index - the new (zero-based) index of the image
		
	Remarks:
		IImageList::Add copies the bitmap to an internal data structure.
		You must use the DeleteObject function to delete bitmap and maskbitmap when you don't need them anymore:
>>		DllCall("Gdi32\DeleteObject", "uint", bitmap)
	***************************************************************************************************************
	*/
	Add(bitmap, maskbitmap := 0)
	{
		this._Error(DllCall(NumGet(this.vt+3*A_PtrSize), "ptr", this.ptr, "uint", bitmap, "uint", maskbitmap, "int*", int))
		return int
	}
	
	/**************************************************************************************************************
	Function: ReplaceIcon
	replaces an icon in the image list or adds a new one.
	
	Parameters:
		HICON hIcon - the icon to add
		[opt] int index - the index of the icon to be replaced. Leave this empty or use -1 to append the icon to the list.
		
	Returns:
		int index - the new image list index of the icon
	***************************************************************************************************************
	*/
	ReplaceIcon(hIcon, index := -1)
	{
		this._Error(DllCall(NumGet(this.vt+4*A_PtrSize), "ptr", this.ptr, "int", index, "uint", hIcon, "int*", int))
		return int
	}
	
	/**************************************************************************************************************
	Function: SetOverlayImage
	sets the overly image for an image.
	To make it visible, you must also call <Draw> and set the fStyle parameter appropriately.
	
	Parameters:
		int image - the zero-based index of the image to work on
		int overlay - the one-based index of the image to set as overlay image
		
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************
	*/
	SetOverlayImage(image, overlay)
	{
		return this._Error(DllCall(NumGet(this.vt+5*A_PtrSize), "ptr", this.ptr, "int", image, "int", overlay))
	}
	
	/**************************************************************************************************************
	Function: Replace
	replaces an image in the image list with a new one
	
	Parameters:
		int index - the image to be replaced
		HBITMAP bitmap - the new image
		[opt] HBITMAP maskbitmap - the optional mask bitmap for the new image
		
	Returns:
		bool success - true on success, false otherwise
		
	Remarks:
		IImageList::Replace copies the bitmap to an internal data structure.
		You must use the DeleteObject function to delete bitmap and maskbitmap when you don't need them anymore:
>>		DllCall("Gdi32\DeleteObject", "uint", bitmap)
	***************************************************************************************************************
	*/
	Replace(index, bitmap, maskbitmap := 0)
	{
		return this._Error(DllCall(NumGet(this.vt+6*A_PtrSize), "ptr", this.ptr, "int", index, "uint", bitmap, "uint", maskbitmap))
	}
	
	/**************************************************************************************************************
	Function: AddMasked
	Adds an image or images to an image list, generating a mask from the specified bitmap.
	
	Parameters:
		HBITMAP bitmap - the bitmap to add
		COLORREF color - the mask color (e.g. 0xFF0000)
		
	Returns:
		int index - the new index of the image
		
	Remarks:
		IImageList::AddMasked copies the bitmap to an internal data structure.
		You must use the DeleteObject function to delete bitmap and color when you don't need them anymore:
>>		DllCall("Gdi32\DeleteObject", "uint", bitmap)
	***************************************************************************************************************
	*/
	AddMasked(bitmap, color)
	{
		this._Error(DllCall(NumGet(this.vt+7*A_PtrSize), "ptr", this.ptr, "uint", bitmap, "uint", color, "int*", int))
		return int
	}
	
	/**************************************************************************************************************
	Function: Draw
	Draws an image list item in the specified device context.
	
	Parameters:
		ILDRAWPARAMS params - either a **pointer** to a valid struct or an instance of the ILDRAWPARAMS class, specifying the options.
		
	Returns:
		bool success - true on success, false otherwise
		
	Remarks:
		- The cbSize and himl members of the parameter are overwritten
		- The i and hdcDst members of the parameter are required
	***************************************************************************************************************
	*/
	Draw(params)
	{
		if (IsObject(params))
			struct := params.ToStructPtr()
		else
			struct := params
			
		NumPut(2 * A_PtrSize + 15 * 4,	struct,	00, "UInt") ; overwrite cbSize & himl
		NumPut(this.ptr,	struct,		04, "UPtr")
		
		return this._Error(DllCall(NumGet(this.vt+8*A_PtrSize), "ptr", this.ptr, "ptr", struct))
	}
	
	/**************************************************************************************************************
	Function: Remove
	Removes an image from an image list. 
	
	Parameters:
		int index - the index of the icon to be removed
		
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************
	*/
	Remove(index)
	{
		return this._Error(DllCall(NumGet(this.vt+9*A_PtrSize), "ptr", this.ptr, "int", index))
	}
	
	/**************************************************************************************************************
	Function: GetIcon
	Creates an icon from an image and a mask in an image list.
	
	Parameters:
		int index - the index of the image to use
		uint flags - a combination of flags to be used. You can use the values in the IMAGELISTDRAWFLAGS class and combine them using the "|" operator
		
	Returns:
		HICON icon - the generated icon
	***************************************************************************************************************
	*/
	GetIcon(index, flags)
	{
		this._Error(DllCall(NumGet(this.vt+10*A_PtrSize), "ptr", this.ptr, "int", index, "uint", flags, "uint*", hIcon))
		return hIcon
	}
	
	/**************************************************************************************************************
	Function: GetImageInfo
	gets information about an image
	
	Parameters:
		int index - the index of the image to work on
		
	Returns:
		IMAGEINFO info - an IMAGEINFO instance containing the information.
	
	Remarks:
		The IMAGEINFO class is documented <here at IMAGEINFO.html>.
		To retrieve information about the RECT use something like:
>		top := myIL.GetImageInfo(0).rcImage.top
	***************************************************************************************************************
	*/
	GetImageInfo(index)
	{
		VarSetCapacity(info, 2*A_PtrSize + 24, 0)
		this._Error(DllCall(NumGet(this.vt+11*A_PtrSize), "ptr", this.ptr, "int", index, "ptr", &info))
		return IMAGEINFO.FromStructPtr(&info)
	}
	
	/**************************************************************************************************************
	Function: Copy
	Copies images from a given ImageList instance.
	
	Parameters:
		int iDest - the index the image should be copied to
		int iSrc - the index of the source image
		bool swap - true to swap the images, false to move only the destination to the source
		
	Remarks:
		*NOT WORKING!*
	***************************************************************************************************************
	*/
	Copy(iDest, iSrc, swap)
	{
		return this._Error(DllCall(NumGet(this.vt+12*A_PtrSize), "ptr", this.ptr, "int", iDest, "ptr", this.QueryInterface("{00000000-0000-0000-C000-000000000046}"), "int", iSrc, "uint", swap ? 1 : 0))
	}
	
	/**************************************************************************************************************
	Function: Merge
	Creates a new image by combining two existing images. This method also creates a new image list in which to store the image. 
	
	Remarks:
		*NOT WORKING!*
	***************************************************************************************************************
	*/
	Merge(index1, index2, xoffset, yoffset, punk2 := false)
	{
		if (!punk2)
			punk2 := this
		if this._Error(DllCall(NumGet(this.vt+13*A_PtrSize), "ptr", this.ptr, "int", index1, "ptr", punk2.QueryInterface("{00000000-0000-0000-C000-000000000046}"), "int", index2
					, "int", xoffset, "int", yoffset, "ptr", this._GUID(i, this.IID), "ptr*", out))
			return new ImageList(out)
	}
	
	/**************************************************************************************************************
	Function: Clone
	clones an existing instance.
	
	Returns:
		ImageList IL - the new ImageList instance
		
	Remarks:
		Changes to the original image list won't be visible to the clone (and the other way round).
	***************************************************************************************************************
	*/
	Clone()
	{
		this._Error(DllCall(NumGet(this.vt+14*A_PtrSize), "ptr", this.ptr, "ptr", this._GUID(i, this.IID), "ptr*", out))
		return new ImageList(out)
	}
	
	/**************************************************************************************************************
	Function: GetImageRect
	Gets an image's bounding rectangle.
	
	Parameters:
		int index - the index of the image
	
	Returns:
		RECT image - an RECT instance representing the image.
	***************************************************************************************************************
	*/
	GetImageRect(index)
	{
		VarSetCapacity(info, 16, 0)
		this._Error(DllCall(NumGet(this.vt+15*A_PtrSize), "ptr", this.ptr, "int", index, "ptr", &info))
		return RECT.FromStructPtr(&info)
	}
	
	/**************************************************************************************************************
	Function: GetIconSize
	Gets the dimensions of images in an image list. All images in an image list have the same dimensions.
	
	Parameters:
		byref int width - receives the width
		byref int height - receives the height
		
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************
	*/
	GetIconSize(ByRef width, ByRef height)
	{
		return this._Error(DllCall(NumGet(this.vt+16*A_PtrSize), "ptr", this.ptr, "int*", width, "int*", height))
	}
	
	/**************************************************************************************************************
	Function: SetIconSize
	Sets the dimensions of images in an image list and removes all images from the list.
	
	Parameters:
		int width - the new width
		int height - the new height
		
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************
	*/
	SetIconSize(width, height)
	{
		return this._Error(DllCall(NumGet(this.vt+17*A_PtrSize), "ptr", this.ptr, "int", width, "int", height))
	}
	
	/**************************************************************************************************************
	Function: GetImageCount
	Gets the number of images in an image list.
	
	Returns:
		int count - the count of images
	***************************************************************************************************************
	*/
	GetImageCount()
	{
		this._Error(DllCall(NumGet(this.vt+18*A_PtrSize), "ptr", this.ptr, "int*", count))
		return count
	}
	
	/**************************************************************************************************************
	Function: SetImageCount
	Resizes an existing image list.
	
	Parameters:
		int count - the new image count
		
	Returns:
		bool success - true on success, false otherwise
		
	Remarks:
		- if you "cut" the image list, the last icons are removed
		- if you enlarge it, the new images will be filled black.
		- if you cut and re-enlarge it, the cutted images will be present again
	***************************************************************************************************************
	*/
	SetImageCount(count)
	{
		return this._Error(DllCall(NumGet(this.vt+19*A_PtrSize), "ptr", this.ptr, "uint", count))
	}
	
	/**************************************************************************************************************
	Function: SetBkColor
	Sets the background color for an image list.
	
	Parameters:
		COLORREF color - the new color (e.g. 0x00FFFF)
		
	Returns:
		COLORREF old - the previous background color
	
	Remarks:
		This method only functions if you add an icon to the image list or use the IImageList::AddMasked method to add a black and white bitmap.
		Without a mask, the entire image draws, and the background color is not visible. 
	***************************************************************************************************************
	*/
	SetBkColor(color)
	{
		this._Error(DllCall(NumGet(this.vt+20*A_PtrSize), "ptr", this.ptr, "uint", color, "uint*", oldColor))
		return oldColor
	}
	
	/**************************************************************************************************************
	Function: GetBkColor
	Gets the current background color for an image list.
	
	Returns:
		COLORREF color - the background color
	***************************************************************************************************************
	*/
	GetBkColor()
	{
		this._Error(DllCall(NumGet(this.vt+21*A_PtrSize), "ptr", this.ptr, "uint*", color))
		return color
	}
	
	/**************************************************************************************************************
	Function: BeginDrag
	Begins dragging an image. 
	
	Parameters:
		int index - the image to drag
		int xHotspot - the x-component of the drag position relative to the upper-left corner of the image
		int yHotspot - the y-component of the drag position relative to the upper-left corner of the image.
		
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************
	*/
	BeginDrag(index, xHotspot, yHotspot)
	{
		return this._Error(DllCall(NumGet(this.vt+22*A_PtrSize), "ptr", this.ptr, "int", iTrack, "int", xHotspot, "int", yHotspot))
	}
	
	/**************************************************************************************************************
	Function: EndDrag
	Ends a drag operation.
	
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************
	*/
	EndDrag()
	{
		return this._Error(DllCall(NumGet(this.vt+23*A_PtrSize), "ptr", this.ptr))
	}
	
	/**************************************************************************************************************
	Function: DragEnter
	Locks updates to the specified window during a drag operation and displays the drag image at the specified position within the window. 
	
	Parameters:
		HWND hwnd - the window handle
		int x - The x-coordinate at which to display the drag image. The coordinate is relative to the upper-left corner of the window, not the client area.
		int y - The y-coordinate at which to display the drag image. The coordinate is relative to the upper-left corner of the window, not the client area.
		
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************
	*/
	DragEnter(hwnd, x, y)
	{
		return this._Error(DllCall(NumGet(this.vt+24*A_PtrSize), "ptr", this.ptr, "uint", hwnd, "int", x, "int", y))
	}
	
	/**************************************************************************************************************
	Function: DragLeave
	Unlocks the specified window and hides the drag image, which enables the window to update. 
	
	Parameters:
		HWND hwnd - the window handle
		
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************
	*/
	DragLeave(hwnd)
	{
		return this._Error(DllCall(NumGet(this.vt+25*A_PtrSize), "ptr", this.ptr, "uint", hwnd))
	}
		
	/**************************************************************************************************************
	Function: DragMove
	Moves the image that is being dragged during a drag-and-drop operation.
	This function is typically called in response to a WM_MOUSEMOVE message. 
	
	Parameters:
		int x - the image's new x-coordinate relative to the upper-left corner of the window
		int y - the image's new y-coordinate relative to the upper-left corner of the window
		
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************
	*/
	DragMove(x, y)
	{
		return this._Error(DllCall(NumGet(this.vt+26*A_PtrSize), "ptr", this.ptr, "int", x, "int", y))
	}
	
	/**************************************************************************************************************
	Function: SetDragCursorImage
	Creates a new drag image by combining the specified image, which is typically a mouse cursor image, with the current drag image.
	
	Parameters:
		int index - the index of the image
		int xHotspot - contains the x-component of the hot spot within the new image. 
		int yHotspot - contains the x-component of the hot spot within the new image. 
		[opt] ImageList il - the ImageList that contains the specified image. If omitted, the current instance is used.
		
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************
	*/
	SetDragCursorImage(index, xHotspot, yHotspot, il := 0)
	{
		if (il == 0)
			il := this
		return this._Error(DllCall(NumGet(this.vt+27*A_PtrSize), "ptr", this.ptr, "ptr", il.QueryInterface("{00000000-0000-0000-C000-000000000046}")
																	, "int", index, "int", xHotspot, "int", yHotspot))
	}
	
	/**************************************************************************************************************
	Function: DragShowNoLock
	Shows or hides the image being dragged.
	
	Parameters:
		bool show - true to show, false to hide the image
		
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************
	*/
	DragShowNoLock(show)
	{
		return this._Error(DllCall(NumGet(this.vt+28*A_PtrSize), "ptr", this.ptr, "uint", show))
	}
	
	/**************************************************************************************************************
	Function: GetDragImage
	Gets the temporary image list that is used for the drag image.
	The function also retrieves the current drag position and the offset of the drag image relative to the drag position.
	
	Parameters:
		byref POINT dragPos - receives a POINT instance representing the current dragging position
		byref POINT imagePos - receives a POINT instance representing the current image position
		byref ImageList IL - receives an instance for the image list used for the drag image.
		
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************
	*/
	GetDragImage(byRef dragPos, byRef imagePos, byRef IL)
	{
		VarSetCapacity(POINT1, 8, 0), VarSetCapacity(POINT2, 8, 0)
		bool := this._Error(DllCall(NumGet(this.vt+29*A_PtrSize), "ptr", this.ptr, "ptr", &POINT1, "ptr", &POINT2, "ptr", &IID, "ptr", out))

		dragPos := POINT.FromStructPtr(&POINT1)
		imagePos := POINT.FromStructPtr(&POINT2)
		IL := new ImageList(out)

		return bool
	}
	
	/**************************************************************************************************************
	Function: GetItemFlags
	Gets the flags of an image.
	
	Parameters:
		int index - the image index
	
	Returns:
		uint flags - the image's flags. You may use the ILIF class for convenience.
		
	Remarks:
		possible flag values:
			ILIF.ALPHA - Indicates that the item in the imagelist has an alpha channel.
			ILIF.LOWQUALITY - **Windows Vista and later.** Indicates that the item in the imagelist was generated via a StretchBlt function, consequently image quality may have degraded.
	***************************************************************************************************************
	*/
	GetItemFlags(index)
	{
		this._Error(DllCall(NumGet(this.vt+30*A_PtrSize), "ptr", this.ptr, "int", index, "uint*", flags))
		return flags
	}
	
	/**************************************************************************************************************
	Function: GetOverlayImage
	Retrieves a specified image from the list of images used as overlay masks.
	
	Parameters:
		int index - the image index
		
	Returns:
		int overlay - the one-based index of the overlay mask
	***************************************************************************************************************
	*/
	GetOverlayImage(index)
	{
		this._Error(DllCall(NumGet(this.vt+31*A_PtrSize), "ptr", this.ptr, "int", index, "int*", out))
		return out
	}
		
	/**************************************************************************************************************	
	group: additional methods
	
	Function: AddSystemBitmap
	adds a system bitmap to the image list.
	
	Parameters: 
		uint bmp - the ID of a predefined system bitmap. You can use the fields of the OBM class for convenience.
	
	Returns:
		int index - the new (zero-based) index of the image
	***************************************************************************************************************
	*/
	AddSystemBitmap(bmp)
	{
		return this.Add(DllCall("LoadBitmapW", "uint", 0, "uint", bmp))
	}
	
	
	/**************************************************************************************************************
	Function: AddSystemIcon
	adds a system icon to the image list.
	
	Parameters:
		uint ico - the ID of a predefined system icon. You can use the fields of the IDI class for convenience.
					
	Returns:
		int index - the new (zero-based) index of the image
	***************************************************************************************************************
	*/
	AddSystemIcon(ico)
	{
		return this.ReplaceIcon(DllCall("LoadIconW", "uint", 0, "uint", ico))
	}
	
	
	/**************************************************************************************************************
	Function: AddSystemCursor
	adds a system cursor to the image list.
	
	Parameters:
		uint cur - the ID of a predefined system cursor. You can use the fields of the IDC class for convenience.
					
	Returns:
		int index - the new (zero-based) index of the image
	***************************************************************************************************************
	*/
	AddSystemCursor(cur)
	{
		return this.ReplaceIcon(DllCall("LoadCursorW", "uint", 0, "uint", cur))
	}

	
	/**************************************************************************************************************
	Function: Unload
	unloads Comctl32.dll
	
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************
	*/
	Unload()
	{
		hM := ImageList.hModule
		ImageList.hModule := 0
		return DllCall("FreeLibrary", "uint", hM)
	}
}

/*
group: dependencies & related
*/

/*
IDC:
	You may use the values defined in the IDC enumeration class with this class **(not auto-included)**.
*/

/*
IDI:
	You may use the values defined in the IDI enumeration class with this class **(not auto-included)**.
*/

/*
ILDRAWPARAMS:
	You may use the the ILDRAWPARAMS structure class with this class **(auto-included)**.
*/
#include %A_ScriptDir%\..\Helper Classes\ILDRAWPARAMS.ahk

/*
ILIF:
	You may use the values defined in the ILIF enumeration class with this class **(not auto-included)**.
*/

/*
IMAGEINFO:
	This class requires the IMAGEINFO structure class **(auto-included)**.
*/
#include %A_ScriptDir%\..\Helper Classes\IMAGEINFO.ahk

/*
IMAGELISTDRAWFLAGS:
	You may use the values defined in the IMAGELISTDRAWFLAGS enumeration class with this class **(not auto-included)**.
*/

/*
OBM:
	You may use the values defined in the OBM enumeration class with this class **(not auto-included)**.
*/

/*
POINT:
	This class requires the POINT structure class **(auto-included)**.
*/
#include %A_ScriptDir%\..\Helper Classes\POINT.ahk

/*
RECT:
	This class requires the RECT structure class **(auto-included)**.
*/
#include %A_ScriptDir%\..\Helper Classes\RECT.ahk