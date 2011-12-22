/*
class: ObjectArray
implements IObjectArray and exposes methods that enable clients to access items in a collection of objects that support IUnknown.

Requirements:
	AutoHotkey - AHK_L v1.1+
	OS - Windows 7 / Windows Server 2008 R2 or higher
	Base classes - Unknown
	Helper classes - (none)

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/dd378311)
*/
class ObjectArray extends Unknown
{
	/*
	Field: IID
	This is IID_IObjectArray. It is required to create an instance.
	*/
	static IID := "{92CA9DCD-5622-4bba-A805-5E9F541BD8C9}"

	/*
	Field: ThrowOnCreation
	indicates that attempting to create an instance of this class without supplying a valid pointer should throw an exception.
	*/
	static ThrowOnCreation := true

	/*
	Method: GetCount
	Provides a count of the objects in the collection.

	Returns:
		UINT count - the object count
	*/
	GetCount()
	{
		this._Error(DllCall(NumGet(this.vt+03*A_PtrSize), "ptr", this.ptr, "UInt*", count))
		return count
	}

	/*
	Method: GetAt
	Provides a pointer to a specified object's interface. The object and interface are specified by index and interface ID.

	Parameters:
		UINT index - The index of the object
		IID type - Reference to the desired interface ID. This can either be a IID string or a pointer.

	Returns:
		UPTR obj - the interface pointer
	*/
	GetAt(index, type)
	{
		if type is not integer
			type := this._GUID(type)
		this._Error(DllCall(NumGet(this.vt+04*A_PtrSize), "ptr", this.ptr, "UInt", index, "ptr", type, "ptr*", out))
		return out
	}
}