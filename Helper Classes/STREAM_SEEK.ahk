/*
class: STREAM_SEEK
an enumeration class specifying the origin from which to calculate the new seek-pointer location. They are used for the dworigin parameter in the IStream::Seek method. The new seek position is calculated using this value and the dlibMove parameter.

Remarks:
	- The field names exactly match the contants' names, except that the leading "STREAM_SEEK_" is omitted.

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/aa380359)
*/
class STREAM_SEEK
{
	/*
	Field: SET
	The new seek pointer is an offset relative to the beginning of the stream. In this case, the dlibMove parameter is the new seek position relative to the beginning of the stream.
	*/
	static SET := 0

	/*
	Field: CUR
	The new seek pointer is an offset relative to the current seek pointer location. In this case, the dlibMove parameter is the signed displacement from the current seek position.
	*/
	static CUR := 1

	/*
	Field: END
	The new seek pointer is an offset relative to the end of the stream. In this case, the dlibMove parameter is the new seek position relative to the end of the stream.
	*/
	static END := 2
}