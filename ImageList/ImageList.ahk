/**************************************************************************************************************
class: ImageList
exposes methods to manage image lists via COM interface IImageList.

Requirements:
	- This requires AHK v2 alpha
	- the Unknown class is also required
	- Windows XP / Windows Server 2003 or higher
	
Remarks:
	- functions which receive bimtaps as parameters usually call DeleteObject() on them.
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
	FromHIMAGELIST(il := 0){
		global ImageList
		
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
	Add(bitmap, maskbitmap := 0){
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
	ReplaceIcon(hIcon, index := -1){
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
	SetOverlayImage(image, overlay)	{
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
	Replace(index, bitmap, maskbitmap := 0){
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
	AddMasked(bitmap, color){
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
	Draw(params){
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
	Remove(index){
		return this._Error(DllCall(NumGet(this.vt+9*A_PtrSize), "ptr", this.ptr, "int", index))
		}
	
	/**************************************************************************************************************
	Function: GetIcon
	Creates an icon from an image and a mask in an image list.
	
	Parameters:
		int index - the index of the image to use
		uint flags - a combination of flags to be used.
		
	Returns:
		HICON icon - the generated icon
		
	Remarks:
		Valid flags: http://msdn.microsoft.com/en-us/library/bb775230.aspx
		Example:
>		flags := 0x00000001|0x00000004 ; binary "OR" operator: |
	***************************************************************************************************************
	*/
	GetIcon(index, flags){
		this._Error(DllCall(NumGet(this.vt+10*A_PtrSize), "ptr", this.ptr, "int", index, "uint", flags, "uint*", hIcon))
		return hIcon
		}
	
	/**************************************************************************************************************
	Function: GetImageInfo
	gets information about an image
	
	Parameters:
		int index - the index of the image to work on
		
	Returns:
		object IMAGEINFO - an object containing the information.
	
	Remarks:
		the fields in the returned object match the struct member names: http://msdn.microsoft.com/en-us/library/bb761393.aspx
		The unused fields are ignored.
		To retrieve information about the RECT use something like:
>		top := myIL.GetImageInfo(0).RECT.top
	***************************************************************************************************************
	*/
	GetImageInfo(index){
		VarSetCapacity(IMAGEINFO, 32, 0)
		this._Error(DllCall(NumGet(this.vt+11*A_PtrSize), "ptr", this.ptr, "int", index, "ptr", &IMAGEINFO))
		return { "hbmImage" : NumGet(IMAGEINFO, 0)
				, "hbmMask" : NumGet(IMAGEINFO, 4)
				, "RECT" : { "left" : NumGet(IMAGEINFO, 16)
							, "top" : NumGet(IMAGEINFO, 20)
							, "right" : NumGet(IMAGEINFO, 24)
							, "bottom" : NumGet(IMAGEINFO, 28)}}
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
	Copy(iDest, iSrc, swap){
		return this._Error(DllCall(NumGet(this.vt+12*A_PtrSize), "ptr", this.ptr, "int", iDest, "ptr", this.QueryInterface("{00000000-0000-0000-C000-000000000046}"), "int", iSrc, "uint", swap ? 1 : 0))
		}
	
	/**************************************************************************************************************
	Function: Merge
	Creates a new image by combining two existing images. This method also creates a new image list in which to store the image. 
	
	Remarks:
		*NOT WORKING!*
	***************************************************************************************************************
	*/
	Merge(index1, index2, xoffset, yoffset, punk2 := false) {
		global ImageList
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
	Clone(){
		global ImageList
		this._Error(DllCall(NumGet(this.vt+14*A_PtrSize), "ptr", this.ptr, "ptr", this._GUID(i, this.IID), "ptr*", out))
		return new ImageList(out)
		}
	
	/**************************************************************************************************************
	Function: GetImageRect
	Gets an image's bounding rectangle.
	
	Parameters:
		int index - the index of the image
	
	Returns:
		object RECT - an object representing the RECT struct.
	***************************************************************************************************************
	*/
	GetImageRect(index){
		VarSetCapacity(RECT, 16, 0)
		this._Error(DllCall(NumGet(this.vt+15*A_PtrSize), "ptr", this.ptr, "int", index, "ptr", &RECT))
		return { "left" : NumGet(RECT, 0)
				, "top" : NumGet(RECT, 4)
				, "right" : NumGet(RECT, 8)
				, "bottom" : NumGet(RECT, 12)}
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
	GetIconSize(ByRef width, ByRef height){
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
	SetIconSize(width, height){
		return this._Error(DllCall(NumGet(this.vt+17*A_PtrSize), "ptr", this.ptr, "int", width, "int", height))
		}
	
	/**************************************************************************************************************
	Function: GetImageCount
	Gets the number of images in an image list.
	
	Returns:
		int count - the count of images
	***************************************************************************************************************
	*/
	GetImageCount(){
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
	SetImageCount(count){
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
	SetBkColor(color){
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
	GetBkColor(){
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
	BeginDrag(index, xHotspot, yHotspot){
		return this._Error(DllCall(NumGet(this.vt+22*A_PtrSize), "ptr", this.ptr, "int", iTrack, "int", xHotspot, "int", yHotspot))
		}
	
	/**************************************************************************************************************
	Function: EndDrag
	Ends a drag operation.
	
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************
	*/
	EndDrag(){
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
	DragEnter(hwnd, x, y){
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
	DragLeave(hwnd){
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
	DragMove(x, y){
		return this._Error(DllCall(NumGet(this.vt+26*A_PtrSize), "ptr", this.ptr, "int", x, "int", y))
		}
	
	/**************************************************************************************************************
	Function: SetDragCursorImage
	Creates a new drag image by combining the specified image, which is typically a mouse cursor image, with the current drag image.
	
	Parameters:
		int index - the index of the image
		int xHotspot - contains the x-component of the hot spot within the new image. 
		int yHotspot - contains the x-component of the hot spot within the new image. 
		[opt] ImageList il - the ImageList that contains the specified image. If omitted, the current instance is used
		
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************
	*/
	SetDragCursorImage(index, xHotspot, yHotspot, il := 0){
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
	DragShowNoLock(show){
		return this._Error(DllCall(NumGet(this.vt+28*A_PtrSize), "ptr", this.ptr, "uint", show))
		}
	
	/**************************************************************************************************************
	Function: GetDragImage
	Gets the temporary image list that is used for the drag image.
	The function also retrieves the current drag position and the offset of the drag image relative to the drag position.
	
	Parameters:
		byref object dragPos - receives an object representing the POINT structure for the current dragging position
		byref object imagePos - receives an object representing the POINT structure for the current image position
		byref ImageList IL - receives an instance for the image list used for the drag image.
		
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************
	*/
	GetDragImage(ByRef dragPos, ByRef imagePos, ByRef IL){
		global ImageList	
		VarSetCapacity(POINT1, 8, 0), VarSetCapacity(POINT2, 8, 0)
		bool := this._Error(DllCall(NumGet(this.vt+29*A_PtrSize), "ptr", this.ptr, "ptr", &POINT1, "ptr", &POINT2, "ptr", &IID, "ptr", out))
		dragPos := { "x" : NumGet(POINT1, 0), "y" : NumGet(POINT1, 4) }
		imagePos := { "x" : NumGet(POINT2, 0), "y" : NumGet(POINT2, 4) }
		IL := new ImageList(out)
		return bool
		}
	
	/**************************************************************************************************************
	Function: GetItemFlags
	Gets the flags of an image.
	
	Parameters:
		int index - the image index
	
	Returns:
		uint flags - the image's flags
		
	Remarks:
		possible flag values:
		ILIF_ALPHA (0x00000001) - Indicates that the item in the imagelist has an alpha channel.
		ILIF_LOWQUALITY (0x00000002) - **Windows Vista and later.** Indicates that the item in the imagelist was generated via a StretchBlt function, consequently image quality may have degraded.
	***************************************************************************************************************
	*/
	GetItemFlags(index){
		this._Error(DllCall(NumGet(this.vt+30*A_PtrSize), "ptr", this.ptr, "int", index, "uint*", flags))
		return flags
		}
	
	/**************************************************************************************************************
	Function: GetOverlayImage
	Retrieves a specified image from the list of images used as overlay masks.
	
	Parameters:
		int index - the image index
		
	Returns:
		int overlay - receives the one-based index of the overlay mask
	***************************************************************************************************************
	*/
	GetOverlayImage(index){
		this._Error(DllCall(NumGet(this.vt+31*A_PtrSize), "ptr", this.ptr, "int", index, "int*", out))
		return out
		}
		
	/**************************************************************************************************************	
	group: additional methods
	
	Function: AddSystemBitmap
	adds a system bitmap to the image list.
	
	Parameters: 
		var bmp - either the name of the bitmap (OBM_xxx) or its ID (defined in WinUser.h)
					If the name is passed, the leading "OBM_" can be omitted.
	
	Returns:
		int index - the new (zero-based) index of the image
	
	Remarks:
		For a list of possible bitmap see http://msdn.microsoft.com/en-us/library/dd145033.aspx
	***************************************************************************************************************
	*/
	AddSystemBitmap(bmp){
		static bitmaps := { "OBM_CLOSE" : 32754, "OBM_UPARROW" : 32753, "OBM_DNARROW" : 32752, "OBM_RGARROW" : 32751, "OBM_LFARROW" : 32750, "OBM_REDUCE" : 32749
						, "OBM_ZOOM" : 32748, "OBM_RESTORE" : 32747, "OBM_REDUCED" : 32746, "OBM_ZOOMD" : 32745, "OBM_RESTORED" :  32744, "OBM_UPARROWD" : 32743
						, "OBM_DNARROWD" : 32742, "OBM_RGARROWD" : 32741, "OBM_LFARROWD" : 32740, "OBM_MNARROW" : 32739, "OBM_COMBO" : 32738, "OBM_UPARROWI" : 32737
						, "OBM_DNARROWI" : 32736, "OBM_RGARROWI" : 32735, "OBM_LFARROWI" : 32734, "OBM_OLD_CLOSE" : 32767, "OBM_SIZE" : 32766, "OBM_OLD_UPARROW" : 32765
						, "OBM_OLD_DNARROW" : 32764, "OBM_OLD_RGARROW" : 32763, "OBM_OLD_LFARROW" : 32762, "OBM_BTSIZE" : 32761, "OBM_CHECK" : 32760, "OBM_CHECKBOXES" : 32759
						, "OBM_BTNCORNERS" : 32758, "OBM_OLD_REDUCE" : 32757, "OBM_OLD_ZOOM" : 32756, "OBM_OLD_RESTORE" : 32755}
		if bmp is not integer
			{
			_bmp := bmp
			bmp := bitmaps[bmp]
			if (!bmp)
				bmp := bitmaps["OBM_" . _bmp]
			}
		return this.Add(DllCall("LoadBitmapW", "uint", 0, "uint", bmp))
		}
	
	
	/**************************************************************************************************************
	Function: AddSystemIcon
	adds a system icon to the image list.
	
	Parameters:
		var ico - either the name of the icon (IDI_xxx) or it's ID (defined in WinUser.h)
					If the name is passed, the leading "IDI_" can be omitted.
					
	Returns:
		int index - the new (zero-based) index of the image
	
	Remarks:
		For a list of possible values see http://msdn.microsoft.com/en-us/library/ms648072.aspx
	***************************************************************************************************************
	*/
	AddSystemIcon(ico){
		static icons := { "IDI_APPLICATION" : 32512, "IDI_ASTERISK" : 32516, "IDI_ERROR" : 32513, "IDI_EXCLAMATION" : 32515, "IDI_HAND" : 32513, "IDI_INFORMATION" : 32516
						, "IDI_QUESTION" : 32514, "IDI_SHIELD" : 32518, "IDI_WARNING" : 32515, "IDI_WINLOGO" : 32517 }
		if ico is not integer
			{
			_ico := ico
			ico := icons[ico]
			if (!ico)
				ico := icons["IDI_" . _ico]
			}
		return this.ReplaceIcon(DllCall("LoadIconW", "uint", 0, "uint", ico))
		}
	
	
	/**************************************************************************************************************
	Function: AddSystemCursor
	adds a system cursor to the image list.
	
	Parameters:
		var cur - either the name of the icon (IDC_xxx) or it's ID (defined in WinUser.h)
					If the name is passed, the leading "IDC_" can be omitted.
					
	Returns:
		int index - the new (zero-based) index of the image
	
	Remarks:
		For a list of possible values see http://msdn.microsoft.com/en-us/library/ms648391.aspx
	***************************************************************************************************************
	*/
	AddSystemCursor(cur){
		static cursors := { "IDC_ARROW" : 32512, "IDC_IBEAM" : 32513, "IDC_WAIT" : 32514, "IDC_CROSS" : 32515, "IDC_UPARROW" : 32516, "IDC_SIZE" : 32640, "IDC_ICON" : 32641
						, "IDC_SIZENWSE" : 32642, "IDC_SIZENESW" : 32643, "IDC_SIZEWE" : 32644, "IDC_SIZENS" :  32645, "IDC_SIZEALL" : 32646, "IDC_NO" : 32648
						, "IDC_HAND" : 32649, "IDC_APPSTARTING" : 32650, "IDC_HELP" : 32651 }
		if cur is not integer
			{
			_cur := cur
			cur := cursors[cur]
			if (!cur)
				cur := cursors["IDC_" . _cur]
			}
		return this.ReplaceIcon(DllCall("LoadCursorW", "uint", 0, "uint", cur))
		}

	
	/**************************************************************************************************************
	Function: Unload
	unloads Comctl32.dll
	
	Returns:
		bool success - true on success, false otherwise
	***************************************************************************************************************
	*/
	Unload(){
		global ImageList
		hM := ImageList.hModule
		ImageList.hModule := 0
		return DllCall("FreeLibrary", "uint", hM)
		}
	}