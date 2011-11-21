/**************************************************************************************************************
class: TaskbarList4
extends TaskbarList3

Requirements:
	- This requires AHK v2 alpha
	- It also requires Windows 7, Windows Server 2008 R2 or higher
***************************************************************************************************************	
*/

class TaskbarList4 extends TaskbarList3
{
	/**************************************************************************************************************
	Variable: CLSID
	This is CLSID_TaskbarList. It is required to create the object.
	***************************************************************************************************************	
	*/
	static CLSID := "{56FDF344-FD6D-11d0-958A-006097C9A090}"
		
	/**************************************************************************************************************
	Variable: IID
	This is IID_ITaskbarList4. It is required to create the object.
	***************************************************************************************************************	
	*/
	static IID := "{c43dc798-95d1-4bea-9030-bb99e2983a1a}"
		
	/**************************************************************************************************************
	Function: SetTabProperties
	Allows a tab to specify whether the main application frame window or the tab window
	should be used as a thumbnail or in the peek feature.

	Parameters:
		handle hTab - the handle of the tab to work on.
		uint properties - the properties to set. You may use the fields of the STPFLAG class for convenience.

	Returns:
		bool success - true on success, false otherwise.
		
	Example:
>		ITBL4.SetTabProperties(WinExist(), STPFLAG.USEAPPTHUMBNAILALWAYS|STPFLAG.USEAPPPEEKALWAYS)

	Remarks:
		Read the flag documentation carefully to avoid flag combinations that cause errors.
	***************************************************************************************************************	
	*/
	SetTabProperties(hTab, properties)
	{
		return this._Error(DllCall(NumGet(this.vt+21*A_PtrSize), "Ptr", this.ptr, "UInt", hTab, "UInt", properties))
	}
}