/*
class: FILETIME
This class represents a FILETIME struct.
The FILETIME structure contains a 64-bit value representing the number of 100-nanosecond intervals since January 1, 1601 (UTC).
*/
class FILETIME
{
	/*
	Field: dwLowDateTime
	The low-order part of the file time.
	*/
	dwLowDateTime := 0

	/*
	Field: dwHighDateTime
	The high-order part of the file time.
	*/
	dwHighDateTime := 0

	/*
	Method: Constructor

	Parameters:
		[opt] UINT low - the initial value for the dwLowDateTime field.
		[opt] UINT high - the initial value for the dwHighDateTime field.
	*/
	__New(low := 0, high := 0)
	{
		this.dwLowDateTime := low, this.dwHighDateTime := high
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

		NumPut(this.dwLowDateTime,	struct,	0,	"UInt")
		NumPut(this.dwHighDateTime,	struct,	4,	"UInt")

		return &struct
	}

	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class

	Parameters:
		UPTR ptr - a pointer to a FILETIME struct in memory

	Returns:
		FILETIME instance - the new FILETIME instance
	*/
	FromStructPtr(ptr)
	{
		return new FILETIME(NumGet(ptr, 00, "UInt"), NumGet(ptr, 04, "UInt"))
	}

	/*
	Method: FromSYSTEMTIME
	(static) method that converts a SYSTEMTIME instance to a FILETIME instance

	Parameters:
		SYSTEMTIME src - the SYSTEMTIME instance to convert

	Returns:
		FILETIME instance - the new FILETIME instance
	*/
	FromSYSTEMTIME(src)
	{
		if (IsObject(src))
			src := src.ToStructPtr()
		VarSetCapacity(dest, 8, 0)
		DllCall("SystemTimeToFileTime", "ptr", src, "ptr", &dest)
		return FILETIME.FromStructPtr(&dest)
	}
}