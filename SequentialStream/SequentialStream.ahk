/*
class: SequentialStream
implements the ISequentialStream interface and supports simplified sequential access to stream objects.

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows 2000 Professional, Windows 2000 Server or higher
	Base classes - Unknown
	Helper classes - (none)

Remarks:
	This is an abstract base class. If you want to use it's methods, create an instance of the derived Stream class.
*/
class SequentialStream extends Unknown
{
	/*
	Field: IID
	This is IID_ISequentialStream. It is required to create an instance.
	*/
	static IID := "{0C733A30-2A1C-11CE-ADE5-00AA0044773D}"

	/*
	Field: ThrowOnCreation
	indicates that attempting to create an instance of this class without supplying a valid pointer should throw an exception.
	*/
	static ThrowOnCreation := true

	/*
	Method: Read
	reads a specified number of bytes from the stream object into memory, starting at the current seek pointer.

	Parameters:
		byRef UPTR buffer - receives a pointer to the buffer the stream is read to
		UINT bytesToRead - the number of bytes to read
		[opt] byRef UINT bytesRead - receives the number of bytes actually read

	Returns:
		BOOL success - true on success, false otherwise

	Remarks:
		If the buffer contains a string, StrGet() might be of use.
	*/

	Read(byRef buffer, bytesToRead, byRef bytesRead := "")
	{
		return this._Error(DllCall(NumGet(this.vt+03*A_PtrSize), "ptr", this.ptr, "ptr", buffer, "UInt", bytesToRead, "UInt*", bytesRead))
	}

	/*
	Method: Write
	writes a specified number of bytes into the stream object starting at the current seek pointer.

	Parameters:
		UPTR buffer - a pointer to the buffer that contains the bytes to write
		UINT bytesToWrite - the number of bytes to write
		[opt] byRef UINT bytesWritten - receives the number of bytes actually written

	Returns:
		BOOL success - true on success, false otherwise
	*/
	Write(buffer, bytesToWrite, byRef bytesWritten := "")
	{
		return this._Error(DllCall(NumGet(this.vt+04*A_PtrSize), "ptr", this.ptr, "ptr", buffer, "UInt", bytesToWrite, "UInt*", bytesWritten))
	}
}