/*
class: FILETIME
This class represents a FILETIME struct.
The FILETIME structure contains a 64-bit value representing the number of 100-nanosecond intervals since January 1, 1601 (UTC).

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ms724284)
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
	__New(low = 0, high = 0)
	{
		this.dwLowDateTime := low, this.dwHighDateTime := high
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
		static struct

		if (!ptr)
		{
			VarSetCapacity(struct, 8, 0)
			ptr := &struct
		}

		NumPut(this.dwLowDateTime,	1*ptr,	0,	"UInt")
		NumPut(this.dwHighDateTime,	1*ptr,	4,	"UInt")

		return ptr
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
		return new FILETIME(NumGet(1*ptr, 00, "UInt"), NumGet(1*ptr, 04, "UInt"))
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