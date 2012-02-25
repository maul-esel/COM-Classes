/*
class: AsyncContentLoadedState
an enumeration class containing values that describe the progress of asynchronous loading of content.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/AsyncContentLoadedState)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ee684014)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows XP / Windows Server 2003 or higher
*/
class AsyncContentLoadedState
{
	/*
	Field: Beginning
	Loading of the content into the UI Automation element is beginning.
	*/
	static Beginning := 0

	/*
	Field: Progress
	Loading of the content into the UI Automation element is in progress.
	*/
	static Progress := 1

	/*
	Field: Completed
	Loading of the content into the UI Automation element is complete.
	*/
	static Completed := 2
}