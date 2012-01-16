/*
class: DESCKIND
an enumeration class that identifies the type description being bound to.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/AHK_Lv1.1/DESCKIND)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ms221506%28v=VS.85%29.aspx)

Requirements:
	AutoHotkey - AHK_L v1.1+
	OS - (unknown)
*/
class DESCKIND
{
	/*
	Field: NONE
	No match was found.
	*/
	static NONE := 0

	/*
	Field: FUNCDESC
	A FUNCDESC was returned.
	*/
	static FUNCDESC := 1

	/*
	Field: VARDESC
	A VARDESC was returned.
	*/
	static VARDESC := 2

	/*
	Field: TYPECOMP
	A TYPECOMP was returned.
	*/
	static TYPECOMP := 3

	/*
	Field: IMPLICITAPPOBJ
	An IMPLICITAPPOBJ was returned.
	*/
	static IMPLICITAPPOBJ := 4

	/*
	Field: MAX
	The end of the enum.
	*/
	static MAX := 5
}