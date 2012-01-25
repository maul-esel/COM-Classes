/*
HEADER: CCF.ahk
This file is the main file for the framework. It includes all the other files and has some more nice additions. However, it's not strictly required to include it. You might also only include the files you need.

Remarks:
	If you include this, make sure to set the #Include working directory properly before:
	(start code)
	#include %A_ScriptDir%\CCF ; set working dir for #includes
	#include CCF.ahk ; include this file
	(end code)
*/

/*
class: _CCF_Error_Handler_
the base class that includes error handling
*/
#include _CCF_Error_Handler_\_CCF_Error_Handler_.ahk

/*
class: CCFramework
the main class
*/
#include CCFramework.ahk

/*
class: Unknown
the base class for all other CCF interface classes
*/
#include Unknown\Unknown.ahk

/*
class: CustomDestinationList
a class for managing custom jump lists in Windows7
*/
#include CustomDestinationList\CustomDestinationList.ahk

/*
group: Images
*/
/*
class: ImageList
a class for managing image lists
*/
#include ImageList\ImageList.ahk

/*
class: ImageList2
provides more methods for image lists
*/
#include ImageList2\ImageList2.ahk

/*
class: Picture
a class for managing a picture
*/
#include Picture\Picture.ahk

/*
group: Audio
*/
/*
class: MMDeviceEnumerator
a class for enumerating devices
*/
#include MMDeviceEnumerator\MMDeviceEnumerator.ahk

/*
group: collections
*/
/*
class: ObjectArray
represents an extensible array of IUnknown-derived instances
*/
#include ObjectArray\ObjectArray.ahk

/*
class: ObjectCollection
provides more methods for IUnknown-derived instance arrays
*/
#include ObjectCollection\ObjectCollection.ahk

/*
class: EnumShellItems
enumerates a collection of IShellItems
*/
#include EnumShellItems\EnumShellItems.ahk

/*
group: progress dialogs
*/
/*
class: OperationsProgressDialog
a class for displaying standard system progress dialogs (copy, move, upload, ...)
*/
#include OperationsProgressDialog\OperationsProgressDialog.ahk

/*
class: ProgressDialog
a class for displaying a customized progress dialog
*/
#include ProgressDialog\ProgressDialog.ahk

/*
group: persistent storage
*/
/*
class: Persist
a base class for classes that provide the CLSID of an object that can be stored persistently in the system
*/
#include Persist\Persist.ahk

/*
class: PersistFile
represents a file to be stored on disk
*/
#include PersistFile\PersistFile.ahk

/*
group: property system
*/
/*
class: PropertyStore
manages property values
*/
#include PropertyStore\PropertyStore.ahk

/*
class: PropertyStoreCache
manages property values and states
*/
#include PropertyStoreCache\PropertyStoreCache.ahk

/*
group: streams
*/
/*
class: SequentialStream
base class for stream classes
*/
#include SequentialStream\SequentialStream.ahk

/*
class: Stream
a class for managing a stream
*/
#include Stream\Stream.ahk

/*
group: RichEdit management
*/
/*
class: RichEditOLE
class for managing a RichEdit control
*/
#include RichEditOLE\RichEditOLE.ahk

/*
group: shell
*/
/*
class: ShellItem
represents an "Shell item", such as a file
*/
#include ShellItem\ShellItem.ahk

/*
class: ShellLinkW
manages shell links (*.lnk files) (Unicode version)
*/
#include ShellLinkW\ShellLinkW.ahk

/*
typedef: ShellLink
defines "ShellLink" as the encoding-specific version

Remarks:
	- In v2, this is always ShellLinkW
*/
global ShellLink := ShellLinkW

/*
group: Taskbar
*/
/*
class: TaskbarList
manages some taskbar properties
*/
#include TaskbarList\TaskbarList.ahk

/*
class: TaskbarList2
provides a method for marking a window as full-screen for the shell
*/
#include TaskbarList2\TaskbarList2.ahk

/*
class: TaskbarList3
provides more methods for managing taskbar properties (Win7 features)
*/
#include TaskbarList3\TaskbarList3.ahk

/*
class: TaskbarList4
provides even more methods for the taskbar
*/
#include TaskbarList4\TaskbarList4.ahk

/*
group: UIAutomation
*/
/*
class: UIAutomationCondition
base interface for conditions
*/
#Include UIAutomationCondition\UIAutomationCondition.ahk

/*
class: UIAutomationNotCondition
represents the negative of another condition
*/
#Include UIAutomationNotCondition\UIAutomationNotCondition.ahk

/*
class: UIAutomationBoolCondition
represents a condition that can either be true or false
*/
#Include UIAutomationBoolCondition\UIAutomationBoolCondition.ahk

/*
group: helper structs
*/
/*
class: StructBase
a base class for all struct classes
*/
#include Helper Classes\StructBase.ahk