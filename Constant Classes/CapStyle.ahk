/*
class: CapStyle
an enumeration class containing values that specify the value of the CapStyle text attribute.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/CapStyle)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ee684020)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows XP / Windows Server 2003 or higher
*/
class CapStyle
{
	/*
	Field: None
	None.
	*/
	static None := 0

	/*
	Field: SmallCap
	Small capitals.
	*/
	static SmallCap := 1

	/*
	Field: AllCap
	All capitals.
	*/
	static AllCap := 2

	/*
	Field: AllPetiteCaps
	All petite capitals.
	*/
	static AllPetiteCaps := 3

	/*
	Field: PetiteCaps
	Petite capitals.
	*/
	static PetiteCaps := 4

	/*
	Field: Unicase
	Single case.
	*/
	static Unicase := 5

	/*
	Field: Titling
	Title case.
	*/
	static Titling := 6

	/*
	Field: Other
	Other.
	*/
	static Other := -1
}