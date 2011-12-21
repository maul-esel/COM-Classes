/*
class: ILIF
an enumeration class containing constants on image quality

Remarks:
	- The field names exactly match the contants' names, except that the leading "ILIF_" is omitted.
*/
class ILIF
{
	/*
	Field: ALPHA
	Indicates that the item in the imagelist has an alpha channel.
	*/
	static ALPHA := 0x00000001

	/*
	Field: LOWQUALITY
	*Windows Vista and later.* Indicates that the item in the imagelist was generated via a StretchBlt function, consequently image quality may have degraded.
	*/
	static LOWQUALITY := 0x00000002
}