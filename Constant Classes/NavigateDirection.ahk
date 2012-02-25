/*
class: NavigateDirection
an enumeration class containing values used to specify the direction of navigation within the Microsoft UI Automation tree.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/NavigateDirection)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ee671588)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows XP / Windows Server 2003 or higher
*/
class NavigateDirection
{
	/*
	Field: Parent
	The navigation direction is to the parent.
	*/
	static Parent := 0

	/*
	Field: NextSibling
	The navigation direction is to the next sibling.
	*/
	static NextSibling := 1

	/*
	Field: PreviousSibling
	The navigation direction is to the previous sibling.
	*/
	static PreviousSibling := 2

	/*
	Field: FirstChild
	The navigation direction is to the first child.
	*/
	static FirstChild := 3

	/*
	Field: LastChild
	The navigation direction is to the last child.
	*/
	static LastChild := 4
}