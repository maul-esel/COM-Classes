/*
class: POINT
defines the x- and y- coordinates of a point.

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/dd162805)
*/
class POINT
{
	/*
	Field: x
	The x-coordinate of the point.
	*/
	x := 0

	/*
	Field: y
	The y-coordinate of the point.
	*/
	y := 0

	/*
	Method: Constructor
	creates a new instance of the POINT class

	Parameters:
		x - the initial value for the <x> field
		y - the initial value for the <y> field
	*/
	__New(x, y)
	{
		this.x := x, this.y := y
	}

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
			VarSetCapacity(struct, 8, 0)
			ptr := &struct
		}

		NumPut(this.x,	1*ptr,	00,	"Int")
		NumPut(this.y,	1*ptr,	04,	"Int")

		return ptr
	}

	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class

	Parameters:
		UPTR ptr - a pointer to a POINT struct in memory

	Returns:
		POINT instance - the new POINT instance
	*/
	FromStructPtr(ptr)
	{
		return new POINT(NumGet(1*ptr, 00, "Int"), NumGet(1*ptr, 04, "Int"))
	}
}