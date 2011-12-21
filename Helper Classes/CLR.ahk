/*
class: CLR
an enumeration class containing special values for COLORREF variables.

Remarks:
	- The field names exactly match the contants' names, except that the leading "CLR_" is omitted.
*/
class CLR
{
	/*
	Field: DEFAULT
	Default color. The exact meaning depends on the place where this is used.
	*/
	static DEFAULT := 0xFF000000

	/*
	Field: NONE
	No color. The exact meaning depends on the place where this is used.
	*/
	static NONE := 0xFFFFFFFF
}