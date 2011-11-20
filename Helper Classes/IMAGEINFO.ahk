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
	rcImage := new RECT(0,0,0,0)
	
	/*
	Method: Constructor
	creates a new instance of the class
	
	Parameters:
		hbmImage - the initial value of the <hbmImage> field
		hbmMask - the initial value of the <hbmMask> field
		rcImage - the initial (RECT) value of the <rcImage> field
	*/
	__New(hbmImage, hbmMask, rcImage)
	{
		this.hbmImage := hbmImage, this.hbmMask := hbmMask, this.rcImage := rcImage
	}
	
	/*
	Method: ToStructPtr
	converts the instance to a script-usable struct
	
	Returns:
		ptr - a pointer to the struct in memory
	*/
	ToStructPtr()
	{
		VarSetCapacity(struct, 2*A_PtrSize + 24, 0)
		
		NumPut(this.hbmImage,		struct,		00+0*A_PtrSize,	"UPtr")
		NumPut(this.hbmMask,		struct,		00+1*A_PtrSize,	"UPtr")
		NumPut(this.Unused1,		struct,		00+2*A_PtrSize,	"Int")
		NumPut(this.Unused2,		struct,		04+2*A_PtrSize,	"Int")
		NumPut(this.rcImage.left,	struct,		08+2*A_PtrSize,	"Int")
		NumPut(this.rcImage.top,	struct,		12+2*A_PtrSize,	"Int")
		NumPut(this.rcImage.right,	struct,		16+2*A_PtrSize,	"Int")
		NumPut(this.rcImage.bottom,	struct,		20+2*A_PtrSize,	"Int")
		
		return &struct
	}
	
	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class
	
	Returns:
		instance - the new IMAGEINFO instance
	*/
	FromStructPtr(ptr)
	{
		return new IMAGEINFO(NumGet(ptr,	00+0*A_PtrSize, "UPtr")
						,	NumGet(ptr,		00+1*A_PtrSize, "UPtr")
						,	RECT.FromStructPtr(ptr + 08 + 2*A_PtrSize))
	}
}

/*
group: dependencies & related
*/
/*
RECT:
	This class requires the RECT structure class **(auto-included)**.
*/
#include %A_ScriptDir%\RECT.ahk