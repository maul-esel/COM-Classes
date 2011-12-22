/*
class: IMAGELISTSTATS
Contains image list statistics. Used by IImageList2::GetStatistics.

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/bb761397)
*/
class IMAGELISTSTATS
{
	/*
	Field: cbSize
	The image list size.
	*/
	cbSize := 0

	/*
	Field: cAlloc
	The number of images allocated.
	*/
	cAlloc := 0

	/*
	Field: cUsed
	The number of images in use.
	*/
	cUsed := 0

	/*
	Field: cStandby
	The number of standby images.
	*/
	cStandby := 0

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
			VarSetCapacity(struct, 16, 0)
			ptr := &struct
		}

		NumPut(this.cbSize,		1*ptr,	00,	"UInt")
		NumPut(this.cAlloc,		1*ptr,	04,	"Int")
		NumPut(this.cUsed,		1*ptr,	08,	"Int")
		NumPut(this.cStandby,	1*ptr,	12,	"Int")

		return ptr
	}

	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class

	Parameters:
		UPTR ptr - a pointer to a IMAGELISTSTATS struct in memory

	Returns:
		IMAGELISTSTATS instance - the new IMAGELISTSTATS instance
	*/
	FromStructPtr(ptr)
	{
		instance := new IMAGELISTSTATS()

		instance.cbSize 	:= NumGet(1*ptr,	00,	"UInt")
		instance.cAlloc		:= NumGet(1*ptr,	04,	"Int")
		instance.cUsed		:= NumGet(1*ptr,	08,	"Int")
		instance.cStandby	:= NumGet(1*ptr,	12,	"Int")

		return instance
	}
}