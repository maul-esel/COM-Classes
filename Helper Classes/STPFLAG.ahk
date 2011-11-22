/*
class: STPFLAG
an enumeration class used by the ITaskbarList4::SetTabProperties method to specify tab properties.

Remarks:
	- The field names exactly match the contants' names, except that the leading "STPF_" is omitted.
*/
class STPFLAG
{
	/*
	Field: NONE
	No specific property values are specified. The default behavior is used: the tab window provides a thumbnail and peek image, either live or static as appropriate.
	*/
	static NONE := 0x00000000

	/*
	Field: USEAPPTHUMBNAILALWAYS
	Always use the thumbnail provided by the main application frame window rather than a thumbnail provided by the individual tab window. Do not combine this value with <USEAPPTHUMBNAILWHENACTIVE>, doing so will result in an error.
	*/
	static USEAPPTHUMBNAILALWAYS := 0x00000001

	/*
	Field: USEAPPTHUMBNAILWHENACTIVE
	When the application tab is active and a live representation of its window is available, use the main application's frame window thumbnail. At other times, use the tab window thumbnail. Do not combine this value with <USEAPPTHUMBNAILALWAYS>, doing so will result in an error.
	*/
	static USEAPPTHUMBNAILWHENACTIVE := 0x00000002

	/*
	Field: USEAPPPEEKALWAYS
	Always use the peek image provided by the main application frame window rather than a peek image provided by the individual tab window. Do not combine this value with <USEAPPPEEKWHENACTIVE>, doing so will result in an error.
	*/
	static USEAPPPEEKALWAYS := 0x00000004

	/*
	Field: USEAPPPEEKWHENACTIVE
	When the application tab is active and a live representation of its window is available, show the main application frame in the peek feature. At other times, use the tab window. Do not combine this value with <USEAPPPEEKALWAYS>, doing so will result in an error.
	*/
	static USEAPPPEEKWHENACTIVE := 0x00000008
}