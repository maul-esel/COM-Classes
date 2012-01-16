/*
class: TypeInfo
wraps the *ITypeInfo* interface and is used for reading information about objects.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lgpl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/TypeInfo)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ms221696%28v=VS.85%29)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - (unknown)
	Base classes - Unknown
	Other classes - (TypeComp)
	Helper classes - DISPID, MEMBERID, (TYPEATTR), TYPEKIND, IDLDESC, (TYPEDESC)
*/
class TypeInfo extends Unknown
{
	/*
	Field: IID
	This is IID_ITypeInfo. It is required to create an instance.
	*/
	static IID := "{00020401-0000-0000-C000-000000000046}"

	/*
	Field: ThrowOnCreation
	indicates that attempting to create an instance of this class without supplying a valid pointer should throw an exception.
	*/
	static ThrowOnCreation := true

	/*
	Method: GetTypeAttr
	Retrieves a TYPEATTR structure that contains the attributes of the type description.

	Returns:
		TYPEATTR info - an instance of the TYPEATTR class containing the information
	*/
	GetTypeAttr()
	{
		this._Error(DllCall(NumGet(this.vt+03*A_PtrSize), "ptr", this.ptr, "ptr*", out))
		return TYPEATTR.FromStructPtr(out)
	}

	/*
	Method: GetTypeComp
	Retrieves the ITypeComp interface for the type description, which enables a client compiler to bind to the type description's members.

	Returns:
		TypeComp comp - the retrieved interface
	*/
	GetTypeComp()
	{
		this._Error(DllCall(NumGet(this.vt+04*A_PtrSize), "ptr", this.ptr, "ptr*", out))
		return IsObject(TypeComp) ? new TypeComp(out) : out
	}

	/*
	Method: GetFuncDesc
	Retrieves the FUNCDESC structure that contains information about a specified function.

	Parameters:
		UINT index - The index of the function whose description is to be returned. The index should be in the range of 0 to 1 less than the number of functions in this type.

	Returns:
		FUNCDESC func - the retrieved structure that describes the specified function

	Remarks:
		Use <ReleaseFuncDesc> to free the structure.
	*/
	GetFuncDesc(index)
	{
		this._Error(DllCall(NumGet(this.vt+05*A_PtrSize), "ptr", this.ptr, "ptr*", out))
		return IsObject(FUNCDESC) ? FUNCDESC.FromStructPtr(out) : out
	}

	/*
	Method: GetVarDesc
	Retrieves a VARDESC structure that describes the specified variable.

	Parameters:
		UINT index - The index of the variable whose description is to be returned. The index should be in the range of 0 to 1 less than the number of variables in this type.

	Returns:
		VARDESC var - A VARDESC that describes the specified variable.

	Remarks:
		Use <ReleaseVarDesc> to free the structure.
	*/
	GetVarDesc(index)
	{
		this._Error(DllCall(NumGet(this.vt+06*A_PtrSize), "ptr", this.ptr, "ptr*", out))
		return IsObject(VARDESC) ? VARDESC.FromStructPtr(out) : out
	}

	/*
	Method: GetNames
	Retrieves the variable with the specified member ID or the name of the property or method and the parameters that correspond to the specified function ID.

	Parameters:
		INT memid - The ID of the member whose name (or names) is to be returned. For special values, you might use the MEMBERID (or DISPID) enum class for convenience.
		byRef OBJECT array - receives an AHK-array containing the names
		[opt] byRef UINT count - receives the number of names retrieved
		[opt] UINT name_count - optional: the size of the array. Defaults to 100, which should be sufficient in most cases.

	Returns:
		BOOL success - true on success, false otherwise.
	*/
	GetNames(memid, byRef array, byRef count := "", name_count := 100)
	{
		VarSetCapacity(arr, name_count * A_PtrSize, 0)
		bool := this._Error(DllCall(NumGet(this.vt+07*A_PtrSize), "ptr", this.ptr, "Int", memid, "ptr", &arr, "UInt", name_count, "UInt*", count))
		array := []
		Loop count
		{
			array.Insert(StrGet(NumGet(&arr + (A_Index - 1) * A_PtrSize, 00, "UPtr"), "UTF-16"))
		}
		VarSetCapacity(arr, 00)
		return bool
	}

	/*
	Method: GetRefTypeOfImplType
	If a type description describes a COM class, it retrieves the type description of the implemented interface types. For an interface, GetRefTypeOfImplType returns the type information for inherited interfaces, if any exist.

	Parameters:
		UINT index - The index of the implemented type whose handle is returned. The valid range is 0 to the cImplTypes field in the TYPEATTR structure.

	Returns:
		UINT handle - A handle for the implemented interface (if any). This handle can be passed to ITypeInfo::GetRefTypeInfo to get the type description.
	*/
	GetRefTypeOfImplType(index)
	{
		this._Error(DllCall(NumGet(this.vt+08*A_PtrSize), "ptr", this.ptr, "UInt", index, "UInt*", handle))
		return handle
	}

	/*
	Method: GetImplTypeFlags
	Retrieves the IMPLTYPEFLAGS enumeration for one implemented interface or base interface in a type description.

	Parameters:
		UINT index - The index of the implemented interface or base interface for which to get the flags.

	Returns:
		UINT flags - The IMPLTYPEFLAGS enumeration value.
	*/
	GetImplTypeFlags(index)
	{
		this._Error(DllCall(NumGet(this.vt+09*A_PtrSize), "ptr", this.ptr, "UInt", index, "UInt*", flags))
		return flags
	}

	/*
	Method: GetIDsOfNames
	Maps between member names and member IDs, and parameter names and parameter IDs.

	Parameters:
		ARRAY names - either an AHK-array or a pointer or a memory array containing the names
		[opt] UINT count - the count of the names in the array. If an AHK-array is passed, you can leave this empty.

	Returns:
		ARRAY ids - an AHK-array containing the IDs
	*/
	GetIDsOfNames(names, count := "")
	{
		if IsObject(names)
		{
			if (!count)
				count := names.maxIndex()
			VarSetCapacity(names_array, A_PtrSize * count, 00)
			Loop count
			{
				NumPut(names.GetAdress(A_Index), names_array, A_PtrSize * (A_Index - 1), "UPtr")
			}
		}
		VarSetCapacity(id_array, 4 * count, 00)
		this._Error(DllCall(NumGet(this.vt+10*A_PtrSize), "ptr", this.ptr, "ptr", IsObject(names) ? &names_array : names, "UInt", count, "UPtr", &id_array))
		ids := []
		Loop count
		{
			ids.Insert(NumGet(id_array, (A_Index - 1) * 4, "UInt"))
		}
		return ids
	}

	/*
	Method: Invoke
	Invokes a method, or accesses a property of an object, that implements the interface described by the type description.

	Parameters:
		UPTR instance - a pointer to an instance (or a class instance) of the interface described by this type description.
		UINT memid - the member id identifying the mamber to be called.
		UINT flags - Flags describing the context of the invoke call. You may use the fields of the DISPATCH enum class for convenience.

	*/
	Invoke(instance, memid, flags, byRef params, byRef result := "", byRef exception := "", byRef err_index := 0)
	{

	}
}