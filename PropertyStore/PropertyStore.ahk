/*
class: PropertyStore
implements the IPropertyStore interface and exposes methods for enumerating, getting, and setting property values.

Requirements:
	AutoHotkey - AHK_L v1.1+
	OS - Windows Vista / Windows Server 2008 or higher
	Base classes - Unknown
	Helper classes - PROPERTYKEY

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/bb761474)
*/
class PropertyStore extends Unknown
{
	/*
	Field: IID
	This is IID_IPropertyStore. It is required to create an instance.
	*/
	static IID := "{886d8eeb-8cf2-4446-8d02-cdba1dbdcf99}"

	/*
	Field: CLSID
	This is CLSID_InMemoryPropertyStore. It is required to create an instance.
	*/
	static CLSID := "{9a02e012-6303-4e1e-b9a1-630f802592c5}"

	/*
	Method: GetCount
	Gets the number of properties attached to the file.

	Returns:
		UINT count - the property count
	*/
	GetCount()
	{
		this._Error(DllCall(NumGet(this.vt+03*A_PtrSize), "ptr", this.ptr, "uint*", count))
		return count
	}

	/*
	Method: GetAt
	Gets a property key from an item's array of properties.

	Parameters:
		UINT index - The index of the property key in the array of PROPERTYKEY structures. This is a zero-based index.

	Returns:
		UPTR ptr - a PROPERTYKEY instance
	*/
	GetAt(index)
	{
		this._Error(DllCall(NumGet(this.vt+04*A_PtrSize), "ptr", this.ptr, "uint", index, "ptr*", out))
		return new PROPERTYKEY(out)
	}

	/*
	Method: GetValue
	Gets data for a specific property.

	Parameters:
		PROPERTYKEY key - a reference to the PROPERTYKEY structure retrieved through IPropertyStore::GetAt (either a raw memory pointer or a PROPERTYKEY instance).

	Parameters:
		UPTR ptr - a pointer to a PROPVARIANT structure *(To be replaced by PROPVARIANT instance!)*
	*/
	GetValue(key)
	{
		if IsObject(key)
			key := key.ToStructPtr()
		this._Error(DllCall(NumGet(this.vt+05*A_PtrSize), "ptr", this.ptr, "ptr", key, "ptr*", out))
		return out
	}

	/*
	Method: SetValue
	Sets a new property value, or replaces or removes an existing value.

	Parameters:
		PROPERTYKEY key - a reference to the PROPERTYKEY structure retrieved through IPropertyStore::GetAt (either a raw memory pointer or a PROPERTYKEY instance).
		UPTR ptr - a pointer to a PROPVARIANT structure

	Returns:
		BOOL success - true on success, false otherwise
	*/
	SetValue(key, value)
	{
		if IsObject(key)
			key := key.ToStructPtr()
		return this._Error(DllCall(NumGet(this.vt+06*A_PtrSize), "ptr", this.ptr, "ptr", key, "ptr", value))
	}

	/*
	Method: Commit
	Saves a property change.

	Returns:
		BOOL success - true on success, false otherwise
	*/
	Commit()
	{
		return this._Error(DllCall(NumGet(this.vt+07*A_PtrSize), "ptr", this.ptr))
	}
}