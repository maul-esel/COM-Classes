/*
class: HorizontalTextAlignment
an enumeration class containing values for the HorizontalTextAlignment text attribute.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/HorizontalTextAlignment)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ee671233)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows XP / Windows Server 2003 or higher
*/
class HorizontalTextAlignment
{
	/*
	Field: Left
	Left alignment.
	*/
	static Left := 0

	/*
	Field: Centered
	Centered alignment.
	*/
	static Centered := 1

	/*
	Field: Right
	Right alignment.
	*/
	static Right := 2

	/*
	Field: Justified
	Justified alignment.
	*/
	static Justified := 3
}