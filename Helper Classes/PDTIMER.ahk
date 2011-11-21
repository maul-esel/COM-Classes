/*
class: PDTimer
an enumeration class containing flags that indicate the action to be taken by the timer.

Remarks:
	- The field names exactly match the contants' names, except that the leading "PDTimer_" is omitted.
*/
class PDTimer
{
	/*
	Field: RESET
	Resets the timer to zero. Progress will be calculated from the time this method is called.
	*/
	static RESET := 0x00000001
	
	/*
	Field: PAUSE
	Progress has been suspended.
	*/
	static PAUSE := 0x00000002
	
	/*
	Field: RESUME
	Progress has been resumed.
	*/
	static RESUME := 0x00000003
}