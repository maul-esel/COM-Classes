/*
class: ConditionType
an enumeration class containing values that specify a type of a UiaCondition structure.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/ConditionType)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ee671192)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows XP / Windows Server 2003 or higher
*/
class ConditionType
{
	/*
	Field: True
	A condition that is true.
	*/
	static True := 0

	/*
	Field: False
	A condition that is false.
	*/
	static False := 1

	/*
	Field: Property
	A property condition.
	*/
	static Property := 2

	/*
	Field: And
	A complex condition where all the contained conditions must be true.
	*/
	static And := 3

	/*
	Field: Or
	A complex condition where at least one of the contained conditions must be true.
	*/
	static Or := 4

	/*
	Field: Not
	A condition that is true if the specified conditions are not met.
	*/
	static Not := 5
}