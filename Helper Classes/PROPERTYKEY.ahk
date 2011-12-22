/*
class: PROPERTYKEY
programmatically identifies a property.

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/bb773381)
*/
class PROPERTYKEY
{
	/*
	Field: fmtid
	A unique GUID for the property.

	Remarks:
		This is retrieved and set as *GUID string*.
	*/
	fmtid := ""

	/*
	Field: pid
	A property identifier (PID). Any value greater than or equal to 2 (default) is acceptable.
	*/
	pid := 2

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
			VarSetCapacity(struct, 20, 0)
			ptr := &struct
		}

		DllCall("Ole32\CLSIDFromString", "str", this.fmtid, "ptr", ptr)
		NumPut(this.pid,	1*ptr,	16,	"UInt")

		return ptr
	}

	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class

	Parameters:
		UPTR ptr - a pointer to a PROPERTYKEY struct in memory

	Returns:
		PROPERTYKEY instance - the new PROPERTYKEY instance
	*/
	FromStructPtr(ptr)
	{
		instance := new PROPERTYKEY()

		DllCall("Ole32.dll\StringFromCLSID", "ptr", ptr, "ptr*", guid)
		instance.fmtid	:= StrGet(1*guid, "UTF-16")
		instance.pid	:= NumGet(1*ptr,	16,	"UInt")

		return instance
	}
}