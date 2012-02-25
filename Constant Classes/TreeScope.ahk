/*
class: TreeScope
an enumeration class containing values that specify the scope of various operations in the Microsoft UI Automation tree.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/TreeScope)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ee671699)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows XP / Windows Server 2003 or higher
*/
class TreeScope
{
	/*
	Field: Element
	The scope includes the element itself.
	*/
	static Element := 0x1

	/*
	Field: Children
	The scope includes children of the element.
	*/
	static Children := 0x2

	/*
	Field: Descendants
	The scope includes children and more distant descendants of the element.
	*/
	static Descendants := 0x4

	/*
	Field: Parent
	The scope includes the parent of the element.
	*/
	static Parent := 0x8

	/*
	Field: Ancestors
	The scope includes the parent and more distant ancestors of the element.
	*/
	static Ancestors := 0x10

	/*
	Field: Subtree
	The scope includes the element and all its descendants. This flag is a combination of the <Element>, <Children> and <Descendants> values.
	*/
	static Subtree := (TreeScope.Element | TreeScope.Children) | TreeScope.Descendants
}