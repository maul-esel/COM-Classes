/*
class: UIAutomationCondition
implements IUIAutomationCondition and serves as an abstract base class for other condition types.

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows 7, Windows Vista with SP2 and Platform Update for Windows Vista, Windows XP with SP3 and Platform Update for Windows Vista, Windows Server 2008 R2, Windows Server 2008 with SP2 and Platform Update for Windows Server 2008, Windows Server 2003 with SP2 and Platform Update for Windows Server 2008
	Base classes - Unknown
	Helper classes - (none)
*/
class UIAutomationCondition extends Unknown
{
	/*
	Field: IID
	This is IID_IUIAutomationCondition. It is required to create an instance.
	*/
	static IID := "{352ffba8-0973-437c-a61f-f64cafd81df9}"

	/*
	Field: ThrowOnCreation
	ndicates that attempting to create an instance of this class without supplying a valid pointer should throw an exception.
	*/
	static ThrowOnCreation := true
}