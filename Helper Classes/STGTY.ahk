/*
class: STGTY
an enumeration class containing flags used in the type member of the STATSTG structure to indicate the type of the storage element. A storage element is a storage object, a stream object, or a byte-array object (LOCKBYTES).

Remarks:
	- The field names exactly match the contants' names, except that the leading "STGTY_" is omitted.

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/aa380348)
*/
class STGTY
{
	/*
	Field: STORAGE
	Indicates that the storage element is a storage object.
	*/
	static STORAGE := 1

	/*
	Field: STREAM
	Indicates that the storage element is a stream object.
	*/
	static STREAM := 2

	/*
	Field: LOCKBYTES
	Indicates that the storage element is a byte-array object.
	*/
	static LOCKBYTES := 3

	/*
	Field: PROPERTY
	Indicates that the storage element is a property storage object.
	*/
	static PROPERTY := 4
}