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
#include _CCF_Error_Handler_.ahk

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
class: StructBase
a base class for all structure classes
*/
#include Structure Classes\StructBase.ahk

/*
class: CustomDestinationList
a class for managing custom jump lists in Windows7
*/
#include CustomDestinationList\CustomDestinationList.ahk

/*
class: KDC
a constant class containing system-defined jump list categories
*/
#include KDC.ahk

/*
class: FILE_ATTRIBUTE
a constant class representing file attributes
*/
#include Constant Classes\FILE_ATTRIBUTE.ahk

/*
class: SFGAO
a constant class containing attributes that can be retrieved on a file or folder
*/
#include Constant Classes\SFGAO.ahk

/*
class: SW
a constant class containing flags specifying the show-behaviour of a window
*/
#include Constant Classes\SW.ahk

/*
class: CF
a constant class containing clipboard formats
*/
#include Constant Classes\CF.ahk

/*
class: CLR
a constant class containing special values for COLORREF variables
*/
#include Constant Classes\CLR.ahk

/*
class: DVASPECT
a constant class containing flags used to the desired data r view aspect
*/
#include Constant Classes\DVASPECT.ahk

/*
class: VARENUM
a constant class specifying the type of a variable
*/
#include Constant Classes\VARENUM.ahk

/*
group: RichEdit management
*/
/*
class: RichEditOLE
class for managing a RichEdit control
*/
#include RichEditOLE\RichEditOLE.ahk

/*
class: RECO
a constant class containing RichEdit clipboard operations
*/
#include Constant Classes\RECO.ahk

/*
class: REO
a constant class containing flags that control a REOBJECT structure
*/
#include Constant Classes\REO.ahk

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
class: IDC
a constant class containing system-defined cursors
*/
#include Constant Classes\IDC.ahk

/*
class: IDI
a constant class containing system-defined icons
*/
#include Constant Classes\IDI.ahk

/*
class: OBM
a constant class containing system-defined bitmaps
*/
#include Constant Classes\OBM.ahk

/*
class: ILC
a constant class containing image list creation flags
*/
#include Constant Classes\ILC.ahk

/*
class: ILCF
a constant class containing image list copy flags
*/
#include Constant Classes\ILCF.ahk

/*
class: ILD
a constant class containing image list draw flags
*/
#include Constant Classes\ILD.ahk

/*
class: ILDI
a constant class containing flags for discarding images from an image list
*/
#include Constant Classes\ILDI.ahk

/*
class: ILFIP
a constant class containing flags for setting an image as "current" in an image list
*/
#include Constant Classes\ILFIP.ahk

/*
class: ILGOS
a constant class containing flags for retrieving an image's size
*/
#include Constant Classes\ILGOS.ahk

/*
class: ILIF
a constant class containing constants indicating an image's quality
*/
#include Constant Classes\ILIF.ahk

/*
class: ILR
a constant class containing flags specifying how to apply a mask to an image
*/
#include Constant Classes\ILR.ahk

/*
class: ILS
a constant class containing image list state flags
*/
#include Constant Classes\ILS.ahk

/*
class: PICTUREATTRIBUTES
a constant class containing picture attributes
*/
#include Constant Classes\PICTUREATTRIBUTES.ahk

/*
class: PICTYPE
a constant class indicating the type of a picture
*/
#include Constant Classes\PICTYPE.ahk

/*
group: Audio
*/
/*
class: MMDeviceEnumerator
a class for enumerating devices
*/
#include MMDeviceEnumerator\MMDeviceEnumerator.ahk

/*
class: MMDeviceCollection
represents a collection of devices
*/
#include MMDeviceCollection\MMDeviceCollection.ahk

/*
class: MMDevice
represents an audio device
*/
#include MMDevice\MMDevice.ahk

/*
class: DEVICE_STATE
a constant class indicating the current state of an audio device
*/
#include Constant Classes\DEVICE_STATE.ahk

/*
class: EDataFlow
a constant class indicating the direction in which audio data flows
*/
#include Constant Classes\EDataFlow.ahk

/*
class: ERole
a constant class indicating the role the system has assigned to an audio device
*/
#include Constant Classes\ERole.ahk

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
class: PDOPSTATUS
a constant class containing operation progress dialog's status flags
*/
#include Constant Classes\PDOPSTATUS.ahk

/*
class: PDTIMER
a constant class containing progress dialog timer flags
*/
#include Constant Classes\PDTIMER.ahk

/*
class: PMODE
a constant class containing progress dialog modes
*/
#include Constant Classes\PMODE.ahk

/*
class: PROGDLG
a constant class containing progress dialog flags
*/
#include Constant Classes\PROGDLG.ahk

/*
class: SPACTION
a constant class a progress dialog action
*/
#include Constant Classes\SPACTION.ahk

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
class: PSC
a constant class containing property state flags
*/
#include Constant Classes\PSC.ahk

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
class: Storage
represents a storage, aka "filesystem in a file"
*/
#include Storage\Storage.ahk

/*
class: EnumSTATSTG
enumerates storage or stream descriptions
*/
#include EnumSTATSTG\EnumSTATSTG.ahk

/*
class: LOCKTYPE
a constant class containing flags that indicate the type of locking requested for a range of bytes
*/
#include Constant Classes\LOCKTYPE.ahk

/*
class: STATFLAG
a constant class controlling a STATSTG structure
*/
#include Constant Classes\STATFLAG.ahk

/*
class: STGC
a constant class containing storage / stream commit flags
*/
#include Constant Classes\STGC.ahk

/*
class: STGM
a constant class specifying storage modes
*/
#include Constant Classes\STGM.ahk

