/*
class: ExpandCollapseState
an enumeration class containing values that specify the state of a UI element that can be expanded and collapsed.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/ExpandCollapseState)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ee671226)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows XP / Windows Server 2003 or higher
*/
class ExpandCollapseState
{
	/*
	Field: Collapsed
	No children are visible.
	*/
	static Collapsed := 0

	/*
	Field: Expanded
	All children are visible.
	*/
	static Expanded := 1

	/*
	Field: PartiallyExpanded
	Some, but not all, children are visible.
	*/
	static PartiallyExpanded := 2

	/*
	Field: LeafNode
	The element does not expand or collapse.
	*/
	static LeafNode := 3
}