/*
class: UIAutomation
wraps the *IUIAutomation* interface and enables client applications to discover, access, and filter UI Automation elements.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lgpl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/UIAutomation)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ee671406)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows 7, Windows Vista with SP2 and Platform Update for Windows Vista, Windows XP with SP3 and Platform Update for Windows Vista, Windows Server 2008 R2, Windows Server 2008 with SP2 and Platform Update for Windows Server 2008, Windows Server 2003 with SP2 and Platform Update for Windows Server 2008 or higher
	Base classes - _CCF_Error_Handler_, Unknown
	Other classes - (UIAutomationElement), (UIAutomationCacheRequest), (UIAutomationTreeWalker), UIAutomationCondition
*/
class UIAutomation extends Unknown
{
	/*
	Field: CLSID
	This is CLSID_CUIAutomation. It is required to create an instance.
	*/
	static CLSID := "{ff48dba4-60ef-4201-aa87-54103eef594e}"

	/*
	Field: IID
	This is IID_IUIAutomation. It is required to create an instance.
	*/
	static IID := "{30cbe57d-d9d0-452a-ab13-7ac5ac4825ee}"

	/*
	Group: meta-functions

	Method: __Get
	meta-function to implement dynamic properties.
	*/
	__Get(property)
	{
		if (property = "ControlViewWalker")
			return this.get_ControlViewWalker()
		else if (property = "ContentViewWalker")
			return this.get_ContentViewWalker()
		else if (property = "RawViewWalker")
			return this.get_RawViewWalker()
		else if (property = "RawViewCondition")
			return this.get_RawViewCondition()
		else if (property = "ContentViewCondition")
			return this.get_ContentViewCondition()
		else if (property = "ControlViewCondition")
			return this.get_ControlViewCondition()
	}

