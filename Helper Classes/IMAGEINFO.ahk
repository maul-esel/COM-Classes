/*
class: IMAGEINFO
a class containing information about an image in an image list. This structure is used with the IImageList::GetImageInfo function. 
*/
class IMAGEINFO
{
	/*
	Field: 	hbmImage
	A handle to the bitmap that contains the images. 
	*/
	hbmImage := 0
	
	/*
	Field: hbmMask
	A handle to a monochrome bitmap that contains the masks for the images. If the image list does not contain a mask, this member is 0.
	*/
	hbmMask := 0
	
	/*
	Field: Unused1
	Not used. This member should always be zero. 
	*/
	Unused1 := 0
	
	/*
	Field: Unused2
    Not used. This member should always be zero.
	*/
	Unused2 := 0
	
	/*
	Field: rcImage
    The bounding rectangle of the specified image within the bitmap specified by hbmImage.
	
	Remarks:
		- This should be a RECT instance.
	*/
	rcImage := new RECT()
	
	/*
	Method: Constructor
	creates a new instance of the class
	
	Parameters:
		HBITMAP hbmImage - the initial value of the <hbmImage> field
		HBITMAP hbmMask - the initial value of the <hbmMask> field
		RECT rcImage - the initial (RECT) value of the <rcImage> field
	*/
	__New(hbmImage, hbmMask, rcImage)
	{
		this.hbmImage := hbmImage, this.hbmMask := hbmMask, this.rcImage := rcImage
	}
	
	/*
	Method: ToStructPtr
	converts the instance to a script-usable struct and returns its memory adress.

	Parameters:
		[opt] UPTR ptr - the fixed memory address to copy the struct to.

	Returns:
		UPTR ptr - a pointer to the struct in memory
	*/
	ToStructPtr(ptr = 0)
	{
		static struct

		if (!ptr)
		{
			VarSetCapacity(struct, 2*A_PtrSize + 24, 0)
			ptr := &struct
		}

		NumPut(this.hbmImage,		1*ptr,		00+0*A_PtrSize,	"UPtr")
		NumPut(this.hbmMask,		1*ptr,		00+1*A_PtrSize,	"UPtr")
		NumPut(this.Unused1,		1*ptr,		00+2*A_PtrSize,	"Int")
		NumPut(this.Unused2,		1*ptr,		04+2*A_PtrSize,	"Int")
		this.rcImage.ToStructPtr(ptr + 08 + 2*A_PtrSize)

		return ptr
	}
	
	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class

	Parameters:
		UPTR ptr - a pointer to a IMAGEINFO struct in memory

	Returns:
		IMAGEINFO instance - the new IMAGEINFO instance
	*/
	FromStructPtr(ptr)
	{
		return new IMAGEINFO(NumGet(1*ptr,	00+0*A_PtrSize, "UPtr")
						,	NumGet(1*ptr,		00+1*A_PtrSize, "UPtr")
						,	RECT.FromStructPtr(ptr + 08 + 2*A_PtrSize))
	}
}