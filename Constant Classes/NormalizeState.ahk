/*
class: NormalizeState
an enumeration class containing values that specify the behavior of UiaGetUpdatedCache.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/NormalizeState)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ee671589)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows XP / Windows Server 2003 or higher
*/
class NormalizeState
{
	/*
	Field: None
	No normalization.
	*/
	static None := 0

	/*
	Field: View
	Normalize against the condition in the cache request specified by pRequest.
	*/
	static View := 1

	/*
	Field: Custom
	Normalize against the condition specified in pNormalizeCondition.
	*/
	static Custom := 2
}