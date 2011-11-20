/*
class: IMAGELISTDRAWPARAMS
contains information about an image list draw operation and is used with the IImageList::Draw function.
*/
class IMAGELISTDRAWPARAMS
{
	/*
	Field: cbSize
	The size of this structure, in bytes. 
	
	Remarks:
		- In the implementation in the ImageList class, this is overwritten.
		- It doesn't make sense to change it anyway. The correct value is calculated by this class at runtime.
	*/
	cbSize := 2 * A_PtrSize + 15 * 4

	/*
	Field: himl
	A handle to the image list that contains the image to be drawn. This can also be an ImageList instance.
	
	Remarks:
		- In the implementation in the ImageList class, this is overwritten.
	*/
	himl := 0
	
	/*
	Field: i
	The zero-based index of the image to be drawn. 
	
	Remarks:
		- The default value is 0
	*/
	i := 0
	
	/*
	Field: hdcDst
	A handle to the destination device context.
	*/
	hdcDst := 0
	
	/*
	Field: x
	The x-coordinate that specifies where the image is drawn. 
	*/
	x := 0
	
	/*
	Field: y
	The y-coordinate that specifies where the image is drawn. 
	*/
	y := 0
	
	/*
	Field: cx
	A value that specifies the number of pixels to draw, relative to the upper-left corner of the drawing operation as specified by <xBitmap> and <yBitmap>. If <cx> and <cy> are zero, then Draw draws the entire valid section. The method does not ensure that the parameters are valid.
	*/
	cx := 0
	
	/*
	Field: cy
	A value that specifies the number of pixels to draw, relative to the upper-left corner of the drawing operation as specified by <xBitmap> and <yBitmap>. If <cx> and <cy> are zero, then Draw draws the entire valid section. The method does not ensure that the parameters are valid.
	*/
	cy := 0
	
	/*
	Field: xBitmap
	The x-coordinate that specifies the upper-left corner of the drawing operation in reference to the image itself. Pixels of the image that are to the left of <xBitmap> and above <yBitmap> do not appear. 
	*/
	xBitmap := 0
	
	/*
	Field: yBitmap
	The y-coordinate that specifies the upper-left corner of the drawing operation in reference to the image itself. Pixels of the image that are to the left of <xBitmap> and above <yBitmap> do not appear.
	*/
	yBitmap := 0
	
	/*
	Field: rgbBk
	The image background color. This parameter can be an application-defined RGB value or a special value defined in a member of the COLORREF class.
	
	Remarks:
		- For application-defined values, use the format "0x00bbggrr" (the first byte must be zero).
		- the meanings of the special values:
			COLORREF.DEFAULT - The default background color. The image is drawn using the image list background color.
			COLORREF.NONE - No background color. The image is drawn transparently.
	*/
	rgbBk := 0xFF000000
	
	/*
	Field: rgbFg
	The image foreground color. This parameter can be an application-defined RGB value or oa special value defined in a member of the COLORREF class.

	Remarks:
		- For application-defined values, use the format "0x00bbggrr" (the first byte must be zero).
		- This member is used only if fStyle includes the IMAGELISTDRAWFLAGS.BLEND25 or IMAGELISTDRAWFLAGS.BLEND50 flag.
		- the meanings of the special values:
			COLORREF.DEFAULT - The default foreground color. The image is drawn using the system highlight color as the foreground color.
			COLORREF.NONE - No blend color. The image is blended with the color of the destination device context.
	*/
	rgbFg := 0xFF000000
	
	/*
	Field: fStyle
	A flag specifying the drawing style and, optionally, the overlay image. See the comments section at the end of this topic for information on the overlay image. This member can contain one or more image list drawing flags. You can find those in the <IMAGELISTDRAWFLAGS class at IMAGELISTDRAWFLAGS.html>.
	*/
	fStyle := 0
	
	/*
	Field: dwRop
	A value specifying a raster operation code. These codes define how the color data for the source rectangle will be combined with the color data for the destination rectangle to achieve the final color. This member is ignored if <fStyle> does not include the IMAGELISTDRAWFLAGS.ROP flag. Some common raster operation codes include:
	- [info missing]
	*/
	dwRop := 0
	
	/*
	Field: fState
	A flag that specifies the drawing state. This member can contain one or more image list state flags. You can find those in the <IMAGELISTSTATEFLAGS class at IMAGELISTSTATEFLAGS.html>.
	*/
	fState := 0
	
	/*
	Field: Frame
	Used with the alpha blending effect.

	When used with IMAGELISTSTATEFLAGS.ALPHA in <fState>, this member holds the value for the alpha channel. This value can be from 0 to 255, with 0 being completely transparent, and 255 being completely opaque. 
	*/
	Frame := 0
	
