/*
class: Unknown
implements the IUnknown interface and provides meta-functions and helper methods for inherited classes.

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - (any)
	Base classes - (none)
	Helper classes - (none)
*/
class Unknown
{
	/*
	Field: IID_IUnknown
	This is IID_IUnknown. It may be used by inherited classes.
	*/
	static IID_IUnknown := "{00000000-0000-0000-C000-000000000046}"

	/*
	Field: Error
	an object holding the last error code and its description

	Fields:
		HRESULT code - the HRESULT error code
		STR description - the error description string in the system's language

	Remarks:
		This field is updated by the internal helper method <_Error>, which should be called by almost all methods in inherited classes.
	*/
	Error := { "code" : 0, "description" : "" }

	/*
	Field: ThrowOnCreation
	determines whether the creation of a new instance, without a given pointer, should throw an exception. False by default.

	Developer remarks:
		Inherited classes may override this and set it to TRUE if they can't provide a direct creation of a class by calling ComObjCreate().
		This causes an exception to be thrown. You should document this in your class.
	*/
	static ThrowOnCreation := false

	/*
	group: metafunctions

	Method: __New
	constructor for all inherited classes

	Parameters:
		[opt] UPTR ptr - a pointer to an already created instance of the COM class.

	Remarks:
		If ptr is not given, a new instance is created using the class' IID and CLSID fields, passing them to ComObjCreate().

	Developer remarks:
		To make this working, you must define the correct IID and CLSID in your class.

		This makes available 2 instance fields:
			UPTR ptr - the pointer to the object
			UPTR vt - the pointer to the object's vTable
	*/
	__New(ptr := 0)
	{
		if (!ptr)
		{
			if (this.base.ThrowOnCreation)
			{
				throw Exception("This class does not support direct creation: " . this.base.__class, -1)
			}
			else
			{
				this.ptr := ComObjCreate(this.base.CLSID, this.base.IID)
			}
		}
		else
		{
			this.ptr := ptr
		}
		this.vt := NumGet(this.ptr + 0)
	}

	/*
	Method: __Delete
	deconstructor for all inherited classes.

	Remarks:
		In most cases, you don't call this from your code.
	*/
	__Delete()
	{
		return ObjRelease(this.ptr)
	}

	/*
	group: internal functions

	Method: _GUID
	internal helper method for inherited classes that converts a GUID string to a pointer to a GUID.

	Parameters:
		byRef GUID guid - a variable that receives the GUID
		STR sGUID - the string representation of the GUID

	Returns:
		UPTR pointer - a pointer to the new GUID.

	Developer remarks:
		In cases where you need to pass a IID or CLSID to a method, you can use this to create it inline.
	*/
	_GUID(byRef guid, sGUID)
	{
		VarSetCapacity(guid, 16, 0)
		return DllCall("ole32\CLSIDFromString", "str", sGUID, "ptr", &guid) == 0x00 ? &guid : 0
	}

	/*
	Method: _Error
	internal helper function for inherited classes that updates the instance's <Error> object.

	Parameters:
		HRESULT error - the error code to work on

	Returns:
		BOOL success - a bool indicating success (true = success, false otherwise)

	Developer remarks:
		Pass any HRESULT return values to this function to update the Error field.
		In most cases, you should also return this function's return value.

		In case your method doesn't return a HRESULT, call this methd with error code 0 to clear the object.
	*/
	_Error(error)
	{
		this.Error.code := error
		
		buffer_size := VarSetCapacity(buffer, 1024, 0)
		DllCall("FormatMessageW", "uint", 0x1200, "ptr", 0, "uint", error, "uint", 0x10000, ptr, &buffer, "uint", buffer_size, ptr, 0)
		error_msg := StrGet(&buffer)

		this.Error.description := error " - " error_msg
		
		return error == 0x00
	}

	/*
	group: IUnknown

	Method: QueryInterface
	Queries the COM object for an interface.

	Parameters:
		string sIID - the string representation of the queried interface

	Returns:
		UPTR pointer - a pointer to the interface or zero.
	*/
	QueryInterface(sIID)
	{
		return ComObjQuery(this.ptr, sIID)
	}

	/*
	Method: AddRef
	Increment's the object's reference count.
	*/
	AddRef()
	{
		return ObjAddRef(this.ptr)
	}

	/*
	Function: Release
	Decrements the object's reference count.
	*/
	Release()
	{
		return ObjRelease(this.ptr)
	}
}