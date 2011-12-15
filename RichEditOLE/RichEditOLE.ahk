/*
class: RichEditOLE
implements IRichEditOLE and exposes the COM functionality of a rich edit control.

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows 2000 Professional / Windows 2000 Server or higher
	Base classes - Unknown
	Helper classes - REO, REOBJECT

Remarks:
	- To create an instance of this class, call the (static) FromHWND() method.
*/
class RichEditOLE extends Unknown
{
	/*
	Field: IID
	This is IID_IRichEditOLE. It is required to create an instance.
	*/
	/*static IID := "{46EB5926-582E-4017-9FDF-E8998DAA0950}"
*/

	/*
	Field: ThrowOnCreation
	indicates that attempting to create an instance of this class without supplying a valid pointer should throw an exception.
	*/
	static ThrowOnCreation := true

	/*
	Method: FromHWND
	creates a new instance of the class from the given HWND of a RichEdit control.

	Parameters:
		HWND ctrl - the HWND to the RichEdit control

	Returns:
		RichEditOLE instance - the new instance
	*/
	FromHWND(ctrl)
	{
		result := DllCall("SendMessage", "uptr", ctrl, "uint", 0x400 + 60, "uint", 0, "ptr*", ptr)
		return new RichEditOLE(ptr)
	}

	/*
	Method: GetClientSite
	Retrieves an IOleClientSite interface to be used when creating a new object. All objects inserted into a rich edit control must use client site interfaces returned by this function. A client site may be used with exactly one object.

	Returns:
		UPTR client - the IOleClientSite pointer
	*/
	GetClientSite()
	{
		this._Error(DllCall(NumGet(this.vt+03*A_PtrSize), "ptr", this.ptr, "ptr*", client))
		return client
	}

	/*
	Method: GetObjectCount
	returns the number of objects currently contained in a rich edit control.

	Returns:
		INT count - the object count
	*/
	GetObjectCount()
	{
		this._Error(0)
		return DllCall(NumGet(this.vt+04*A_PtrSize), "ptr", this.ptr)
	}

	/*
	Method: GetLinkCount
	returns the number of objects in a rich edit control that are links.

	Returns:
		INT count - the number of objects in a rich edit control that are links
	*/
	GetLinkCount()
	{
		this._Error(0)
		return DllCall(NumGet(this.vt+05*A_PtrSize), "ptr", this.ptr)
	}

	/*
	Method: GetObject
	Retrieves information, stored in a REOBJECT structure, about an object in a rich edit control.

	Parameters:
		INT index - the object's zero-based index. If this parameter is REO.IOB_USE_CP, information about the object at the character position specified by the REOBJECT structure is returned.
		UINT flags - Operation flags that specify which interfaces to return in the structure. This can be a combination of the *interface information flags* in the REO enumeration class.

	Returns:
		REOBJECT object - the retrieved object
	*/
	GetObject(index, flags)
	{
		VarSetCapacity(obj,	44+3*A_PtrSize, 0)
		this._Error(DllCall(NumGet(this.vt+06*A_PtrSize), "ptr", this.ptr, "int", index, "ptr", &obj, "uint", flags))
		return REOBJECT.FromStructPtr(&obj)
	}

	/*
	Method: InsertObject

	Remarks:
		If the cp member of the REOBJECT structure is REO.CP_SELECTION, the selection is replaced with the specified object.
	*/
}