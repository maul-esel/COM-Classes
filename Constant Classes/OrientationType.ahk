/*
class: OrientationType
an enumeration class containing values that specify the orientation of a control.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/OrientationType)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ee671591)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows XP / Windows Server 2003 or higher
*/
class OrientationType
{
	/*
	Field: None
	The control has no orientation.
	*/
	static None := 0

	/*
	Field: Horizontal
	The control has horizontal orientation.
	*/
	static Horizontal := 1

	/*
	Field: Vertical
	The control has vertical orientation.
	*/
	static Vertical := 2
}