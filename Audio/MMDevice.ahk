class MMDevice extends Unknown
{
	static CLSID := ""
	
	static IID := "{D666063F-1587-4E43-81F1-B948E807363F}"
	
	; enum at http://msdn.microsoft.com/en-us/library/ms693716%28VS.85%29.aspx
	Activate(outputType, clsctx, params := 0)
	{
		this._Error(DllCall(NumGet(this.vt+03*A_PtrSize), "ptr", this.ptr, "ptr", this._GUID(outputType.IID), "uint", clsctx, "uint", params, "ptr*", out))
		return new outputType(out)
	}
	
	OpenPropertyStore(access)
	{
		access := (access == "read-write" ? 0x00000002 : (access == "write" ? 	0x00000001 : 0x00000000))
		this._Error(DllCall(NumGet(this.vt+04*A_PtrSize), "ptr", this.ptr, "uint", access, "ptr*", store))
		return new PropertyStore(store)
	}
	
	GetId()
	{
		this._Error(DllCall(NumGet(this.vt+05*A_PtrSize), "ptr", this.ptr, "str*", id))
		return id	
	}
	
	GetState()
	{
		this._Error(DllCall(NumGet(this.vt+06*A_PtrSize), "ptr", this.ptr, "uint*", state))
		return state	
	}

}