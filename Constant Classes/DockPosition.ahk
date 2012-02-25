/*
class: DockPosition
an enumeration class containing values that specify the location of a docking window represented by the Dock control pattern.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/DockPosition)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ee671206)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows XP / Windows Server 2003 or higher
*/
class DockPosition
{
	/*
	Field: Top
	The window is docked at the top.
	*/
	static Top := 0

	/*
	Field: Left
	The window is docked at the left.
	*/
	static Left := 1

	/*
	Field: Bottom
	The window is docked at the bottom.
	*/
	static Bottom := 2

	/*
	Field: Right
	The window is docked at the right.
	*/
	static Right := 3

	/*
	Field: Fill
	The window is docked on all four sides.
	*/
	static Fill := 4

	/*
	Field: None
	The window is not docked.
	*/
	static None := 5
}