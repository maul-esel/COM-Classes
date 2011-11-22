/*
class: IMAGELISTSTATS
Contains image list statistics. Used by IImageList2::GetStatistics.
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
	converts the instance to a script-usable struct

	Returns:
		ptr - a pointer to the struct in memory
	*/
	ToStructPtr()
	{
		VarSetCapacity(struct, 16, 0)

		NumPut(this.cbSize,		struct,	00,	"UInt")
		NumPut(this.cAlloc,		struct,	04,	"Int")
		NumPut(this.cUsed,		struct,	08,	"Int")
		NumPut(this.cStandby,	struct,	12,	"Int")

		return &struct
	}

	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class

	Returns:
		instance - the new IMAGELISTSTATS instance
	*/
	FromStructPtr(ptr)
	{
		instance := new IMAGELISTSTATS()

		instance.cbSize 	:= NumGet(ptr,	00,	"UInt")
		instance.cAlloc		:= NumGet(ptr,	04,	"Int")
		instance.cUsed		:= NumGet(ptr,	08,	"Int")
		instance.cStandby	:= NumGet(ptr,	12,	"Int")

		return instance
	}
}