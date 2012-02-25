/*
class: FlowDirections
an enumeration class containing values for the TextFlowDirections text attribute.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/FlowDirections)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ee671227)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows XP / Windows Server 2003 or higher
*/
class FlowDirections
{
	/*
	Field: Default
	The default flow direction.
	*/
	static Default := 0

	/*
	Field: RightToLeft
	The text flows from right to left.
	*/
	static RightToLeft := 1

	/*
	Field: BottomToTop
	The text flows from bottom to top.
	*/
	static BottomToTop := 2

	/*
	Field: Vertical
	The text flows vertically.
	*/
	static Vertical := 4
}