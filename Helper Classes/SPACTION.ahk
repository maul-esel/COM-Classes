/*
class: SPACTION
an enumeration class describing an action being performed that requires progress to be shown to the user using an IActionProgress / IOperationsProgressDialog interface.

Remarks:
	- The field names exactly match the contants' names, except that the leading "SPACTION_" is omitted.
*/
class SPACTION
{
	/*
	Field: NONE
	No action is being performed.
	*/
	static NONE := 0
	
	/*
	Field: MOVING
	Files are being moved.
	*/
	static MOVING := 1
	
	/*
	Field: COPYING
	Files are being copied.
	*/
	static COPYING := 2
	
	/*
	Field: RECYCLING
	Files are being deleted.
	*/
	static RECYCLING := 3
	
	/*
	Field: APPLYINGATTRIBS
	A set of attributes are being applied to files.
	*/
	static APPLYINGATTRIBS := 4
	
	/*
	Field: DOWNLOADING
	A file is being downloaded from a remote source.
	*/
	static DOWNLOADING := 5
	
	/*
	Field: SEARCHING_INTERNET
	An Internet search is being performed.
	*/
	static SEARCHING_INTERNET := 6
	
	/*
	Field: CALCULATING
	A calculation is being performed.
	*/
	static CALCULATING := 7
	
	/*
	Field: UPLOADING
	A file is being uploaded to a remote source.
	*/
	static UPLOADING := 8
	
	/*
	Field: SEARCHING_FILES
	A local search is being performed.
	*/
	static SEARCHING_FILES := 9
	
	/*
	Field: DELETING
	**Windows Vista and later.** A deletion is being performed.
	*/
	static DELETING := 10
	
	/*
	Field: RENAMING
	**Windows Vista and later.** A renaming action is being performed.
	*/
	static RENAMING := 11
	
	/*
	Field: FORMATTING
	**Windows Vista and later.** A formatting action is being performed.
	*/
	static FORMATTING := 12
	
	/*
	Field: COPY_MOVING
	**Windows 7 and later.** A copy or move action is being performed.
	*/
	static COPY_MOVING := 13
}