---
title: "CCF specification"
permalink: spec.html
layout: spec_layout

---

# CCF specification
## Introduction
This is the official specification for the [**COM Classes Framework (CCF)**](https://github.com/maul-esel/COM-Classes "CCF github repository").
It defines explicit guidelines classes in the CCF must fulfill.

The CCF is a collection of AutoHotkey classes that wrap COM interfaces in the standardized way described here.
It is intended to help AutoHotkey scripters & programmers and ease the access to those interfaces.

This specification assumes the reader has at least a (very) basic understanding of *interfaces* and *classes*.
Experiences with AutoHotkey and its advanced features, namely `DllCall()` and memory handling, as well as a basic understanding of COM are required, too.
If you're missing any of those, check out [the links](#links) on the bottom of this page.

***

## Definitions
### COM Classes Framework
The *COM Classes Framework*, or *CCF*, describes a collection of AutoHotkey classes that provide comfortable access to COM non-dispatch interfaces from the AutoHotkey scripting language.
These classes are written in AutoHotkey themselves. They must conform to the guidelines defined below
and are stored in a github repository at [https://github.com/maul-esel/COM-Classes](https://github.com/maul-esel/COM-Classes).

### AutoHotkey
*AutoHotkey* is a scripting language originally developed by Chris Mallett.
Custom AutoHotkey forks and versions include the original version (also called AutoHotkey *"basic"*, *"classic"* or *"vanilla"*), as well as *AutoHotkey\_L*, *AutoHotkey\_H* and *IronAHK*.
In this document, the term *"AutoHotkey"* usually refers to the [supported forks](#versions).

### Interface classes
Within this specification, the term *"interface classes"* refers to classes that *"wrap"* a COM interface.
That means they have the same methods as the interface and redirect any call to a COM instance pointer.

### memory
The term ***"persistent memory"*** describes any memory directly or indirectly allocated via `CCFramework.AllocateMemory()`.
This allocated memory stays valid until it is explicitly released, usually (directly or indirectly) by `CCFramework.FreeMemory()`.

***"non-persistent memory"*** is everything allocated with `VarSetCapacity()`. This only stays valid as long as the corresponding variable is valid.
So if it's a local variable in a method, the memory is no longer valid when the method is left.
This may be intended (unneeded memory is automatically freed) or not (the memory may still be needed).

***

## This document
### code blocks
Within this document, all highlighted code is for AutoHotkey.
Inside code-blocks which aren't actually used for code but for templates or similar, `;` delimits a comment and `%NAME%` is a variable.

***

## Versions
This section defines the different forks and versions the classes in the CCF must be fully compatible to.
This means the code must not throw syntax errors or fail silently as well as it should work as documented.

### AutoHotkey branches
#### AutoHotkey ("classic", "basic", "vanilla") ![](bad.png)
AutoHotkey classic (by Chris Mallett, currently version *1.0.48.05*, no longer developed) is **not supported** by the CCF.
This framework is entirely based on classes which are not supported by AutoHotkey classic.

#### AutoHotkey\_L ![](ok.png)
AutoHotkey\_L (by Lexikos / Steve Gray, based on AutoHotkey classic, currently version ~*1.1*) should be **fully supported** by all classes.

All AutoHotkey\_L code must be placed in the [***AHK\_Lv1.1***](https://github.com/maul-esel/COM-Classes/tree/AHK\_Lv1.1) branch of the main git repository.

#### AutoHotkey v2 alpha ![](ok.png)
AutoHotkey v2 (by Lexikos / Steve Gray, based on AutoHotkey\_L, currently alpha) should be **fully supported** as well.
However, as it currently has a lot of breaking changes, ensuring compatibility with the latest version is very difficult and requires a lot of maintenance.

Code for AutoHotkey v2 should be placed in the [***master***](https://github.com/maul-esel/COM-Classes/tree/master) branch of the main git repository.

#### AutoHotkey\_H ![](ok.png)
AutoHotkey\_H version *1.x* (by HotKeyIt, based on AutoHotkey\_L) is compatible to AutoHotkey\_L, so it should obviously be **compatible** to the code in the ***AHK\_Lv1.1*** branch.

For the version *2.x* of AutoHotkey\_H, it should be compatible to the code in the ***master*** branch, too.

#### IronAHK ![](bad.png)
IronAHK (by polyethene, .NET version of AutoHotkey, currently alpha ~*0.7*) is **not supported**, for the same reason as AutoHotkey classic:
It currently does not support classes.

If a possible future version of IronAHK supports class syntax, the CCF might contain classes compatible to IronAHK. However, the following facts must be considered:

* COM is deeply integrated in the system, it is not guaranteed to work on non-Windows system.
Especially how COM is laid out in memory and which interfaces are implemented by which classes might differ.

* IronAHK is built on top of the .NET framework. It is questionable whether COM calls as they are realized right now (i.e. calls to functions in memory)
	would be allowed by the .NET framework, as they call unmanaged code.

* If the syntax or behaviour of IronAHK differs from other versions (i.e. AutoHotkey\_L or AutoHotkey v2), there must be a separate branch for it.

* There might be some builtin feature which makes CCF unnecessary.

### Important differences to consider
When transferring code from AutoHotkey\_L to AutoHotkey v2 or vice versa, important differences to consider include:

* string handling (see [*"Unicode & ANSI"*](#unicode__ansi) below)
* `Loop` syntax: in AutoHotkey v2, the `count` parameter is always an expression
* version comments
* the `is` operator (as of 27. 01. 2012, AutoHotkey v2 does not include such; it must be replaced by calls to `CCFramework.isInteger()`)

### Unicode & ANSI
For AutoHotkey\_L, it is important to ensure the **Unicode build** is supported as well as the **ANSI build**.
This is important when doing calls to `StrGet()` and `StrPut()` (always specify the encoding, such as `"UTF-16"`),
when handling the capacity of structures containing strings (not as pointers, but as character arrays; Unicode strings require twice the memory of ANSI strings),
when calling any COM method or `DllCall()` function that receives or outputs strings (use the appropriate string type, `"wstr"` or `"astr"`).

In AutoHotkey v2, special handling for Unicode strings **can and should be ommitted**, as AutoHotkey v2 is Unicode-only. However, ANSI strings must still be handled.

### 64bit
AutoHotkey\_L and AutoHotkey v2 (and therefore AutoHotkey\_H) are compatible with 64bit - Windows. The CCF classes should **support 64bit**, too.

To achieve this, it is required to use `A_PtrSize` to calculate structure offsets and size
and to use the `"Ptr"` type in calls to `NumGet()`, `NumPut()` and `DllCall()` (COM method calls as well as regular library calls).
One should pay attention to the fact that a lot of types actually map to this type, including `HWND`, `HBITMAP`, `HANDLE`, ...

***

## General guidelines
Some guidelines apply to all kind of classes, methods and code in the CCF. Those are listed here.

### Minimizing allocated memory
All code should not allocate more memory than actually needed. To do so, it may either allocate non-persistent memory or free allocated memory when no longer needed.
However, sometimes the memory must be still valid when the method allocating it is left.

### Avoid pollution of the global namespace
Methods must not create global variables if not absolutely needed. The only global (or super-global) variables allowed are the classes (and possibly [type definitions](#header_files)).
Since AutoHotkey also has "super-global" variables, this includes that any local variable must explicitly be declared as local to avoid overwriting a super-global.

### Array handling
Methods or structure classes sometimes need to handle arrays. This can either be arrays of structures or of pure values (integers, pointers, `BYTE`, ...).
In such a case they must as well accept a pointer to an array in memory or an AutoHotkey object (AutoHotkey array). This distinction can easily be made using `IsObject()`.
In case it's an AutoHotkey array, the array can hold pointers to structure instances or instances of the specific [structure class](#structure_classes) or it can be mixed.

So, if a pointer is given, it is just passed to a method. In a structure class, it depends on whether the array is **in** the structure or the structure just holds a pointer to the array.
In the first case, the memory is just copied over, otherwise, the specific field is set to the pointer.

If an AutoHotkey object is passed, memory is allocated for the array and the specific elements are copied to the memory array. The code must not use a `for`-Loop but a regular loop.
This ensures that non-array mambers (with string keys) are not copied.

However, copying a pointer or allocating memory for an object array require the handling code to know either the size or length of the array.
Structures holding these arrays often have a field that describes one of those (or the size of the entire structure), and methods sometimes have a parameter.
If so, this field or parameter is initialized with -1 (an optional parameter). If the user changes this value, the new value is assumed to be the number (or size) of elements
to be actually copied. Otherwise, if it's -1, the result of the array's `maxIndex()` method is taken as element count.

#### String arrays
Arrays of strings are generally handled the same. However, single object fields may never be considered *string pointers*, they're always taken as strings.

#### VARIANT arrays
The above does not fully apply to `VARIANT` (or `VARIANTARG`) arrays: those can either be a raw memory pointer to the string or an array of arbitrary values for the `VARIANT`.
Here as well, single object fields may not be considered pointers to `VARIANT` structures but integer values for the `VARIANT` structures.
Those values must be converted to [wrapper objects](#_and__parameters_and_fields "VARIANT handling").

#### COM SAFEARRAYs
When a COM SAFEARRAY is expected, the code should accept a raw pointer to the array structure as well as an AutoHotkey SAFEARRAY object created with `ComObjArray()`.
To get the value from the array object (which can be recognized using `IsObject()`), `ComObjValue()` must be called on it.

To handle SAFEARRAYs as output values or structure fields, the element type of the array must be determined at first. Then `ComObj()` can be used to create an array.
The below example shows how to handle such. Note that the `ptr` variable holds a pointer to the array here. The variable `arr` receives the object.

{% highlight ahk linenos %}
VT_ARRAY := 0x2000
DllCall("OleAut32\SafeArrayGetVartype", "Ptr", ptr, "UShort*", vt, "Int")
arr := ComObj(vt|VT_ARRAY, ptr)
{% endhighlight %}

It must be noted that this method still has some limitations defined by AutoHotkey. For instance, SAFEARRAYs with more than 8 dimensions are not supported.

### GUIDs
Any method or structure class handling GUIDs (or IIDs or CLSIDs or KNOWNFOLDERIDs or any other type which is actually a GUID)
must be able to handle either a string representing the GUID (such as `"{7C476BA2-02B1-48f4-8048-B24619DDC058}"`) or a raw pointer to the GUID in memory.
The distinction between those can be made using the `is` operator to check if the given value is an integer (or in AutoHotkey v2, `CCFramework.isInteger()`).

In case it is a pointer, it is either passed directly to a method or, for structure classes, copied into the structure. (Note: a GUID structure has 16 bytes.)

The conversion from a string can be made using `CCFramework.String2GUID()`. To obey the memory guidelines, a class often needs to pass a valid pointer as second parameter:
methods typically pass a pointer to non-persistent memory previously allocated, structure classes often pass the pointer to the memory instance of the structure + the offset of the GUID within.

When a GUID pointer is given and the handling code must convert it to a string, it may simply use `CCFramework.GUID2String()`.

### The framework class
The `CCFramework` class is a class that contains methods to be used by all other framework classes as well as end-users.
This is a static class (an exception is thrown when an attempt is made to create an instance).

### `VARIANT` and `VARIANTARG` parameters and fields
The `VARIANT` structure is not wrapped in a Helper class. Instead, special handling for it is implemented in the `CCFramework` class.

The `CCFramework.CreateVARIANT(value)` method creates a `VARIANT` wrapper object for the given value. This value can be

* another wrapper object. It is returned as is.
* a simple value, e.g. an integer or string. AutoHotkey-builtin COM wrapper objects are accepted, too. The type is calculated automatically by AutoHotkey.
* a typed value created using `ComObjParameter()`. This is required to give values a special meaning
	(e.g. if it should be of type `VT_ERROR` instead of `VT_I4`, which is the default for integers).

The wrapper object is an AutoHotkey object with 3 fields:

field	| description
--------|-------------------------------------------------------------------------
`ref`	| contains a pointer to the VARIANT structure in memory
`vt`	| contains the variable type, as defined e.g. in the VARENUM helper class
`value`	| contains the value: an integer, string or COM wrapper object

A COM method that accepts a `VARIANT` should receive the `ref` field with a type of `"Ptr"`.
In case the `VARIANT` must be placed in a structure (by value, not by reference), the structure class can call `CCFramework.CopyMemory()` to copy it.
To get a wrapper object from a pointer, `CCFramework.BuildVARIANT(ptr)` can be used.

Using these management functions, a method or structure field can receive all value types listed above.
When setting the field value on a structure class instance created using the `FromStructPtr(ptr)` method, the field always receives a wrapper object.
This should be documented on each `VARIANT` field or parameter.

The `VARIANTARG` structure is essentially the same as the `VARIANT` structure.
The handling methods `CCFramework.CreateVARIANTARG(value)` and `CCFramework.BuildVARIANTARG(ptr)` are simply aliases for the `VARIANT` handling methods.
For better readability (and maintainability) classes should still differentiate between those.
Besides this, all guidelines defined above apply to `VARIANTARG` structures, too.

### Working with other interfaces
When a method or structure class field expects a pointer to another interface, it should be able to handle both a raw interface pointer or a wrapper instance.
The code should generally be written so that it can handle a wrapper object even if the interface is not yet wrapped.

It's easy to distinguish between a pointer and a class instance using `IsObject()`. The COM pointer to a class instance can be accessed using the `ptr` field.
However, if the expected interface inherits `IDispatch` and is therefore unlikely to be wrapped, the code must instead be able to handle a COM object defined by AutoHotkey.
In this case, the pointer is accessed using `ComObjUnwrap()` (whereas the difference can still be detected using `IsObject()`).

***

## Interface Classes
### Interfaces to wrap
Basically, it is possible to wrap any interface. However, due to native COM support in all supported versions of AutoHotkey,
it is useless to wrap a "dual" interface that exposes all its methods and properties via `IDispatch`.

If any method in an interface receives a structure *by value* (and not *by reference*),
the entire interface cannot be wrapped as AutoHotkey does not support this (and incomplete interfaces are not allowed).

Besides those, there are currently no limitations of what interfaces can be added to CCF.

### The class name
The name of a class must exactly match the interface name, except that a leading "I", if present, is ommitted.
This "I" is part of a naming convention itself and indicates the name belongs to an interface.
In the conventions of object-oriented programming, it would not make sense to create an instance of an interface, which this code would imply:

{% highlight ahk %}instance := new IUnknown(){% endhighlight %}

Contrary, this code does not make this implication:

{% highlight ahk %}instance := new Unknown(){% endhighlight %}

It is also recommended to use the same capitalization as in the interface name, even though it doesn't matter in AutoHotkey.

### Base classes
The ultimate base class for almost all classes in the CCF is `_CCF_Error_Handler_`.
This class only defines the meta-function `__call()` and throws an exception if an unknown method is called on any derived class or class instance.

For all interface classes, the base class is `Unknown` (which of course inherits `_CCF_Error_Handler_`).
This class implements the methods of `IUnknown` which all COM interfaces inherit.
Besides that, the `Unknown` class also has some methods that should make life easier for derived classes.

### Inheritance
In COM, interfaces can inherit from another interface. They inherit all methods and properties. All COM interfaces inherit `IUnknown`.

This rule must be obeyed by CCF classes, too. Base interfaces' methods must not be included in a class. Instead, the base interfaces must be wrapped in a separate class and be extended by the inherited class.
It should also be noted that this applies to [the repository structure](#repository_structure) as well - only one interface class per folder.

### Methods
#### The constructor
The constructor for all interface classes is defined in `Unknown`.
It accepts one optional parameter, `ptr`, which can be used to supply a valid interface pointer to create an instance for instead of creating a COM instance from scratch.
It makes use of some [static class fields](#static_fields) and sets some [instance fields](#instance_fields).

The constructor uses `ComObjCreate()` to create an instance. In cases where this does not work or there's a better way, **do not override the constructor!**
Instead add one or several [constructor methods](#constructor_methods).

#### Interface methods
Interface classes must wrap all methods the wrapped interface has. They must be named the same way as in the interface definition (and the capitalization should match, too).

Read more on parameter and return value handling below.

#### Helper methods
Classes may also provide more methods that ease common tasks for the user. They can combine multiple method calls together, and possibly do calls to other DLL functions.
As an example, the `ImageList` class can define a method called `AddFile(path)` which loads an image from a file and adds it to the image list.

#### constructor methods
A special case are so-called *"constructor methods"*. Those are methods that can be called as if they were static (i.e. that do not rely on instance information)
and that create a new instance of the class from some given information.

These methods can especially be useful if just creating an instance with `ComObjCreate()` (which is used by the constructor) doesn't make sense or is impossible.
In such a case, do not override the constructor, instead set the [static field](#static_fields) `ThrowOnCreation` to `true` and provide a constructor method.

These methods should be named `From%INFO%` where *%INFO%* is the type of the given information. For example, constructor methods could be named `FromFile()` (or `FromPath()`),
`FromHBITMAP()`, `FromRECT()`, ...

Such a method must obtain a COM interface pointer in a special way (might be a `DllCall()`) and then create a new instance, supplying that pointer.

#### internal methods
If a class has some task it needs to do frequently, such as a difficult type conversion, it might add an internal method. However, this should be done very rarely.
If an internal method exists, it must be [documented](#documentation) as such and put at the end of the class.

***

### Parameters & return values
#### Regular parameters
A parameter's name may differ from the name it has in the "original" interface. It should be short and descriptive.
The parameter order may as well differ from the interface, for example if default values can be supplied.

Any other parameter that is a structure must accept both an instance of a helper class and a raw memory pointer. The distinction can be made using `IsObject()`.
In case it's a class instance, `instance.ToStructPtr()` is passed to the COM method. If the method releases a structure's memory which had previously been allocated by the same instance,
`instance.GetOriginalPointer()` is passed instead.

If a parameter is another COM interface, a method also needs to support both a raw interface pointer or an instance of another interface class. `IsObject()` may be used here as well.
If it's an object, the COM method receives `instance.ptr`.

#### Return values, `out` and `byRef` parameters
Most methods return `HRESULT` values. Those must be passed to the instance's `_Error()` method (defined in `Unknown`).
This method updates the instance's `Error` object and returns a boolean (`true` means success, `false` failure).
If none of the other guidelines in this section applies to a method, the method must return that boolean.

When a method has 1 `out` parameter that receives a value during the call, it must return this value. However, `_Error()` must still be called with the `HRESULT`.

If this parameter is a COM interface pointer or a pointer to a structure, wrap it in an instance of a helper or interface class.
Do this conditionally to make it work without this class:

{% highlight ahk %}return IsObject(OtherInterface) ? new OtherInterface(ptr) : ptr ; or:
return IsObject(HelperClass) ? HelperClass.FromStructPtr(ptr) : ptr{% endhighlight %}

Sometimes there are several `out` parameters in a method. In this case, the method must return the boolean as described above and handle the `out` parameters via AutoHotkey's `byRef`.
The above guideline about wrapping pointers in instances applies here as well.

In case a method does not return a `HRESULT` at all, it must clear the error object by calling `this._Error(0)`.
Unless the method returns nothing at all (`void`), the method's return value must be returned to the user, and `out` parameters must always be handled `byRef`.

In case a parameter is passed to the method, altered and its value is different on return, this parameter is always handled `byRef`.

### class fields
#### static fields
All interface classes must always supply a static `IID` field which holds the string representation of the interface identifier.

If there is a default (system) implementation for an interface available, a static `CLSID` field for the string representation of the class identifier must be set.
The constructor makes use of those two variables.

However, if a CLSID can't be supplied or it doesn't make sense to create an instance with `IID` and `CLSID` out of context or without special handling,
the static field `ThrowOnCreation` can be set to `true` to prevent a user from doing so. If an attempt is made to create an instance of such a class
without supplying a valid interface pointer, `Unknown` throws an exception. This must be properly documented for each class.
If this field is ommitted, it is assumed to be `false`.

Other static fields may include module handles for frequently used DLL, such as

{% highlight ahk %}static hModule := DllCall("LoadLibrary", "str", "CommCtrl") ; increases performance if the interface is in this DLL{% endhighlight %}

or other relevant information.

#### instance fields
The class constructor makes 2 instance fields available: `ptr` and `vt`, which hold pointers to the interface and its vTable.
They are mainly intended for internal use.

Whenever a method calls `_Error()`, the instance field `Error` is updated. This is an object with 3 fields:

field			| description
----------------|-------------------------------------------------------------------------------------------------------------
`code`			| receives the original `HRESULT` error code
`description`	| receives a description string for the error code in the native system language
`isError`		| a boolean which contains `true` if the `HRESULT` is an error and `false` if the `HRESULT` indicates success

These are thought for the user, not for internal use.

#### dynamic properties
In some cases, interfaces have properties. These are typically represented by get- and set methods.
For example, a property named `prop` would usually be represented by `get_prop()` and `set_prop(value)` (or `put_prop(value)`) methods.

Dynamic properties should be defined for those. That means a class can implement the `__Get()` and `__Set()` meta-functions and dynamically call the get-/ set- method for a property.
This enables the user to do

{% highlight ahk %}
instance.prop := 123
MsgBox % instance.prop
{% endhighlight %}

instead of

{% highlight ahk %}
instance.set_prop(123)
MsgBox % instance.get_prop()
{% endhighlight %}

The second code would still be valid though.

***

## Helper classes
Besides the so-called "interface classes", CCF also holds other classes that help the user to use interface classes.
They're called "helper classes" and there are currently 2 types of them:

### Structure classes
Structure classes are classes that represent memory structures. They inherit `StructBase` and implement the methods `FromStructPtr(ptr)`, `ToStructPtr()` and `GetRequiredSize()`.
The `StructBase` documentation includes documentation of those.

Besides that, structure classes have all fields that the represented structure has. They must be named exactly the same.
Nested structures are represented by instances of the matching helper class by default. However, they must also accept pointers to the nested instances.

If there is a *named* union in the structure, it is represented by an object with the specific fields.
*Unnamed* unions are simply ignored, the members are accessible via the "main" structure class.

For handling of arrays, see [above](#array_handling).

#### StructBase
So-called *"structure classes"* derive from `StructBase`. This class also has some methods to be used by derived classes.

### Constant classes
Constant classes can either represent some kind of enumeration (holding integers, sometimes referred to as "enumeration classes") or more complex values, such as GUIDs or strings.
The field names must exactly match those or the original constants, except that a common prefix must be ommitted.

Constant classes can inherit another class, however, this is a very rare case. There's no common base class for them yet.
In even more rare cases, constant classes may also contain methods.

For complex values, performance is important to consider. For example, GUIDs must be declared as strings, not converted to pointers on load-time.
If possible, there should never be classes holding object instances, as this might have a dramatic performance impact.

***

## "Header" files
In the context of CCF, *"header files"* are files that `#include` other classes and provide some more advantages.
For example, a "header" file might also contain a "type definition" like

{% highlight ahk %}global ShellLink := A_IsUnicode ? ShellLinkW : ShellLinkA ; super-global is required here{% endhighlight %}

This would make `ShellLink` an alias for another class.

Relative paths must be used for including. The "header" file assumes the "default including directory" is its own (the CCF) directory. It may change this value.
So a typical usage of a "header" file might be:

{% highlight ahk %}
#include %A_ScriptDir%\CCF ; change default include directory
#include CCF.ahk ; see below

#include %A_ScriptDir% ; reset include directory
#include OtherFile.ahk ; not part of the CCF
{% endhighlight %}

### CCF.ahk
The main "header" file for CCF is `CCF.ahk`. Add `#include` directives for every new class here, with a short comment.

### partial headers
If several interface and helper classes are related to a specific "topic", a "partial header" file might be created:
a "header" that only includes classes related to that topic (and the base classes, of course).

A user should be able to use everything related to that topic by just including this single "header" file, all dependencies must be included.

***

## Repository structure
Interface classes must be put in `%CLASSNAME%/%CLASSNAME%.ahk`, e.g. `ImageList/ImageList.ahk`.

Structure classes are put in `Structure Classes/%CLASSNAME%.ahk`, constant classes must reside in `Constant Classes/%CLASSNAME%.ahk`,
header files go in `%SUBJECT% header.ahk` (in the root folder of the repository).
`SUBJECT` is the "subject" the included classes are about or what they have in common. Examples would be `UIAutomation header.ahk` or `Type Information header.ahk`.

Examples go in `%CLASSNAME%/examples/example%N%.ahk`, where `N` is a increasing number, starting from 1.

### README files
The directory for an interface class must also hold a `README.md` in the following form:

    ## %CLASSNAME% README:
    This class implements the ***%INTERFACENAME%*** interface.

    ## Links:
    * [Author: %AUTHOR%](%WEBSITE%) ; or mail
    * [Documentation](%LINK%) ; usually something like http://maul-esel.github.com/COM-Classes/%BRANCH%/%CLASSNAME%
    * [msdn Documentation](%MSDN_LINK%) ; or other documentation source
    * [License: %LICENSE%](%LICENSE_LINK%)

    ## Description ; this is optional
    ...

***

## Examples
...

***

## Documentation
CCF classes should be well-documented. The documentation is processed with NaturalDocs, so it should use that format.
The existing classes should suffice as templates.

The documentation should also explicitly include the requirements for the OS, other classes, other software and more.
The required CCF classes must be separated by their type, i.e. "Base classes", "Constant classes", "Structure classes"
and "Other classes" (which holds interface classes and general use classes such as CCFramework).

***

## Requirements
...

***

## coding style
... (bracing style, explicit / implicit concatenation, ....)

***

## Summary
These guidelines are obligatory for classes to be added to the CCF. Major violations of those can prevent code from being added to the CCF.

However, they're not set in stone. This doesn't mean they'll change every week, making any code "invalid".
But minor updates, additions and improvements, especially now in the beginnings, are likely to happen.

***

## Links
1. Unicode vs. ANSI: [The Absolute Minimum Every Software Developer Absolutely,
	Positively Must Know About Unicode and Character Sets (No Excuses!)](http://www.joelonsoftware.com/printerFriendly/articles/Unicode.html)
2. 64bit vs. 32bit: [...]()
3. AutoHotkey:
	- AutoHotkey\_L documentation: [DllCall](http://l.autohotkey.net/docs/commands/DllCall.htm), with a section on [structures](http://l.autohotkey.net/docs/commands/DllCall.htm#struct)
	- DllCall type mapping: [...]()

4. Object-oriented programming:
	- [Wikipedia: OOP](http://en.wikipedia.org/wiki/Object-oriented_programming)
	- [Wikipedia: Class](http://en.wikipedia.org/wiki/Class_%28computer_programming%29)
	- [Wikipedia: Interface](http://en.wikipedia.org/wiki/Interface_%28computing%29#Software_interfaces_in_object_oriented_languages)

5. COM
	- msdn: [Component Object Model]()
	- IUnknown: [...]()
	- IDispatch: [...]()
	- COM in memory: [...]()
	- COM interfaces in AutoHotkey: [Tutorial]()