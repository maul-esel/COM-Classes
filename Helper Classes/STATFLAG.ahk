/*
class: STATFLAG
an enumeration class containing flags that indicate whether the method should try to return a name in the pwcsName member of the STATSTG structure. The values are used in the ILockBytes::Stat, IStorage::Stat, and IStream::Stat methods to save memory when the pwcsName member is not required.

Remarks:
	- The field names exactly match the contants' names, except that the leading "STATFLAG_" is omitted.

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/aa380316)
*/
class STATFLAG
{
	/*
	Field: DEFAULT
	Requests that the statistics include the pwcsName member of the STATSTG structure.
	*/
	static DEFAULT := 0

	/*
	Field: NONAME
	Requests that the statistics not include the pwcsName member of the STATSTG structure. If the name is omitted, there is no need for the ILockBytes::Stat, IStorage::Stat, and IStream::Stat methods methods to allocate and free memory for the string value of the name, therefore the method reduces time and resources used in an allocation and free operation.
	*/
	static NONAME := 1

	/*
	Field: NOOPEN
	Not implemented.
	*/
	static NOOPEN := 2
}