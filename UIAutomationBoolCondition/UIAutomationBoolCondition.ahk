/*
class: UIAutomationBoolCondition
implements IUIAutomationBoolCondition and represents a condition that can be either TRUE (selects all elements) or FALSE (selects no elements).

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows 7, Windows Vista with SP2 and Platform Update for Windows Vista, Windows XP with SP3 and Platform Update for Windows Vista, Windows Server 2008 R2, Windows Server 2008 with SP2 and Platform Update for Windows Server 2008, Windows Server 2003 with SP2 and Platform Update for Windows Server 2008
	Base classes - Unknown, UIAutomationCondition
	Helper classes - (none)
*/
class UIAutomationBoolCondition extends UIAutomationCondition
{
	/*
	Field: IID
	This is IID_IUIAutomationBoolCondition. It is required to create an instance.
	*/
	static IID := "{1b4e1f2e-75eb-4d0b-8952-5a69988e2307}"

	/*
	Field: ThrowOnCreation
	ndicates that attempting to create an instance of this class without supplying a valid pointer should throw an exception.
	*/
	static ThrowOnCreation := true

	/*
	Method: get_BooleanValue
	Retrieves the value of the condition: either TRUE or FALSE.

	Returns:
		BOOL value - the condition's value
	*/
	get_BooleanValue()
	{
		this._Error(DllCall(NumGet(this.vt+03*A_PtrSize), "ptr", this.ptr, "uint*", value))
		return value
	}

	/*
	group: meta-functions

	Method: __Get
	meta-function for reading pseudo-properties
	*/
	__Get(property)
	{
		if (property = "BooleanValue")
			return this.get_BooleanValue()
	}

	/*
	group: dynamic properties

	========================================================================================================
	Field: BooleanValue
	Retrieves the value of the condition: either TRUE or FALSE.

	Access: read-only

	corresponding methods: <get_BooleanValue>
	*/
}