	/*
	Field: crEffect
	A color used for the glow and shadow effects. 
	*/
	crEffect := 0x00FFFFFF
	
	/*
	Method: ToStructPtr
	converts the instance to a script-usable struct
	
	Returns:
		ptr - a pointer to the struct in memory
	*/
	ToStructPtr()
	{
		VarSetCapacity(struct, this.cbSize, 0)
		
		NumPut(this.cbSize,		struct, 00 + 0*A_PtrSize,	"UInt")
		NumPut(this.ptr, 		struct,	04 + 0*A_PtrSize,	"UPtr")
		NumPut(this.i,			struct,	04 + 1*A_PtrSize,	"Int")
		NumPut(this.hdcDst,		struct,	08 + 1*A_PtrSize,	"UPtr")
		NumPut(this.x,			struct,	08 + 2*A_PtrSize,	"Int")
		NumPut(this.y,			struct,	12 + 2*A_PtrSize,	"Int")
		NumPut(this.cx,			struct,	16 + 2*A_PtrSize,	"Int")
		NumPut(this.cy,			struct,	20 + 2*A_PtrSize,	"Int")
		NumPut(this.xBitmap,	struct,	24 + 2*A_PtrSize,	"Int")
		NumPut(this.yBitmap,	struct,	28 + 2*A_PtrSize,	"Int")
		NumPut(this.rgbBk,		struct,	32 + 2*A_PtrSize,	"UInt")
		NumPut(this.rgbFg,		struct,	36 + 2*A_PtrSize,	"UInt")
		NumPut(this.fStyle,		struct,	40 + 2*A_PtrSize,	"UInt")
		NumPut(this.dwRop,		struct,	44 + 2*A_PtrSize,	"UInt")
		NumPut(this.fState,		struct,	48 + 2*A_PtrSize,	"UInt")
		NumPut(this.Frame,		struct,	52 + 2*A_PtrSize,	"UInt")
		NumPut(this.crEffect,	struct, 56 + 2*A_PtrSize,	"UInt")
		
		return &struct
	}

	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class

	Returns:
		instance - the new IMAGELISTDRAWPARAMS instance
	*/
	FromStructPtr(ptr)
	{
		instance := new IMAGELISTDRAWPARAMS()

		instance.cbSize		:= NumGet(ptr,	00 + 0*A_PtrSize,	"UInt")
		instance.ptr		:= NumGet(ptr,	04 + 0*A_PtrSize,	"UPtr")
		instance.i			:= NumGet(ptr,	04 + 1*A_PtrSize,	"Int")
		instance.hdcDst		:= NumGet(ptr,	08 + 1*A_PtrSize,	"UPtr")
		instance.x			:= NumGet(ptr,	08 + 2*A_PtrSize,	"Int")
		instance.y			:= NumGet(ptr,	12 + 2*A_PtrSize,	"Int")
		instance.cx			:= NumGet(ptr,	16 + 2*A_PtrSize,	"Int")
		instance.cy			:= NumGet(ptr,	20 + 2*A_PtrSize,	"Int")
		instance.xBitmap	:= NumGet(ptr,	24 + 2*A_PtrSize,	"Int")
		instance.yBitmap	:= NumGet(ptr,	28 + 2*A_PtrSize,	"Int")
		instance.rgbBk		:= NumGet(ptr,	32 + 2*A_PtrSize,	"UInt")
		instance.rgbFg		:= NumGet(ptr,	36 + 2*A_PtrSize,	"UInt")
		instance.fStyle		:= NumGet(ptr,	40 + 2*A_PtrSize,	"UInt")
		instance.dwRop		:= NumGet(ptr,	44 + 2*A_PtrSize,	"UInt")
		instance.fState		:= NumGet(ptr,	48 + 2*A_PtrSize,	"UInt")
		instance.Frame		:= NumGet(ptr,	52 + 2*A_PtrSize,	"UInt")
		instance.crEffect	:= NumGet(ptr,	56 + 2*A_PtrSize,	"UInt")

		return instance
	}
}

/*
group: dependencies & related
*/

/*
COLORREF:
	You may use the values defined in the COLORREF enumeration class with this class **(not auto-included)**.
*/

/*
IMAGELISTDRAWFLAGS:
	You may use the values defined in the IMAGELISTDRAWFLAGS enumeration class with this class **(not auto-included)**.
*/

/*
IMAGELISTSTATEFLAGS:
	You may use the values defined in the IMAGELISTSTATEFLAGS enumeration class with this class **(not auto-included)**.
*/