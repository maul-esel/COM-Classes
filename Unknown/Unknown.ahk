class Unknown
	{
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
	
	__GUID(ByRef GUID){
		VarSetCapacity(GUID, 16, 0)
		return DllCall("ole32.dll\CLSIDFromString", "str", sGUID, "ptr", &GUID) >= 0 ? &GUID : ""
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