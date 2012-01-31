/*
class: RECT
a structure class that defines the coordinates of the upper-left and lower-right corners of a rectangle.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lgpl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/AHK_Lv1.1/RECT)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/dd162897)

Requirements:
	AutoHotkey - AHK_L v1.1+
	OS - Windows 2000 Professional / Windows 2000 Server or higher
	Base classes - _CCF_Error_Handler_, StructBase
*/
class RECT extends StructBase
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
	converts the instance to a script-usable struct and returns its memory adress.

	Parameters:
		[opt] UPTR ptr - the fixed memory address to copy the struct to.

	Returns:
		UPTR ptr - a pointer to the struct in memory
	*/
	ToStructPtr(ptr = 0)
	{
		if (!ptr)
		{
			ptr := this.Allocate(this.GetRequiredSize())
		}

		NumPut(this.left,	1*ptr,	00,	"Int")
		NumPut(this.top,	1*ptr,	04,	"Int")
		NumPut(this.right,	1*ptr,	08,	"Int")
		NumPut(this.bottom,	1*ptr,	12,	"Int")

		return ptr
	}

	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class

	Parameters:
		UPTR ptr - a pointer to a RECT struct in memory

	Returns:
		RECT instance - the new RECT instance
	*/
	FromStructPtr(ptr)
	{
		local instance := new RECT(NumGet(1*ptr, 00, "Int")
					,	NumGet(1*ptr, 04, "Int")
					,	NumGet(1*ptr, 08, "Int")
					,	NumGet(1*ptr, 12, "Int"))
		instance.SetOriginalPointer(ptr)
		return instance
	}

	/*
	Method: GetRequiredSize
	calculates the size a memory instance of this class requires.

	Parameters:
		[opt] OBJECT data - an optional data object that may cotain data for the calculation.

	Returns:
		UINT bytes - the number of bytes required

	Remarks:
		- This may be called as if it was a static method.
		- The data object is ignored by this class.
	*/
	GetRequiredSize(data = "")
	{
		return 16
	}
}