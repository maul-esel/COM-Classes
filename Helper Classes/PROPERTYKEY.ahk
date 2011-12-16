/*
class: PROPERTYKEY
This class represents a PROPERTYKEY struct (<http://msdn.microsoft.com/en-us/library/windows/desktop/bb773381>)
The PROPERTYKEY structure programmatically identifies a property.
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
	converts the instance to a script-usable struct

	Returns:
		UPTR ptr - a pointer to the struct in memory
	*/
	ToStructPtr()
	{
		VarSetCapacity(struct, 20, 0)

		DllCall("Ole32\CLSIDFromString", "str", this.fmtid, "ptr", &struct)
		NumPut(this.pid,	struct,	16,	"UInt")

		return &struct
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
		instance.fmtid	:= StrGet(guid, "UTF-16")
		instance.pid	:= NumGet(ptr,	16,	"UInt")

		return instance
	}
}