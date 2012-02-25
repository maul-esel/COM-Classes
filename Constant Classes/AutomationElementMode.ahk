/*
class: AutomationElementMode
an enumeration class containing values that specify the type of reference to use when returning UI Automation elements.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/AutomationElementMode)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ee684015)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows XP / Windows Server 2003 or higher
*/
class AutomationElementMode
{
	/*
	Field: None
	Specifies that returned elements have no reference to the underlying UI and contain only cached information.
	*/
	static None := 0

	/*
	Field: Full
	Specifies that returned elements have a full reference to the underlying UI.
	*/
	static Full := 1
}