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
	__New(left := 0, top := 0, right := 0, bottom := 0)
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
		VarSetCapacity(rect, 16, 0)
		NumPut(this.left,	00,	"UInt")
		NumPut(this.top,	04,	"UInt")
		NumPut(this.right,	08,	"UInt")
		NumPut(this.bottom,	12,	"UInt")
		return &rect
	}
}