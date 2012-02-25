/*
class: AnimationStyle
an enumeration class containing values for the AnimationStyle text attribute.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/AnimationStyle)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ee684012)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows XP / Windows Server 2003 or higher
*/
class AnimationStyle
{
	/*
	Field: None
	None.
	*/
	static None := 0

	/*
	Field: LasVegasLights
	The bounding rectangle displays a border of alternating icons of different colors.
	*/
	static LasVegasLights := 1

	/*
	Field: BlinkingBackground
	The font and background alternate between assigned colors and contrasting colors.
	*/
	static BlinkingBackground := 2

	/*
	Field: SparkleText
	The background displays flashing, multicolored icons.
	*/
	static SparkleText := 3

	/*
	Field: MarchingBlackAnts
	The bounding rectangle displays moving black dashes.
	*/
	static MarchingBlackAnts := 4

	/*
	Field: MarchingRedAnts
	The bounding rectangle displays moving red dashes.
	*/
	static MarchingRedAnts := 5

	/*
	Field: Shimmer
	The font alternates between solid and blurred.
	*/
	static Shimmer := 6

	/*
	Field: Other
	Other.
	*/
	static Other := -1
}