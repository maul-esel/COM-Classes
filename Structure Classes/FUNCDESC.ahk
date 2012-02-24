/*
class: FUNCDESC
a structure class that describes a function.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/FUNCDESC)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ms221425)

Requirements:
	AutoHotkey - AHK v2 alpha
	Base classes - _CCF_Error_Handler_, StructBase
	Constant classes - DISPID, MEMBERID, FUNCKIND, INVOKEKIND, CALLCONV, FUNCFLAGS
	Structure classes - ELEMDESC
*/
class FUNCDESC extends StructBase
{
	/*
	Field: memid
	The function member ID. For some special values you might use the fields in the MEMBERID enum class.
	*/
	memid := 0

	/*
	Field: lprgscode
	_[*TBD*]_
	*/
	lprgscode := 0

	/*
	Field: lprgelemdescParam
	_[*TBD*]_
	*/
	lprgelemdescParam := 0

	/*
	Field: funckind
	Indicates the type of function (virtual, static, or dispatch-only). You might use the fields of the FUNCKIND class for convenience.
	*/
	funckind := 0

	/*
	Field: invkind
	The invocation type. Indicates whether this is a property function, and if so, which type. You might use the fields of the INVOKEKIND enum class for convenience.
	*/
	invkind := 0

	/*
	Field: callconv
	The calling convention. You might use the fields of the CALLCONV enum class for convenience.
	*/
	callconv := 0

	/*
	Field: cParams
	The total number of parameters.
	*/
	cParams := -1

	/*
	Field: cParamsOpt
	The number of optional parameters.
	*/
	cParamsOpt := 0

	/*
	Field: oVft
	if <funckind> is FUNCKIND.VIRTUAL, specifies the offset in the VTBL.
	*/
	oVft := 0

	/*
	Field: cScodes
	The number of possible return values.
	*/
	cScodes := 0

	/*
	Field: elemdescFunc
	An ELEMDESC structure specifying the function return type.
	*/
	elemdescFunc := 0

	/*
	Field: wFuncFlags
	The function flags. You might use the fields in the FUNCFLAG class for convenience.
	*/
	wFuncFlags := 0

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
		static ed_size := ELEMDESC.GetRequiredSize()
		local mem, val

		if (!ptr)
		{
			ptr := this.Allocate(this.GetRequiredSize())
		}

		NumPut(this.memid, 1*ptr, 00, "UInt")
		, mem := this.Allocate(4), val := this.lprgscode, CCFramework.CopyMemory(&val, mem, 4), NumPut(mem, 1*ptr, 04, "Ptr")
		, NumPut(IsObject(this.lprgelemdescParam) ? this.lprgelemdescParam.ToStructPtr() : this.lprgelemdescParam, 1*ptr, 04 + 1*A_PtrSize, "Ptr")
		, NumPut(this.funckind, 1*ptr, 04 + 2 * A_PtrSize, "UInt")
		, NumPut(this.invkind, 1*ptr, 08 + 2 * A_PtrSize, "UInt")
		, NumPut(this.callconv, 1*ptr, 12 + 2 * A_PtrSize, "UInt")
		, NumPut(this.cParams, 1*ptr, 16 + 2 * A_PtrSize, "Short")
		, NumPut(this.cParamsOpt, 1*ptr, 18 + 2 * A_PtrSize, "Short")
		, NumPut(this.oVft, 1*ptr, 20 + 2 * A_PtrSize, "Short")
		, NumPut(this.cScodes, 1*ptr, 22 + 2 * A_PtrSize, "Short")
		, IsObject(this.elemdescFunc) ? this.elemdescFunc.ToStructPtr(ptr + 24 + 2 * A_PtrSize) : CCFramework.CopyMemory(this.elemdescFunc, ptr + 24 + 2 * A_PtrSize, ed_size)
		, NumPut(this.wFuncFlags, 1*ptr, 24 + 2 * A_PtrSize + ed_size, "Short")

		return ptr
	}

	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class.

	Parameters:
		PTR ptr - a pointer to a FUNCDESC struct in memory
		[opt] BOOL own - false if the instance must no release the pointer (defaults to true)

	Returns:
		FUNCDESC instance - the new FUNCDESC instance
	*/
	FromStructPtr(ptr, own := true)
	{
		static ed_size := ELEMDESC.GetRequiredSize()

		local instance := new FUNCDESC()
		instance.SetOriginalPointer(ptr, own)

		instance.memid := NumGet(1*ptr, 00, "UInt")
		, instance.lprgscode := NumGet(NumGet(1*ptr, 04, "Ptr"), 00, "UInt")
		, instance.lprgdescParam := ELEMDESC.FromStructPtr(NumGet(1*ptr, 04 + A_PtrSize, "Ptr"))
		, instance.funckind := NumGet(1*ptr, 04 + 2 * A_PtrSize, "UInt")
		, instance.invkind := NumGet(1*ptr, 08 + 2 * A_PtrSize, "UInt")
		, instance.callconv := NumGet(1*ptr, 12 + 2 * A_PtrSize, "UInt")
		, instance.cParams := NumGet(1*ptr, 16 + 2 * A_PtrSize, "Short")
		, instance.cParamsOpt := NumGet(1*ptr, 18 + 2 * A_PtrSize, "Short")
		, instance.oVft := NumGet(1*ptr, 20 + 2 * A_PtrSize, "Short")
		, instance.elemdescFunc := ELEMDESC.FromStructPtr(ptr + 24 + 2 * A_PtrSize)
		, instance.wFuncFlags := NumGet(1*ptr, 24 + 2 * A_PtrSize + ed_size, "Short")

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
		return 26 + 2 * A_PtrSize + ELEMDESC.GetRequiredSize()
	}
}