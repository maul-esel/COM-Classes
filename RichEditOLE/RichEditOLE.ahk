/*
class: RichEditOLE
wraps the *IRichEditOLE* interface and exposes the COM functionality of a rich edit control.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lgpl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/AHK_Lv1.1/RichEditOLE)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/bb774306)

Requirements:
	AutoHotkey - AHK_L v1.1+
	OS - Windows 2000 Professional / Windows 2000 Server or higher
	Base classes - _CCF_Error_Handler_, Unknown
	Helper classes - REO, REOBJECT, DVASPECT

Remarks:
	- To create an instance of this class, call the (static) FromHWND() method.
*/
class RichEditOLE extends Unknown
{
	/*
	Field: IID
	This is IID_IRichEditOLE. It is required to create an instance.
	*/
	static IID := "{00020D00-0000-0000-C000-000000000046}"

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
		VarSetCapacity(obj,	REOBJECT.GetRequiredSize(), 0)
		this._Error(DllCall(NumGet(this.vt+06*A_PtrSize), "ptr", this.ptr, "int", index, "ptr", &obj, "uint", flags))
		return REOBJECT.FromStructPtr(&obj)
	}

	/*
	Method: InsertObject
	inserts an object into a rich edit control.

	Parameters:
		REOBJECT obj - the object to isert, either as raw memory pointer or as REOBJECT class instance.

	Returns:
		BOOL success - true on success, false otherwise

	Remarks:
		If the cp member of the REOBJECT structure is REO.CP_SELECTION, the selection is replaced with the specified object.
	*/
	InsertObject(obj)
	{
		return this._Error(DllCall(NumGet(this.vt+07*A_PtrSize), "ptr", this.ptr, "ptr", IsObject(obj) ? obj.ToStructPtr() : obj))
	}

	/*
	Method: ConvertObject
	converts an object to a new type. This call reloads the object but does not force an update; the caller must do this.

	Parameters:
		INT index - Index of the object to convert. If this parameter is REO.IOB_SELECTION, the selected object is to be converted.
		STR clsid - Class identifier of the class to which the object is converted *(as a CLSID string)*.
		STR type - User-visible type name of the class to which the object is converted.

	Returns:
		BOOL success - true on success, false otherwise
	*/
	ConvertObject(index, clsid, type)
	{
		return this._Error(DllCall(NumGet(this.vt+08*A_PtrSize), "ptr", this.ptr, "int", index, "ptr", this._GUID(clsid), "str", type))
	}

	/*
	Method: ActivateAs
	handles Activate As behavior by unloading all objects of the old class, telling OLE to treat those objects as objects of the new class, and reloading the objects. If objects cannot be reloaded, they are deleted.

	Parameters:
		STR old - Class identifier of the old class *(as a CLSID string)*.
		STR new - Class identifier of the new class *(as a CLSID string)*.

	Returns:
		BOOL success - true on success, false otherwise
	*/
	ActivateAs(old, new)
	{
		return this._Error(DllCall(NumGet(this.vt+09*A_PtrSize), "ptr", this.ptr, "ptr", this._GUID(old), "ptr", this._GUID(new)))
	}

	/*
	Method: SetHostNames
	sets the host names to be given to objects as they are inserted to a rich edit control. The host names are used in the user interface of servers to describe the container context of opened objects.

	Parameters:
		STR app - name of the container application.
		STR obj - name of the container document or object.

	Returns:
		BOOL success - true on success, false otherwise
	*/
	SetHostNames(app, obj)
	{
		return this._Error(DllCall(NumGet(this.vt+10*A_PtrSize), "ptr", this.ptr, "str", app, "str", obj))
	}

	/*
	Method: SetLinkAvailable
	sets the value of the link-available bit in the object's flags. The link-available bit defaults to TRUE. It should be set to FALSE if any errors occur on the link which would indicate problems connecting to the linked object or application. When those problems are repaired, the bit should be set to TRUE again.

	Parameters:
		INT index - Index of object whose bit is to be set. If this parameter is REO.IOB_SELECTION, the bit on the selected object is to be set.
		BOOL value - Value used in the set operation. The value can be TRUE or FALSE.

	Returns:
		BOOL success - true on success, false otherwise
	*/
	SetLinkAvailable(index, value)
	{
		return this._Error(DllCall(NumGet(this.vt+11*A_PtrSize), "ptr", this.ptr, "int", index, "uint", value))
	}

	/*
	Method: SetDvaspect
	sets the aspect that a rich edit control uses to draw an object. This call does not change the drawing information cached in the object; this must be done by the caller. The call does cause the object to be redrawn.

	Parameters:
		INT index - Index of the object whose aspect is to be set. If this parameter is REO.IOB_SELECTION, the aspect of the selected object is to be set.
		UINT aspect - Aspect to use when drawing. You may use the fields of the DVASPECT class for convenience.

	Returns:
		BOOL success - true on success, false otherwise
	*/
	SetDvaspect(index, aspect)
	{
		return this._Error(DllCall(NumGet(this.vt+12*A_PtrSize), "ptr", this.ptr, "int", index, "uint", aspect))
	}

	/*
	Method: HandsOffStorage
	tells a rich edit control to release its reference to the storage interface associated with the specified object. This call does not call the object's IRichEditOle::HandsOffStorage method; the caller must do that.

	Parameters:
		INT index - the index of the object whose storage is to be released. If this parameter is REO.IOB_SELECTION, the storage of the selected object is to be released.

	Returns:
		BOOL success - true on success, false otherwise
	*/
	HandsOffStorage(index)
	{
		return this._Error(DllCall(NumGet(this.vt+13*A_PtrSize), "ptr", this.ptr, "int", index))
	}
}