/*
class: STGMOVE
a constant class containing storage move flags
*/
#include Constant Classes\STGMOVE.ahk

/*
class: STGTY
a constant class specifying a storage type
*/
#include Constant Classes\STGTY.ahk

/*
class: STREAM_SEEK
a constant class used to calculate the new seek-pointer location in a stream
*/
#include Constant Classes\STREAM_SEEK.ahk

/*
group: shell
*/
/*
class: ShellItem
represents an "Shell item", such as a file
*/
#include ShellItem\ShellItem.ahk

/*
class: EnumShellItems
enumerates a collection of IShellItems
*/
#include EnumShellItems\EnumShellItems.ahk

/*
class: ShellLinkW
manages shell links (*.lnk files) (Unicode version)
*/
#include ShellLinkW\ShellLinkW.ahk

/*
class: ShellLinkA
manages shell links (*.lnk files) (ANSI version)
*/
#include ShellLinkA\ShellLinkA.ahk

/*
typedef: ShellLink
defines "ShellLink" as the encoding-specific version

Remarks:
	- In v2, this is always ShellLinkW
*/
global ShellLink := ShellLinkW

/*
class: SICHINT
a constant class containing ShellItem compare flags
*/
#include Constant Classes\SICHINT.ahk

/*
class: SIGDN
a constant class containing ShellItem display name flags
*/
#include Constant Classes\SIGDN.ahk

/*
class: SLGP
a constant class containing path retrieval flags
*/
#include Constant Classes\SLGP.ahk

/*
class: SLR
a constant class containing flags on how to find a ShellLink's target
*/
#include Constant Classes\SLR.ahk

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
class: STPFLAG
a constant class specifying taskbar tab properties
*/
#include Constant Classes\STPFLAG.ahk

/*
class: TBPFLAG
a constant clas specifying taskbar progress flags
*/
#include Constant Classes\TBPFLAG.ahk

/*
class: THUMBBUTTONFLAGS
a constant class specifying flags for a taskbar thumbnail toolbar button
*/
#include Constant Classes\THUMBBUTTONFLAGS.ahk

/*
class: THUMBBUTTONMASK
a constant class containing flags htat indicate the valid parts of a THUMNNUTTON structure
*/
#include Constant Classes\THUMBBUTTONMASK.ahk

/*
group: type information
*/
/*
class: Dispatch
implements the IDispatch interface and provides its dynamic-call functionality
*/
#include Dispatch\Dispatch.ahk

/*
class: ProvideClassInfo
provides type information interfaces for a class
*/
#include ProvideClassInfo\ProvideClassInfo.ahk

/*
class: TypeComp
provides type functionality for compilers
*/
#include TypeComp\TypeComp.ahk

/*
class: TypeInfo
provides detailed information on a type
*/
#include TypeInfo\TypeInfo.ahk

/*
class: TypeInfo2
provides even more information on a type
*/
#include TypeInfo2\TypeInfo2.ahk

/*
class: TypeLib
provides functionality for loading type information from a library
*/
#include TypeLib\TypeLib.ahk

/*
class: TypeLib2
provides even more functionality for type libraries
*/
#include TypeLib2\TypeLib2.ahk

/*
class: CALLCONV
a constant class identifying the calling convention used by a member function
*/
#include Constant Classes\CALLCONV.ahk

/*
class: CLSCTX
a constant class indicating execution context
*/
#include Constant Classes\CLSCTX.ahk

/*
class: DESCKIND
a constant class specifying the kind of a type description
*/
#include Constant Classes\DESCKIND.ahk

/*
class: DISPATCHF
a constant class containing invoke flags
*/
#include Constant Classes\DISPATCHF.ahk

/*
class: DISPID
a constant class containing special values used to identify methods, properties etc.
*/
#include Constant Classes\DISPID.ahk

/*
class: MEMBERID
a constant class containing more special values for members
*/
#include Constant Classes\MEMBERID.ahk

/*
class: FUNCFLAG
a constant class containing function attrributes
*/
#include Constant Classes\FUNCFLAG.ahk

/*
class: FUNCKIND
a constant class indicating the kind of a function
*/
#include Constant Classes\FUNCKIND.ahk

/*
class: IDLFLAG
a constant class containing parameter flags
*/
#include Constant Classes\IDLFLAG.ahk

/*
class: IMPLTYPEFLAG
a constant class specifying implementation type flags
*/
#include Constant Classes\IMPLTYPEFLAG.ahk

/*
class: INVOKEKIND
a constant class that specifies the way a function is invoked
*/
#include Constant Classes\INVOKEKIND.ahk

/*
class: LIBFLAGS
a constant class containing type library flags
*/
#include Constant Classes\LIBFLAGS.ahk

/*
class: PARAMFLAGS
a constant class containing parameter flags
*/
#include Constant Classes\PARAMFLAGS.ahk

/*
class: REGKIND
a constant class that controls how a type is registered
*/
#include Constant Classes\REGKIND.ahk

/*
class: SYSKIND
a constant class identifying a target operating system
*/
#include Constant Classes\SYSKIND.ahk

/*
class: TYPEFLAG
a constant class holding type flags
*/
#include Constant Classes\TYPEFLAG.ahk

/*
class: TYPEKIND
a constant class specifying the kind of a type
*/
#include Constant Classes\TYPEKIND.ahk

/*
class: VARFLAG
a constant class containing variable flags
*/
#include Constant Classes\VARFLAG.ahk

/*
class: VARKIND
a constant class specifying a variable's kind
*/
#include Constant Classes\VARKIND.ahk

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
class: UIAutomationElementArray
represents an array of UIAutomation elements
*/
#include UIAutomationElementArray\UIAutomationElementArray.ahk