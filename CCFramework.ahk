/*
class: CCFramework
the main class for the framework that has a lot of methods to ease the handling of other classes.

Remarks:
	This class cannot be instantiated.
*/
class CCFramework extends _CCF_Error_Handler_
{
	/*
	Field: heap
	static field that holds the process heap. For internal use only.
	*/
	static heap := DllCall("GetProcessHeap", "UPtr")

	/*
	Method: constructor
	throws an exception when an attempt is made to create an instance of this class
	*/
	__New(p*)
	{
		throw Exception("CCFramework: This class must not be instantiated!", -1)
	}

	/*
	Method: GUID2String
	Converts a GUID structure in memory to its string representation.

	Parameters:
		UPTR guid - the pointer to the GUID structure

	Returns:
		STR string - the string representation of the GUID.
	*/
	GUID2String(guid)
	{
		local string
		DllCall("Ole32.dll\StringFromCLSID", "UPtr", guid, "UPtr*", string)
		return StrGet(string, "UTF-16")
	}

	/*
	Method: String2GUID
	Converts a string represntation of a GUID to a GUID structure in memory.

	Parameters:
		STR string - the string representation
		[opt] UPTR guid - the pointer where to place the GUID in memory.

	Returns:
		UPTR guid - the pointer to the GUID structure.

	Remarks:
		If the "guid" parameter is ommitted, memory is allocted using <AllocateMemory>. In this case, you may pass the pointer returned by this method to <FreeMemory()> when you don't need the GUID any longer.
	*/
	String2GUID(string, guid = 0)
	{
		if (!guid)
			guid := CCFramework.AllocateMemory(16)
		return DllCall("ole32\CLSIDFromString", "Str", string, "UPtr", guid) >= 0 ? guid : 0
	}

	/*
	Method: AllocateMemory
	allocates a specified amount of memory

	Parameters:
		UINT bytes - the number of bytes to allocate

	Returns:
		UPTR buffer - the pointer to the allocated memory.

	Remarks:
		When you no longer need the memory, you should pass the pointer returned by this method to <FreeMemory()>.
	*/
	AllocateMemory(bytes)
	{
		static HEAP_GENERATE_EXCEPTIONS := 0x00000004, HEAP_ZERO_MEMORY := 0x00000008
		return DllCall("HeapAlloc", "UPtr", CCFramework.heap, "UInt", HEAP_GENERATE_EXCEPTIONS|HEAP_ZERO_MEMORY, "UInt", bytes)
	}

	/*
	Method: FreeMemory
	Frees memory previously allocated by <AllocateMemory>.

	Parameters:
		UPTR buffer - the memory pointer as returned by <AllocateMemory()>.

	Returns:
		BOOL success - true on success, false otherwise
	*/
	FreeMemory(buffer)
	{
		return DllCall("HeapFree", "UPtr", CCFramework.heap, "UInt", 0, "UPtr", buffer)
	}

	/*
	Method: CopyMemory
	Copies memory from one locatin to another

	Parameters:
		UPTR src - the pointer to the source memory
		UPTR dest - the pointer to the memory to copy data to
		UINT size - the number of bytes to copy
	*/
	CopyMemory(src, dest, size)
	{
		DllCall("RtlMoveMemory", "UPtr", dest, "UPtr", src, "UInt", size)
	}

	/*
	Method: CreateVARIANT
	creates a VARIANT structure from a given value

	Parameters:
		VAR value - the value to store in the VARIANT structure

	Returns:
		OBJ variant - an object representing the variant, containing 2 fields:
			UPTR ref - the pointer to the VARIANT structure
			SAFEARRAY array - an AHK-wrapper object for a safearray which has 1 dimension with 1 field (index 0) that contains the given value

	Remarks:
		The type is calculated automatically based on the value. If you want it to have a special type, create a value with ComObjParameter:
		> dispVariant := CCFramework.CreateVARIANT(ComObjParameter(VT_DISPATCH, disp_ptr))
	*/
	CreateVARIANT(value)
	{
		static VT_VARIANT := 0xC, VT_BYREF := 0x4000
		local array, arr_data

		array := ComObjArray(VT_VARIANT, 1)
		array[0] := value

		/* Work in progress:
		 *	DllCall("oleaut32\SafeArrayAccessData", "UPtr", ComObjValue(array), "UPtr*", arr_data)
		 *	DllCall("oleaut32\SafeArrayUnaccessData", "UPtr", ComObjValue(array))
		 */
		VarSetCapacity(arr_data, 16, 00), DllCall("oleaut32\SafeArrayGetElement", "Ptr", ComObjValue(array), "Int*", 0, "Ptr", arr_data)

		/* Work in progress:
		 *	return { "ref" : ComObjValue(ComObjParameter(VT_BYREF|VT_VARIANT, arr_data)), "array" : array }
		 */
		return { "ref" : arr_data }
	}

	/*
	Method: CreateVARIANTARG
	an alias for <CreateVARIANT>.
	*/
	CreateVARIANTARG(value)
	{
		return CCFramework.CreateVARIANT(value)
	}

	/*
	Method: FormatError
	retrieves the error message for a HRESULT error code

	Parameters:
		HRESULT error - the error code, e.g. A_LastError

	Returns:
		STR description - the error message

	Credits:
		Inspired by Bentschi's A_LastError() (<http://de.autohotkey.com/forum/viewtopic.php?t=8010>)
	*/
	FormatError(error)
	{
		static ALLOCATE_BUFFER := 0x00000100, FROM_SYSTEM := 0x00001000, IGNORE_INSERTS := 0x00000200
		local size, msg, bufaddr

		size := DllCall("FormatMessageW", "UInt", ALLOCATE_BUFFER|FROM_SYSTEM|IGNORE_INSERTS, "UPtr", 0, "UInt", error, "UInt", 0, "UPtr*", bufaddr, "UInt", 0, "UPtr", 0)
		msg := StrGet(bufaddr, size, "UTF-16")

		return error . " - " . msg
	}

	/*
	Method: HasEnumFlag
	checks if a given binary combination of flags includes a specified flag

	Parameters:
		UINT var - the combination to test
		UINT flag - the flag to test for

	Returns:
		BOOL included - true if the flag is included, false otherwise

	Remarks:
		All flags added to "var" as well as "flag" must be powers of 2.
	*/
	HasEnumFlag(var, flag)
	{
		return (var & flag) == flag
	}
}