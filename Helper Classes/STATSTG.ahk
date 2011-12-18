/*
class: STATSTG
This class represents a STATSTG struct.
The STATSTG structure contains statistical data about an open storage, stream, or byte-array object. This structure is used in the IEnumSTATSTG, ILockBytes, IStorage, and IStream interfaces.
*/
class STATSTG
{
	/*
	Field: pwcsName
	a string that contains the name. Space for this string is allocated by the method called and freed by the caller. To not return this member, specify the STATFLAG.NONAME value when you call a method that returns a STATSTG structure, except for calls to IEnumSTATSTG::Next, which provides no way to specify this value.
	*/
	pwcsName := 0

	/*
	Field: type
	Indicates the type of storage object. This is one of the values from the STGTY enumeration.
	*/
	type := 0

	/*
	Field: cbSize
	Specifies the size, in bytes, of the stream or byte array.
	*/
	cbSize := 0

	/*
	Field: mtime
	A FILETIME instance that indicates the last modification time for this storage, stream, or byte array.
	*/
	mtime := new FILETIME()

	/*
	Field: ctime
	A FILETIME instance that indicates the creation time for this storage, stream, or byte array.
	*/
	ctime := new FILETIME()

	/*
	Field: atime
	A FILETIME structure that indicates the last access time for this storage, stream, or byte array.
	*/
	atime := new FILETIME()

	/*
	Field: grfMode
	Indicates the access mode specified when the object was opened. This member is only valid in calls to Stat methods.
	*/
	grfMode := 0

	/*
	Field: grfLocksSupported
	Indicates the types of region locking supported by the stream or byte array. For more information about the values available, see the LOCKTYPE enumeration. This member is not used for storage objects.
	*/
	grfLocksSupported := 0

	/*
	Field: clsid
	Indicates the class identifier for the storage object; set to CLSID_NULL for new storage objects. This member is not used for streams or byte arrays.

	Remarks:
		Set this field to the CLSID's string representation.
	*/
	clsid := 0

	/*
	Field: grfStateBits
	Indicates the current state bits of the storage object; that is, the value most recently set by the IStorage::SetStateBits method. This member is not valid for streams or byte arrays.
	*/
	grfStateBits := 0

	/*
	Field: reserved
	Reserved for future use.
	*/
	reserved := 0

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
			VarSetCapacity(struct, A_PtrSize + 68, 0)
			ptr := &struct
		}

		NumPut(this.GetAdress("pwcsName"),	1*ptr,		00 + 0*A_PtrSize,	"UPtr")
		NumPut(this.type,					1*ptr,		00 + 1*A_PtrSize,	"UInt")
		NumPut(this.cbSize,					1*ptr,		04 + 1*A_PtrSize,	"UInt64")
		this.mtime.ToStructPtr(ptr + 12 + A_PtrSize)
		this.ctime.ToStructPtr(ptr + 20 + A_PtrSize)
		this.atime.ToStructPtr(ptr + 28 + A_PtrSize)
		NumPut(this.grfMode,				1*ptr,		36 + 1*A_PtrSize,	"UInt")
		NumPut(this.grfLocksSupported,		1*ptr,		40 + 1*A_PtrSize,	"UInt")
		DllCall("Ole32\CLSIDFromString", "str", this.clsid, "ptr", ptr + 44 + A_PtrSize)
		NumPut(this.grfStateBits,			1*ptr,		60 + 1*A_PtrSize,	"UInt")
		NumPut(this.reserved,				1*ptr,		64 + 1*A_PtrSize,	"UInt")

		return &struct
	}

	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class

	Parameters:
		UPTR ptr - a pointer to a STATSTG struct in memory

	Returns:
		STATSTG instance - the new STATSTG instance
	*/
	FromStructPtr(ptr)
	{
		instance := new STATSTG()

		instance.pwcsName			:= StrGet(NumGet(1*ptr, 0,	"UPtr"),	"UTF-16")
		instance.type				:= NumGet(1*ptr,	00 + 1*A_PtrSize,	"UInt")
		instance.cbSize				:= NumGet(1*ptr,	04 + 1*A_PtrSize,	"UInt64")
		instance.mtime := FILETIME.FromStructPtr(ptr + 12 + A_PtrSize)
		instance.ctime := FILETIME.FromStructPtr(ptr + 20 + A_PtrSize)
		instance.atime := FILETIME.FromStructPtr(ptr + 28 + A_PtrSize)
		instance.grfMode			:= NumGet(1*ptr,	36 + 1*A_PtrSize,	"UInt")
		instance.grfLocksSupported	:= NumGet(1*ptr,	40 + 1*A_PtrSize,	"UInt")
		DllCall("Ole32\StringFromCLSID", "ptr", ptr + 44 + A_PtrSize, "ptr*", clsid)
		instance.clsid				:= StrGet(clsid, "UTF-16")
		instance.grfStateBits		:= NumGet(1*ptr,	60 + 1*A_PtrSize,	"UInt")
		instance.reserved			:= NumGet(1*ptr,	64 + 1*A_PtrSize,	"UInt")

		return instance
	}
}