	/*
	Group: IUIAutomation methods

	Method: CompareElements
	Compares two UI Automation element to determine whether they represent the same underlying UI element.

	Parameters:
		AutomationElement elem1 - the first element, either as class instance or raw interface pointer
		AutomationElement elem2 - the second element, either as class instance or raw interface pointer

	Returns:
		BOOL same - TRUE if the run-time identifiers of the elements are the same, or FALSE otherwise.
	*/
	CompareElements(elem1, elem2)
	{
		local same
		this._Error(DllCall(NumGet(this.vt, 03*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr", IsObject(elem1) ? elem1.ptr : elem1, "Ptr", IsObject(elem2) ? elem2.ptr : elem2, "Int*", same, "Int"))
		return same
	}

	/*
	Method: CompareRuntimeIds
	Compares two integer arrays containing run-time identifiers (IDs) to determine whether their content is the same and they belong to the same UI element.

	Parameters:
		SAFEARRAY arr1 - the first (COM safe) array
		SAFEARRAY arr2 - the second (COM safe) array

	Returns:
		BOOL same - TRUE if the IDs are the same, or FALSE otherwise

	Remarks:
		For the arrays, you can either pass an AHK COM safe array (created using ComObjArray()) or a raw pointer to a SAFEARRAY structure in memory
	*/
	CompareRuntimeIds(arr1, arr2)
	{
		local same
		this._Error(DllCall(NumGet(this.vt, 04*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr", IsObject(arr1) ? ComObjValue(arr1) : arr1, "Ptr", IsObject(arr2) ? ComObjValue(arr2) : arr2, "Int*", same, "Int"))
		return same
	}

	/*
	Method: GetRootElement
	Retrieves the UI Automation element that represents the desktop.

	Returns:
		UIAutomationElement desktop - the root element, either as class instance (if available) or as raw interface pointer
	*/
	GetRootElement()
	{
		local desktop
		this._Error(DllCall(NumGet(this.vt, 05*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr*", desktop, "Int"))
		return IsObject(UIAutomationElement) ? new UIAutomationElement(desktop) : desktop
	}

	/*
	Method: ElementFromHandle
	Retrieves a UI Automation element for the specified window handle.

	Parameters:
		HWND handle - The window handle

	Returns:
		UIAutomationElement elem - the retrieved element, either as class instance (if available) or as raw interface pointer
	*/
	ElementFromHandle(handle)
	{
		local elem
		this._Error(DllCall(NumGet(this.vt, 06*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr", handle, "Ptr*", elem, "Int"))
		return IsObject(UIAutomationElement) ? new UIAutomationElement(elem) : elem
	}

	/*
	Method: ElementFromPoint
	Retrieves the UI Automation element at the specified point on the desktop.

	Parameters:
		POINT pt - The desktop coordinates of the UI Automation element. This can either be a POINT class instance or a raw pointer.

	Returns:
		UIAutomationElement elem - the retrieved element, either as class instance (if available) or as raw interface pointer
	*/
	ElementFromPoint(pt)
	{
		local elem
		this._Error(DllCall(NumGet(this.vt, 07*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr", IsObject(pt) ? pt.ToStructPtr() : ptr, "Ptr*", elem, "Int"))
		return IsObject(UIAutomationElement) ? new UIAutomationElement(elem) : elem
	}

	/*
	Method: GetFocusedElement
	Retrieves the UI Automation element that has the input focus.

	Returns:
		UIAutomationElement elem - the retrieved element, either as class instance (if available) or as raw interface pointer
	*/
	GetFocusedElement()
	{
		local elem
		this._Error(DllCall(NumGet(this.vt, 08*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr*", elem, "Int"))
		return IsObject(UIAutomationElement) ? new UIAutomationElement(elem) : elem
	}

	/*
	Method: GetRootElementBuildCache
	Retrieves the UI Automation element that represents the desktop, prefetches the requested properties and control patterns, and stores the prefetched items in the cache.

	Parameters:
		UIAutomationCacheRequest req - the cache request, which specifies the properties and control patterns to store in the cache. This can be passed either as class instance or raw interface pointer.

	Returns:
		UIAutomationElement elem - the retrieved element, either as class instance (if available) or as raw interface pointer
	*/
	GetRootElementBuildCache(req)
	{
		local elem
		this._Error(DllCall(NumGet(this.vt, 09*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr", IsObject(req) ? req.ptr : req, "Ptr*", elem, "Int"))
		return IsObject(UIAutomationElement) ? new UIAutomationElement(elem) : elem
	}

	/*
	Method: ElementFromHandleBuildCache
	Retrieves a UI Automation element for the specified window, prefetches the requested properties and control patterns, and stores the prefetched items in the cache.

	Parameters:
		HWND handle - The window handle
		UIAutomationCacheRequest req - the cache request, which specifies the properties and control patterns to store in the cache. This can be passed either as class instance or raw interface pointer.

	Returns:
		UIAutomationElement elem - the retrieved element, either as class instance (if available) or as raw interface pointer
	*/
	ElementFromHandleBuildCache(handle, req)
	{
		local elem
		this._Error(DllCall(NumGet(this.vt, 10*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr", handle, "Ptr", IsObject(req) ? req.ptr : req, "Ptr*", elem, "Int"))
		return IsObject(UIAutomationElement) ? new UIAutomationElement(elem) : elem
	}

	/*
	Method: ElementFromPointBuildCache
	Retrieves the UI Automation element at the specified point on the desktop, prefetches the requested properties and control patterns, and stores the prefetched items in the cache.

	Parameters:
		POINT pt - The desktop coordinates of the UI Automation element. This can either be a POINT class instance or a raw pointer.
		UIAutomationCacheRequest req - the cache request, which specifies the properties and control patterns to store in the cache. This can be passed either as class instance or raw interface pointer.

	Returns:
		UIAutomationElement elem - the retrieved element, either as class instance (if available) or as raw interface pointer
	*/
	ElementFromPointBuildCache(pt, req)
	{
		local elem
		this._Error(DllCall(NumGet(this.vt, 11*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr", IsObject(pt) ? pt.ToStructPtr() : pt, "Ptr", IsObject(req) ? req.ptr : req, "Ptr*", elem, "Int"))
		return IsObject(UIAutomationElement) ? new UIAutomationElement(elem) : elem
	}

	/*
	Method: GetFocusedElementBuildCache
	Retrieves the UI Automation element that has the input focus, prefetches the requested properties and control patterns, and stores the prefetched items in the cache.

	Parameters:
		UIAutomationCacheRequest req - the cache request, which specifies the properties and control patterns to store in the cache. This can be passed either as class instance or raw interface pointer.

	Returns:
		UIAutomationElement elem - the retrieved element, either as class instance (if available) or as raw interface pointer
	*/
	GetFocusedElementBuildCache(req)
	{
		local elem
		this._Error(DllCall(NumGet(this.vt, 12*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr", IsObject(req) ? req.ptr : req, "Ptr*", elem, "Int"))
		return IsObject(UIAutomationElement) ? new UIAutomationElement(elem) : elem
	}

	/*
	Method: CreateTreeWalker
	Retrieves a tree walker object that can be used to traverse the UI Automation tree.

	Parameters:
		UIAutomationCondition cond - A pointer to a condition that specifies the elements of interest. This can either be a class instance (of a class derived from UIAutomationCondition) or a raw interface pointer.

	Returns:
		UIAutomationTreeWalker walker - the walker object, either as class instance (if available) or as raw interface pointer
	*/
	CreateTreeWalker(cond)
	{
		local walker
		this._Error(DllCall(NumGet(this.vt, 13*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr", IsObject(cond) ? cond.ptr : cond, "Ptr*", walker, "Int"))
		return IsObject(UIAutomationTreeWalker) ? new UIAutomationTreeWalker(walker) : walker
	}

	/*
	Method: get_ControlViewWalker
	Retrieves an IUIAutomationTreeWalker interface used to discover control elements.

	Returns:
		UIAutomationTreeWalker walker - the walker object, either as class instance (if available) or as raw interface pointer
	*/
	get_ControlViewWalker()
	{
		local walker
		this._Error(DllCall(NumGet(this.vt, 14*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr*", walker, "Int"))
		return IsObject(UIAutomationTreeWalker) ? new UIAutomationTreeWalker(walker) : walker
	}

	/*
	Method: get_ContentViewWalker
	Retrieves an IUIAutomationTreeWalker interface used to discover content elements.

	Returns:
		UIAutomationTreeWalker walker - the walker object, either as class instance (if available) or as raw interface pointer
	*/
	get_ContentViewWalker()
	{
		local walker
		this._Error(DllCall(NumGet(this.vt, 15*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr*", walker, "Int"))
		return IsObject(UIAutomationTreeWalker) ? new UIAutomationTreeWalker(walker) : walker
	}

	/*
	Method: get_RawViewWalker
	Retrieves a tree walker object used to traverse an unfiltered view of the Microsoft UI Automation tree.

	Returns:
		UIAutomationTreeWalker walker - the walker object, either as class instance (if available) or as raw interface pointer
	*/
	get_RawViewWalker()
	{
		local walker
		this._Error(DllCall(NumGet(this.vt, 16*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr*", walker, "Int"))
		return IsObject(UIAutomationTreeWalker) ? new UIAutomationTreeWalker(walker) : walker
	}

	/*
	Method: get_RawViewCondition
	Retrieves a predefined IUIAutomationCondition interface that selects all UI elements in an unfiltered view.

	Returns:
		UIAutomationCondition cond - the condition object, either as (UIAutomationCondition) class instance or as raw interface pointer
	*/
	get_RawViewCondition()
	{
		local cond
		this._Error(DllCall(NumGet(this.vt, 17*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr*", cond, "Int"))
		return IsObject(UIAutomationCondition) ? new UIAutomationCondition(cond) : cond
	}

	/*
	Method: get_ControlViewCondition
	Retrieves a predefined IUIAutomationCondition interface that selects control elements.

	Returns:
		UIAutomationCondition cond - the condition object, either as (UIAutomationCondition) class instance or as raw interface pointer
	*/
	get_ControlViewCondition()
	{
		local cond
		this._Error(DllCall(NumGet(this.vt, 18*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr*", cond, "Int"))
		return IsObject(UIAutomationCondition) ? new UIAutomationCondition(cond) : cond
	}

	/*
	Method: get_ContentViewCondition
	Retrieves a predefined IUIAutomationCondition interface that selects content elements.

	Returns:
		UIAutomationCondition cond - the condition object, either as (UIAutomationCondition) class instance or as raw interface pointer
	*/
	get_ContentViewCondition()
	{
		local cond
		this._Error(DllCall(NumGet(this.vt, 19*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr*", cond, "Int"))
		return IsObject(UIAutomationCondition) ? new UIAutomationCondition(cond) : cond
	}

	/*
	Method: CreateCacheRequest
	Creates a cache request.

	Returns:
		UIAutomationCacheRequest req - the newly created cache request object, either as class instance (if available) or raw interface pointer
	*/
	CreateCacheRequest()
	{
		local req
		this._Error(DllCall(NumGet(this.vt, 20*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr*", req, "Int"))
		return IsObject(UIAutomationCacheRequest) ? new UIAutomationCacheRequest(req) : req
	}

	/*
	Method: CreateTrueCondition
	Retrieves a predefined condition that selects all elements.

	Returns;
		UIAutomationCondition cond - the condition object, either as (UIAutomationCondition) class instance (if available) or raw interface pointer
	*/
	CreateTrueCondition()
	{
		local cond
		this._Error(DllCall(NumGet(this.vt, 21*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr*", cond, "Int"))
		return IsObject(UIAutomationCondition) ? new UIAutomationCondition(cond) : cond
	}

	/*
	Method: CreateFalseCondition
	Creates a condition that is always false.

	Returns:
		UIAutomationCondition cond - the condition object, either as (UIAutomationCondition) class instance (if available) or raw interface pointer
	*/
	CreateFalseCondition()
	{
		local cond
		this._Error(DllCall(NumGet(this.vt, 22*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr*", cond, "Int"))
		return IsObject(UIAutomationCondition) ? new UIAutomationCondition(cond) : cond
	}

	/*
	Group: dynamic properties

	Field: ControlViewWalker
	an IUIAutomationTreeWalker interface used to discover control elements

	Access: read-only

	corresponding methods: <get_ControlViewWalker>
	*/

	/*
	Field: ContentViewWalker
	an IUIAutomationTreeWalker interface used to discover content elements

	Access: read-only

	corresponding methods: <get_ContentViewWalker>
	*/

	/*
	Field: RawViewWalker
	a tree walker object used to traverse an unfiltered view of the Microsoft UI Automation tree

	Access: read-only

	corresponding methods: <get_RawViewWalker>
	*/

	/*
	Field: RawViewCondition
	a predefined IUIAutomationCondition interface that selects all UI elements in an unfiltered view.

	Access: read-only

	corresponding methods: <get_RawViewCondition>
	*/

	/*
	Field: ControlViewCondition
	a predefined IUIAutomationCondition interface that selects control elements.

	Access: read-only

	corresponding methods: <get_ControlViewCondition>
	*/

	/*
	Field: ContentViewCondition
	a predefined IUIAutomationCondition interface that selects content elements.

	Access: read-only

	corresponding methods: <get_ContentViewCondition>
	*/
}