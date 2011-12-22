/*
class: SIZE
specifies the width and height of a rectangle.

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/dd145106)
*/
class SIZE
{
	/*
	Field: cx
	Specifies the rectangle's width. The units depend on which function uses this.
	*/
	cx := 0

	/*
	Field: cy
	Specifies the rectangle's height. The units depend on which function uses this.
	*/
	cy := 0

	/*
	Method: Constructor

	Parameters:
		[opt] INT w - the initial value for the <cx> field
		[opt] INT h - the initial value for the <cy> field
	*/
	__New(w := 0, h := 0)
	{
		this.cx := w, this.cy := h
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

		NumPut(this.cx,	1*ptr,	00,	"Int")
		NumPut(this.cy,	1*ptr,	04,	"Int")

		return ptr
	}

	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class

	Parameters:
		UPTR ptr - a pointer to a SIZE struct in memory

	Returns:
		SIZE instance - the new SIZE instance
	*/
	FromStructPtr(ptr)
	{
		return new SIZE(NumGet(1*ptr, 00, "Int"), NumGet(1*ptr, 04, "Int"))
	}
}