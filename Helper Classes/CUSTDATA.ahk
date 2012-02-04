/*
class: CUSTDATA
a structure class that represents custom data.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/CUSTDATA)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ms221456%28v=VS.85%29.aspx)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - (unknown)
	Base classes - _CCF_Error_Handler_, StructBase
	Helper classes - CUSTDATAITEM
	Other classes - CCFramework
*/
class CUSTDATA extends StructBase
{
	/*
	Field: cCustData
	The number of custom data items in the <prgCustData> array.
	*/
	cCustData := 0

	/*
	Field: prgCustData
	An array of custom data items.

	Remarks:
		You can set this either to an AHK-array of CUSTDATAITEM instances, an AHK-array of pointers to CUSTDATAITEM instances or to a simple pointer to the memory array.
		When the instance was created by a call to <FromStructPtr()>, this is always an AHK-array of CUSTDATAITEM class instances.
	*/
	prgCustData := 0

	/*
	Method: constructor
	creates a new instance of the class

	Parameters:
		[opt] CUSTDATAITEM[] array - the initial value for the <prgCustData> field
		[opt] UINT count - the initial value for the <cCustData> field
	*/
	__New(array := 0, count := 0)
	{
		this.prgCustData := array, this.cCustData := count
	}

	/*
	Method: ToStructPtr
	converts the instance to a script-usable struct and returns its memory adress.

	Parameters:
		[opt] PTR ptr - the fixed memory address to copy the struct to.

	Returns:
		PTR ptr - a pointer to the struct in memory
	*/
	ToStructPtr(ptr := 0)
	{
		local count, array, item, size := CUSTDATAITEM.GetRequiredSize()

		if (!ptr)
		{
			ptr := this.Allocate(this.GetRequiredSize())
		}

		array := this.prgCustData, count := this.cCustData
		if IsObject(this.prgCustData)
		{
			count := this.cCustData ? this.cCustData : this.prgCustData.maxIndex(), array := CCFramework.AllocateMemory(count * size)
			Loop this.prgCustData.maxIndex()
			{
				item := this.prgCustData[A_Index], item := IsObject(item) ? item.ToStructPtr() : item
				CCFramework.CopyMemory(item, array + (A_PtrSize - 1) * size, size)
			}
		}

		NumPut(count, 1*ptr, 00, "UInt")
		NumPut(array, 1*ptr, 04, "Ptr")

		return ptr
	}

	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class.

	Parameters:
		PTR ptr - a pointer to a CUSTDATA struct in memory

	Returns:
		CUSTDATA instance - the new CUSTDATA instance
	*/
	FromStructPtr(ptr)
	{
		local instance, count, array, size := CUSTDATAITEM.GetRequiredSize()

		count := NumGet(1*ptr, 00, "UInt"), array := []
		Loop count
			array.Insert(CUSTDATAITEM.FromStructPtr(ptr + (A_Index - 1) * size))

		instance := new CUSTDATA(count, array)
		instance.SetOriginalPointer(ptr)
		return instance
	}

	/*
	Method: GetRequiredSize
	calculates the size a memory instance of this class requires.

	Parameters:
		[opt] OBJECT data - an optional data object that may cotain data for the calculation.

	Returns:
		UINT bytes - the number of bytes required

	Remarks:
		- This may be called as if it was a static method.
		- The data object is ignored by this class.
	*/
	GetRequiredSize(data := "")
	{
		return 4 + A_PtrSize
	}
}