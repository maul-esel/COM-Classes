class Picture extends Unknown
{
	static IID := "{7BF80980-BF32-101A-8BBB-00AA00300CAB}"
	
	static ThrowOnCreation := true
	
	__Get(property)
	{
		if (property = "handle")
			return this.get_Handle()
		else if (property = "hPal")
			return this.get_hPal()
		else if (property = "Type")
			return this.get_Type()
		else if (property = "width")
			return this.get_Width()
		else if (property = "height")
			return this.get_Height()
		else if (property = "CurDC")
			return this.get_CurDC()
		else if (property = "KeepOriginalFormat")
			return this.get_KeepOriginalFormat()
		else if (property = "Attributes")
			return this.get_Attributes()
	}
	
	__Set(property, value)
	{
		if (property = "hPal")
			this.set_hPal(value)
		else if (property = "KeepOriginalFormat")
			this.put_KeepOriginalFormat(value)
	}
	
	get_Handle()
	{
		this._Error(DllCall(NumGet(this.vt+03*A_PtrSize), "ptr", this.ptr, "uint*", handle))
		return handle
	}
	
	get_hPal()
	{
		this._Error(DllCall(NumGet(this.vt+04*A_PtrSize), "ptr", this.ptr, "uint*", hPal))
		return hPal
	}
	
	get_Type()
	{
		this._Error(DllCall(NumGet(this.vt+05*A_PtrSize), "ptr", this.ptr, "short*", type))
		return type
	}
	
	get_Width()
	{
		this._Error(DllCall(NumGet(this.vt+06*A_PtrSize), "ptr", this.ptr, "int*", width))
		return width
	}
	
	get_Height()
	{
		this._Error(DllCall(NumGet(this.vt+07*A_PtrSize), "ptr", this.ptr, "int*", height))
		return height
	}
	
	Render(dc, x, y, w, h, xSrc, ySrc, wSrc, hSrc, rect := 0)
	{
		return this._Error(DllCall(NumGet(this.vt+08*A_PtrSize), "ptr", this.ptr, "int", x, "int", y, "int", w, "int", h, "int", xSrc, "int", ySrc, "int", wSrc, "int", hSrc, "ptr", rect))
	}
	
	set_hPal(value)
	{
		return this._Error(DllCall(NumGet(this.vt+09*A_PtrSize), "ptr", this.ptr, "uint", value))
	}
	
	get_CurDC()
	{
		this._Error(DllCall(NumGet(this.vt+10*A_PtrSize), "ptr", this.ptr, "ptr*", hDC))
		return hDC
	}
	
	SelectPicture(newHDC, byRef outHDC := "", byRef outHBMP := "")
	{
		return this._Error(DllCall(NumGet(this.vt+11*A_PtrSize), "ptr", this.ptr, "ptr", newHDC, "ptr*", outHDC, "ptr*", outHBMP))
	}
	
	get_KeepOriginalFormat()
	{
		this._Error(DllCall(NumGet(this.vt+12*A_PtrSize), "ptr", this.ptr, "uint*", keep))
		return keep
	}
	
	put_KeepOriginalFormat(value)
	{
		return this._Error(DllCall(NumGet(this.vt+13*A_PtrSize), "ptr", this.ptr, "uint", value))
	}
	
	PictureChanged()
	{
		return this._Error(DllCall(NumGet(this.vt+14*A_PtrSize), "ptr", this.ptr))
	}
	
	SaveAsFile(stream, fSaveMemCopy)
	{
		this._Error(DllCall(NumGet(this.vt+15*A_PtrSize), "ptr", this.ptr, "ptr", (IsObject(stream) ? stream.ptr : stream), "uint", fSaveMemCopy, "int*", cbSize))
		return cbSize
	}
	
	get_Attributes()
	{
		this._Error(DllCall(NumGet(this.vt+16*A_PtrSize), "ptr", this.ptr, "uint*", attr))
		return attr
	}
}