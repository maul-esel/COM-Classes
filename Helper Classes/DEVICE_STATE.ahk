/*
class: DEVICE_STATE
an enumeration class containing constants that indicate the current state of an audio endpoint device.

Remarks:
	- The field names exactly match the contants' names, except that the leading "DEVICE_STATE_" / "DEVICE_STATE" is omitted.

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/dd370823)
*/
class DEVICE_STATE
{
	/*
	Field: ACTIVE
	The audio endpoint device is active. That is, the audio adapter that connects to the endpoint device is present and enabled. In addition, if the endpoint device plugs into a jack on the adapter, then the endpoint device is plugged in.
	*/
	static ACTIVE := 0x00000001

	/*
	Field: DISABLED
	The audio endpoint device is disabled. The user has disabled the device in the Windows multimedia control panel, Mmsys.cpl. For more information, see <Remarks at http://msdn.microsoft.com/en-us/library/aa363230.aspx>.
	*/
	static DISABLED := 0x00000002

	/*
	Field: NOTPRESENT
	The audio endpoint device is not present because the audio adapter that connects to the endpoint device has been removed from the system, or the user has disabled the adapter device in Device Manager.
	*/
	static NOTPRESENT := 0x00000004

	/*
	Field: UNPLUGGED
	The audio endpoint device is unplugged. The audio adapter that contains the jack for the endpoint device is present and enabled, but the endpoint device is not plugged into the jack. Only a device with jack-presence detection can be in this state. For more information about jack-presence detection, see <Audio Endpoint Devices at http://msdn.microsoft.com/en-us/library/ms678705.aspx>.
	*/
	static UNPLUGGED := 0x00000008

	/*
	Field: MASK_ALL
	Includes audio endpoint devices in all states—active, disabled, not present, and unplugged.
	*/
	static MASK_ALL := 0x0000000F
}