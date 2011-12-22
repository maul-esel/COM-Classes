/*
class: DVASPECT
an enumeration class containing flags that specify the desired data or view aspect of the object when drawing or getting data.

Remarks:
	- The field names exactly match the contants' names, except that the leading "DVASPECT_" is omitted.

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ms690318)
*/
class DVASPECT
{
	/*
	Field: CONTENT
	Provides a representation of an object so it can be displayed as an embedded object inside of a container. This value is typically specified for compound document objects. The presentation can be provided for the screen or printer.
	*/
	CONTENT := 1

	/*
	Field: THUMBNAIL
	Provides a thumbnail representation of an object so it can be displayed in a browsing tool. The thumbnail is approximately a 120 by 120 pixel, 16-color (recommended) device-independent bitmap potentially wrapped in a metafile.
	*/
	THUMBNAIL := 2

	/*
	Field: ICON
	Provides an iconic representation of an object.
	*/
	ICON := 4

	/*
	Field: DOCPRINT
	Provides a representation of the object on the screen as though it were printed to a printer using the Print command from the File menu. The described data may represent a sequence of pages.
	*/
	DOCPRINT := 8
}