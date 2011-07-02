class Unknown
	{
	var Error := { "code" : 0, "description" : "" }
	
	__New(ptr = 0){
		if (!ptr)
			this.ptr := ComObjCreate(this.CLSID, this.IID)
		else
			this.ptr := ptr
		this.vt := NumGet(this.ptr + 0)
		}

	__Delete(){
		return ObjRelease(this.ptr)
		}
	
	__GUID(ByRef GUID, sGUID){
		VarSetCapacity(GUID, 16, 0)
		return DllCall("ole32\CLSIDFromString", "wstr", sGUID, "ptr", &GUID) >= 0 ? &GUID : ""
		}
		
	__Error(error)
		{
		this.Error.code := error
		
		buffer_size := VarSetCapacity(buffer, 1024, 0)
		DllCall("FormatMessageW", "uint", 0x1200, "ptr", 0, "uint", error, "uint", 0x10000, ptr, &buffer, "uint", buffer_size, ptr, 0)
		error_msg := StrGet(&buffer)

		this.Error.description := error " - " error_msg
		
		return error >= 0
		}

	QueryInterface(riid){
		return ComObjQuery(this.ptr, riid)
		}

	AddRef(){
		return ObjAddRef(this.ptr)
		}

	Release(){
		return ObjRelease(this.ptr)
		}
	}