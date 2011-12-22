/*
class: CLR
an enumeration class containing special values for COLORREF variables.

Remarks:
	- The field names exactly match the contants' names, except that the leading "CLR_" is omitted.

Further documentation:
	- *msdn* (for example http://msdn.microsoft.com/en-us/library/windows/desktop/bb761395, or in other places else where it's used).
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