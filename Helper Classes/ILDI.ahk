/*
class: ILDI
an enumeration class containing flags for discarding an image from an image list.

Remarks:
	- The field names exactly match the contants' names, except that the leading "ILDI_" is omitted.
	- <STANDBY> and <PURGE> are mutually exclusive. <RESETACCESS> can be combined with either.

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/bb761409)
*/
class ILDI
{
	/*
	Field: PURGE
	Discard and purge. 
	*/
	static PURGE := 0x00000001
	
	/*
	Field: STANDBY
	Discard to standby list. 
	*/
	static STANDBY := 0x00000002
	
	/*
	Field: RESETACCESS
	Reset the "has been accessed" flag. 
	*/
	static RESETACCESS := 0x00000004
	
	/*
	Field: QUERYACCESS
	Ask whether access flag is set (but do not reset). 
	*/
	static QUERYACCESS := 0x00000008
}