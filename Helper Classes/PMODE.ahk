/*
class: PMODE
an enumeration class containing operation modes, e.g. for IOperationsProgressDialog::SetMode().

Remarks:
	- The field names exactly match the contants' names, except that the leading "PDM_" is omitted.
*/
class PMODE
{
	/*
	Field: DEFAULT
	Use the default progress dialog operations mode.
	*/
	static DEFAULT := 0x00000000

	/*
	Field: RUN
	The operation is running.
	*/
	static RUN := 0x00000001

	/*
	Field: PREFLIGHT
	The operation is gathering data before it begins, such as calculating the predicted operation time.
	*/
	static PREFLIGHT := 0x00000002

	/*
	Field: UNDOING
	The operation is rolling back due to an Undo command from the user.
	*/
	static UNDOING := 0x00000004

	/*
	Field: ERRORSBLOCKING
	Error dialogs are blocking progress from continuing.
	*/
	static ERRORSBLOCKING := 0x00000008

	/*
	Field: INDETERMINATE
	The length of the operation is indeterminate. Do not show a timer and display the progress bar in marquee mode.
	*/
	static INDETERMINATE := 0x00000010
}