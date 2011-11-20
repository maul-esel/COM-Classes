/*
class: RECT
This class represents a RECT struct (<http://msdn.microsoft.com/en-us/library/dd162897.aspx>)
The RECT structure defines the coordinates of the upper-left and lower-right corners of a rectangle.
*/
class RECT
{
	/*
	Field: left
	The x-coordinate of the upper-left corner of the rectangle.
	*/
	left := 0
	
	/*
	Field: top
	The y-coordinate of the upper-left corner of the rectangle.
	*/
	top := 0
	
	/*
	Field: right
	The x-coordinate of the lower-right corner of the rectangle.
	*/
	right := 0
	
	/*
	Field: bottom
	The y-coordinate of the lower-right corner of the rectangle.
	*/
	bottom := 0
	
	/*
	Method: Constructor
	creates a new instance of the RECT class
	
	Parameters:
		[opt] left - the initial value for the <left> field
		[opt] top - the initial value for the <top> field
		[opt] right - the initial value for the <right> field
		[opt] bottom - the initial value for the <bottom> field
	*/
	__New(left = 0, top = 0, right = 0, bottom = 0)
	{
		this.left := left, this.top := top, this.right := right, this.bottom := bottom
	}
	
	/*
	Method: ToStructPtr
	converts the instance to a script-usable struct
	
	Returns:
		ptr - a pointer to the struct in memory
	*/
	ToStructPtr()
	{
		VarSetCapacity(struct, 16, 0)

		NumPut(this.left,	struct,	00,	"Int")
		NumPut(this.top,	struct,	04,	"Int")
		NumPut(this.right,	struct,	08,	"Int")
		NumPut(this.bottom,	struct,	12,	"Int")

		return struct
	}
	
	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class
	
	Returns:
		instance - the new RECT instance
	*/
	FromStructPtr(ptr)
	{
		return new RECT(NumGet(ptr, 00, "Int")
					,	NumGet(ptr, 04, "Int")
					,	NumGet(ptr, 08, "Int")
					,	NumGet(ptr, 12, "Int"))
	}
}