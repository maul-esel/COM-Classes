/*
class: ERole
an enumeration class containing constants that indicate the role that the system has assigned to an audio endpoint device.

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/dd370842)
*/
class ERole
{
	/*
	Field: eConsole
	Games, system notification sounds, and voice commands.
	*/
	static eConsole := 0

	/*
	Field: eMultimedia
	Music, movies, narration, and live music recording.
	*/
	static eMultimedia := 1

	/*
	Field: eCommunications
	Voice communications (talking to another person).
	*/
	static eCommunications := 2

	/*
	Field: ERole_enum_count
	The number of members in the ERole enumeration (not counting the ERole_enum_count member).
	*/
	static ERole_enum_count := 3
}