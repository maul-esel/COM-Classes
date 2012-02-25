/*
class: EventArgsType
an enumeration class containing values that specify the event type described by a UiaEventArgs structure.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/EventArgsType)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ee671219)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows XP / Windows Server 2003 or higher
*/
class EventArgsType
{
	/*
	Field: Simple
	A simple event that does not provide data in the event arguments.
	*/
	static Simple := 0

	/*
	Field: PropertyChanged
	An event raised by a property change.
	*/
	static PropertyChanged := 1

	/*
	Field: StructureChanged
	An event raised by a change in the UI Automation tree structure.
	*/
	static StructureChanged := 2

	/*
	Field: AsyncContentLoaded
	An event raised during asynchronous loading of content by an element.
	*/
	static AsyncContentLoaded := 3

	/*
	Field: WindowClosed
	An event raised when a window is closed.
	*/
	static WindowClosed := 4
}