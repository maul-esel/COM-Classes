/*
class: THUMBBUTTONMASK
an enumeration class containing flags to specify which members of a THUMBBUTTON structure contain valid data.

Remarks:
	- The field names exactly match the contants' names, except that the leading "THB_" is omitted.
*/
class THUMBBUTTONMASK
{
	/*
	Field: BITMAP
	The iBitmap member contains valid information.
	*/
	static BITMAP := 0x00000001

	/*
	Field: ICON
	The hIcon member contains valid information.
	*/
	static ICON := 0x00000002

	/*
	Field: TOOLTIP
	The szTip member contains valid information.
	*/
	static TOOLTIP := 0x00000004

	/*
	Field: FLAGS
	The dwFlags member contains valid information.
	*/
	static FLAGS := 0x00000008
}