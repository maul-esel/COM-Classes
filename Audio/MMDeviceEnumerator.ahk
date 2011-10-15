/**************************************************************************************************************
class: MMDeviceEnumerator
extends Unknown

Requirements:
	- This requires AHK v2 alpha / AHK_L v1.1
	- It also requires Windows Vista, Windows 2008 Server or higher
***************************************************************************************************************	
*/
class MMDeviceEnumerator extends Unknown
{
	/**************************************************************************************************************
	Variable: CLSID
	This is CLSID_MMDeviceEnumerator. It is required to create the object.
	***************************************************************************************************************	
	*/
	static CLSID := "{BCDE0395-E52F-467C-8E3D-C4579291692E}"
	
	/**************************************************************************************************************
	Variable: IID
	This is IID_IMMDeviceEnumerator. It is required to create the object.
	***************************************************************************************************************	
	*/
	static IID := "{A95664D2-9614-4F35-A746-DE8DB63617E6}"
	
	/**************************************************************************************************************
	Function: EnumAudioEndpoints
	generates a collection of audio endpoint devices that meet the specified criteria.
	
	Parameters:
		dataFlow - a value form the enumeration at http://msdn.microsoft.com/en-us/library/aa363233.aspx
		mask - a value form the constants at http://msdn.microsoft.com/en-us/library/aa363230.aspx
	
	Returns:
		a new instance of the MMDeviceCollection class
	***************************************************************************************************************	
	*/
	EnumAudioEndpoints(dataFlow, mask)
	{
		this._Error(DllCall(NumGet(this.vt+03*A_PtrSize), "ptr", this.ptr, "uint", dataFlow, "uint", mask, "ptr*", devices))
		return new MMDeviceCollection(devices)
	}
	
	/**************************************************************************************************************
	Function: GetDefaultAudioEndpoint
	retrieves the default audio endpoint for the specified data-flow direction and role. 
	
	Parameters:
		dataFlow - a value form the enumeration at http://msdn.microsoft.com/en-us/library/aa363233.aspx
		role - a value form the enumeration at http://msdn.microsoft.com/en-us/library/aa363237.aspx
		
	Returns:
		a new instance of the MMDevice class
	
	***************************************************************************************************************	
	*/
	GetDefaultAudioEndpoint(dataFlow, role)
	{
		this._Error(DllCall(NumGet(this.vt+04*A_PtrSize), "ptr", this.ptr, "uint", dataFlow, "uint", role, "ptr*", device))
		return new MMDevice(device)
	}
	
	/**************************************************************************************************************
	Function: GetDevice
	retrieves an audio endpoint device that is identified by an endpoint ID string.
	
	Parameters:
		id - a string containing the endpoint ID. The caller typically obtains this string from the IMMDevice::GetId method or from one of the methods in the IMMNotificationClient interface.
		
	Returns:
		a new instance of the MMDevice class	
	***************************************************************************************************************	
	*/
	GetDevice(id)
	{
		this._Error(DllCall(NumGet(this.vt+05*A_PtrSize), "ptr", this.ptr, "str", id, "ptr*", device))
		return new MMDevice(device)
	}
	
	/**************************************************************************************************************
	Function: RegisterEndpointNotificationCallback
	
	Parameters:
		client - either a MMNotificationClient instance or a pointer to it
		
	Returns:
		bool success - true on success, false otherwise.
	***************************************************************************************************************	
	*/
	RegisterEndpointNotificationCallback(client)
	{
		return this._Error(DllCall(NumGet(this.vt+06*A_PtrSize), "ptr", this.ptr, "ptr", IsObject(client) ? client.ptr : client))
	}
	
	/**************************************************************************************************************
	Function: UnregisterEndpointNotificationCallback
	
	Parameters:
		client - either a MMNotificationClient instance or a pointer to it
		
	Returns:
		bool success - true on success, false otherwise.
	***************************************************************************************************************	
	*/
	UnregisterEndpointNotificationCallback(client)
	{
		return this._Error(DllCall(NumGet(this.vt+07*A_PtrSize), "ptr", this.ptr, "ptr", IsObject(client) ? client.ptr : client))
	}
}