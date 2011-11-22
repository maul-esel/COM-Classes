class PropertyStore extends Unknown
{
	static IID := "{886d8eeb-8cf2-4446-8d02-cdba1dbdcf99}"
	
	static CLSID := "{9a02e012-6303-4e1e-b9a1-630f802592c5}"
	
	GetCount()
	{
		this._Error(DllCall(NumGet(this.vt+03*A_PtrSize), "ptr", this.ptr, "uint*", count))
		return count
	}
	
	GetAt(index)
	{
		this._Error(DllCall(NumGet(this.vt+04*A_PtrSize), "ptr", this.ptr, "uint", index, "ptr*", out))
		return out
	}
	
	GetValue(key)
	{
		this._Error(DllCall(NumGet(this.vt+05*A_PtrSize), "ptr", this.ptr, "ptr", key, "ptr*", out))
		return out
	}
	
	SetValue(key, value)
	{
		return this._Error(DllCall(NumGet(this.vt+06*A_PtrSize), "ptr", this.ptr, "ptr", key, "ptr", value))
	}
	
	Commit()
	{
		return this._Error(DllCall(NumGet(this.vt+07*A_PtrSize), "ptr", this.ptr))
	}
}