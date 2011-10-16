class AudioEndpointVolume extends Unknown
{
	static CLSID := ""
	
	static IID := "{5CDF2C82-841E-4546-9722-0CF74078229A}"
	
	SetMasterVolumeLevel(level, event = 0)
	{
		return this._Error(DllCall(NumGet(this.vt+06*A_PtrSize), "ptr", this.ptr, "float", level, "uint", event))	
	}
}