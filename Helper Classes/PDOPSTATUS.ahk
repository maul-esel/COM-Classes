/*
class: PDOPSTATUS
an enumeration class containing the possible return values for IOperationsProgressDialog::GetOperationStatus().

Remarks:
	- The field names exactly match the contants' names, except that the leading "PDOPS_" is omitted.
*/
class PDOPSTATUS
{
	/*
	Field: RUNNING
	Operation is running, no user intervention.
	*/
	static RUNNING := 1

	/*
	Field: PAUSED
	Operation has been paused by the user.
	*/
	static PAUSED := 2

	/*
	Field: CANCELLED
	Operation has been canceled by the user - now go undo.
	*/
	static CANCELLED := 3

	/*
	Field: STOPPED
	Operation has been stopped by the user - terminate completely.
	*/
	static STOPPED := 4

	/*
	Field: ERRORS
	Operation has gone as far as it can go without throwing error dialogs.
	*/
	static ERRORS := 5
}