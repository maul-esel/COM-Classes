/*
class: PSC
an enumeration class containing flags that specify the state of a property.

Remarks:
	- The field names exactly match the contants' names, except that the leading "PSC_" is omitted.

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/bb762531)
*/
class PSC
{
	/*
	Field: NORMAL
	The property has not been altered.
	*/
	static NORMAL := 0x0000

	/*
	Field: NOTINSOURCE
	The requested property does not exist for the file or stream on which the property handler was initialized.
	*/
	static NOTINSOURCE := 0x0001

	/*
	Field: DIRTY
	The property has been altered but has not yet been committed to the file or stream.
	*/
	static DIRTY := 0x0002
}