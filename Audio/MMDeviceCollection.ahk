class MMDeviceCollection extends Unknown
{
	static CLSID := ""
	
	static IID := "{0BD7A1BE-7A1A-44DB-8397-CC5392387B5E}"
	
	GetCount()
	{
		this._Error(DllCall(NumGet(this.vt+03*A_PtrSize), "ptr", this.ptr, "uint*", count))
		return count
	}
	
	Item(index)
	{
		this._Error(DllCall(NumGet(this.vt+04*A_PtrSize), "ptr", this.ptr, "uint", index, "ptr*", device))
		return new MMDevice(device)	
	}
}