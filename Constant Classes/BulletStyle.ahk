/*
class: BulletStyle
an enumeration class containing values for the BulletStyle text attribute.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/BulletStyle)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ee684018)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows XP / Windows Server 2003 or higher
*/
class BulletStyle
{
	/*
	Field: None
	None.
	*/
	static None := 0

	/*
	Field: HollowRoundBullet
	Hollow round bullet.
	*/
	static HollowRoundBullet := 1

	/*
	Field: FilledRoundBullet
	Filled round bullet.
	*/
	static FilledRoundBullet := 2

	/*
	Field: HollowSquareBullet
	Hollow square bullet.
	*/
	static HollowSquareBullet := 3

	/*
	Field: FilledSquareBullet
	Filled square bullet.
	*/
	static FilledSquareBullet := 4

	/*
	Field: DashBullet
	Dash bullet.
	*/
	static DashBullet := 5

	/*
	Field: Other
	Other.
	*/
	static Other := -1
}