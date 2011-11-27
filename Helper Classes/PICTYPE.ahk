/*
class: PICTYPE
an enumeration class describing the type of a picture object.

Remarks:
	- The field names exactly match the contants' names, except that the leading "PICTYPE_" is omitted.
*/
class PICTYPE
{
	/*
	Field: UNINITIALIZED
	The picture object is currently uninitialized. This value is only valid as a return value from IPicture::get_Type and is not valid with the PICTDESC structure.
	*/
	static UNINITIALIZED := -1

	/*
	Field: NONE
	A new picture object is to be created without an initialized state. This value is valid only in the PICTDESC structure.
	*/
	static NONE := 0

	/*
	Field: BITMAP
	The picture type is a bitmap. When this value occurs in the PICTDESC structure, it means that the bmp field of that structure contains the relevant initialization parameters.
	*/
	static BITMAP := 1

	/*
	Field: METAFILE
	The picture type is a metafile. When this value occurs in the PICTDESC structure, it means that the wmf field of that structure contains the relevant initialization parameters.
	*/
	static METAFILE := 2

	/*
	Field: ICON
	The picture type is an icon. When this value occurs in the PICTDESC structure, it means that the icon field of that structure contains the relevant initialization parameters.
	*/
	static ICON := 3

	/*
	Field: ENHMETAFILE
	The picture type is an enhanced metafile. When this value occurs in the PICTDESC structure, it means that the emf field of that structure contains the relevant initialization parameters.
	*/
	static ENHMETAFILE := 4
}