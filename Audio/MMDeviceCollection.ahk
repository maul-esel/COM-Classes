class MMDeviceCollection extends Unknown
{
	static CLSID := ""
	
	static IID := "{0BD7A1BE-7A1A-44DB-8397-CC5392387B5E}"
	
	GetCount()
	{
		local count
		this._Error(DllCall(NumGet(this.vt, 03*A_PtrSize, "Ptr"), "Ptr", this.ptr, "UInt*", count, "Int"))
		return count
	}
	
	Item(index)
	{
		local device
		this._Error(DllCall(NumGet(this.vt, 04*A_PtrSize, "Ptr"), "Ptr", this.ptr, "UInt", index, "Ptr*", device))
		return new MMDevice(device)	
	}
}