/*
class: POINT
This class represents a POINT struct (<http://msdn.microsoft.com/en-us/library/dd162805.aspx>).
The POINT structure defines the x- and y- coordinates of a point.
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
	converts the instance to a script-usable struct
	
	Returns:
		ptr - a pointer to the struct in memory
	*/
	ToStructPtr()
	{
		VarSetCapacity(struct, 8, 0)
		
		NumPut(this.x,	struct,	00,	"Int")
		NumPut(this.y,	struct,	04,	"Int")
		
		return &struct
	}
	
	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class
	
	Returns:
		instance - the new POINT instance
	*/
	FromStructPtr(ptr)
	{
		return new POINT(NumGet(ptr, 00, "Int"), NumGet(ptr, 04, "Int"))
	}
}