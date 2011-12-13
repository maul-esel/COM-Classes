/*
class: Persist
implements IPersist and provides the CLSID of an object that can be stored persistently in the system.

Requirements:
	AutoHotkey - AHK v1.1+
	OS - Windows 2000 Professional / Windows XP / Windows Server 2003 or higher
	Base classes - Unknown
	Helper classes - (none)
*/
class Persist extends Unknown
{
	/*
	Field: IID
	This is IID_IPersist. It is required to create an instance.
	*/
	static IID := "{0000010c-0000-0000-C000-000000000046}"

	/*
	Field: ThrowOnCreation
	indicates that attempting to create an instance of this class without supplying a valid pointer should throw an exception.
	*/
	static ThrowOnCreation := true

	/*
	Method: GetClassID
	Retrieves the class identifier (CLSID) of the object.

	Returns:
		STR clsid - the CLSID of the object (as string)
	*/
	GetClassID()
	{
		VarSetCapacity(guid, 16, 0)
		this._Error(DllCall(NumGet(this.vt+3*A_PtrSize), "ptr", this.ptr, "ptr", &guid))
		DllCall("Ole32.dll\StringFromCLSID", "ptr", &guid, "ptr*", clsid)
		return StrGet(clsid, "UTF-16")
	}
}