/**************************************************************************************************************
class: Unknown
implements the IUnknown interface and provides meta-functions and helper methods for inherited classes.
***************************************************************************************************************
*/
class Unknown
	{
	/**************************************************************************************************************
	Variable: Error
	an object holding the last error code and its description
	
	Fields:
		code - the HRESULT error code
		description - the error description string in the system's language
	***************************************************************************************************************
	*/
	Error := { "code" : 0, "description" : "" }
	
	/**************************************************************************************************************
	Variable: ThrowOnCreation
	determines whether the creation of a new instance, without a given pointer, should throw an exception.
	False by default.
	***************************************************************************************************************
	*/
	static ThrowOnCreation := false
	
	/**************************************************************************************************************
	group: metafunctions
	
	Function: __New
	constructor for all inherited classes
	
	Parameters:
		[opt] uint ptr - a pointer to an already created instance of the interface.
	
	Remarks:
		If ptr is not given, a new instance is created using the class' IID and CLSID fields.
		
	Developer remarks:
		To make this working, you must define the correct IID and CLSID in your class.
		
		This makes available 2 fields:
			ptr ptr - the pointer to the object
			ptr vt - the pointer to the object's vTable
	***************************************************************************************************************
	*/
	__New(ptr := 0){
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
			this.ptr := ptr
		this.vt := NumGet(this.ptr + 0)
		}

	/**************************************************************************************************************
	Function: __Delete
	deconstructor for all inherited classes.
	
	Remarks:
		In most cases, you don't call this from your code.
	***************************************************************************************************************
	*/
	__Delete(){
		return ObjRelease(this.ptr)
		}

	/**************************************************************************************************************
	group: private functions
	
	Function: _GUID
	internal helper function for inherited classes.
	
	Parameters:
		byref GUID - a variable that receives the new GUID
		string sGUID - the string representation of the GUID
		
	Returns:
		uint pointer - a pointer to the new GUID.
	
	Developer remarks:
		In cases where you need to pass a IID to a method, you can use this to create it inline.
	***************************************************************************************************************
	*/
	_GUID(ByRef GUID, sGUID){
		VarSetCapacity(GUID, 16, 0)
		return DllCall("ole32\CLSIDFromString", "wstr", sGUID, "ptr", &GUID) >= 0 ? &GUID : ""
		}

	/**************************************************************************************************************
	Function: _Error
	internal helper function for inherited classes.
	
	Parameters:
		HRESULT error - the error code to work on
		
	Returns:
		bool success - a bool indicating success (true = success, false otherwise)
		
	Developer remarks:
		Pass any HRESULT return values to this function to update the Error field.
		In most cases, you should also return this function's return value.
	***************************************************************************************************************
	*/
	_Error(error)
		{
		this.Error.code := error
		
		buffer_size := VarSetCapacity(buffer, 1024, 0)
		DllCall("FormatMessageW", "uint", 0x1200, "ptr", 0, "uint", error, "uint", 0x10000, ptr, &buffer, "uint", buffer_size, ptr, 0)
		error_msg := StrGet(&buffer)

		this.Error.description := error " - " error_msg
		
		return error >= 0
		}

	/**************************************************************************************************************
	group: IUnknown
	
	Function: QueryInterface
	Queries the COM object for an interface.
	
	Parameters:
		string rIID - the string representation of the queried interface
		
	Returns:
		uint pointer - a pointer to the interface or zero.
	***************************************************************************************************************
	*/
	QueryInterface(rIID){
		return ComObjQuery(this.ptr, rIID)
		}

	/**************************************************************************************************************
	Function: AddRef
	Increment's the object's reference count.
	***************************************************************************************************************
	*/
	AddRef(){
		return ObjAddRef(this.ptr)
		}

	/**************************************************************************************************************
	Function: Release
	Decrements the object's reference count.
	***************************************************************************************************************
	*/
	Release(){
		return ObjRelease(this.ptr)
		}
	}