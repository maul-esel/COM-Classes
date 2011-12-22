/*
class: ILFIP
an enumeration class containing flags for setting an image as "current" in an image list.

Remarks:
	- The field names exactly match the contants' names, except that the leading "ILFIP_" is omitted.

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/bb761411)
*/
class ILFIP
{
	/*
	Field: ALWAYS
	Always get the image (can be slow).
	*/
	static ALWAYS := 0x00000000

	/*
	Field: FROMSTANDBY
	Only get if on standby.
	*/
	static FROMSTANDBY := 0x00000001
}