/*
class: ILGOS
an enumeration class containing flags for retrieving an image's size.

Remarks:
	- The field names exactly match the contants' names, except that the leading "ILGOS_" is omitted.

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/bb761415)
*/
class ILGOS
{
	/*
	Field: ALWAYS
	Always get the original size (can be slow).
	*/
	static ALWAYS := 0x00000000

	/*
	Field: FROMSTANDBY
	Only get if present or on standby.
	*/
	static FROMSTANDBY := 0x00000001
}