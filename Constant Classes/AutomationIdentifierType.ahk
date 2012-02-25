/*
class: AutomationIdentifierType
an enumeration class containing values used in the UiaLookupId function.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/AutomationIdentifierType)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ee684016)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows XP / Windows Server 2003 or higher
*/
class AutomationIdentifierType
{
	/*
	Field: Property
	Specifies a property ID.
	*/
	static Property := 0

	/*
	Field: Pattern
	Specifies a control pattern ID.
	*/
	static Pattern := 1

	/*
	Field: Event
	Specifies an event ID.
	*/
	static Event := 2

	/*
	Field: ControlType
	Specifies a control type ID.
	*/
	static ControlType := 3

	/*
	Field: TextAttribute
	Specifies a text attribute ID.
	*/
	static TextAttribute := 4
}