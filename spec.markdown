---
title: "CCF specification"
permalink: spec.html
layout: spec_layout

---

# CCF specification
## Introduction
This is the official specification for the [**COM Classes Framework (CCF)**](https://github.com/maul-esel/COM-Classes "CCF github repo").
It defines explicit guidelines classes in the CCF must fulfill.

The CCF is a collection of AutoHotkey classes that wrap COM interfaces in the standardized way described here.
It is intended to help AutoHotkey scripters & programmers and ease the access to those interfaces.

This specification assumes you have at least a (very) basic understanding of *interfaces* and *classes*.
Experiences with AutoHotkey and its advanced features, namely `DllCall()` and memory handling, as well as a basic understanding of COM are required, too.
If you're missing any of those, check out the links on the bottom of this page.

***

## Definitions
### COM Classes Framework
The *COM Classes Framework*, or *CCF*, describes a collection of AutoHotkey classes that provide comfortable access to COM non-dispatch interfaces from the AutoHotkey scripting language.
These classes are written in AutoHotkey themselves. They must conform to the guidelines defined below and are stored in a github repository at https://github.com/maul-esel/COM-Classes.

### AutoHotkey
*AutoHotkey* is a scripting language originally developed by Chris Mallett.
In this document, the term *"AutoHotkey"* refers to the original version (also called AutoHotkey *"basic"*, *"classic"* or *"vanilla"*) as well as to several custom forks,
namely *AutoHotkey\_L*, *AutoHotkey\_H* and *IronAHK*.

### Interface classes
Within this specification, the term *"interface classes"* refers to classes that *"wrap"* a COM interface.
That means they have the same methods as the interface and redirect any call to a COM instance pointer.

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

Code for AutoHotkey v2 should be placed in the [***master***](https://github.com/maul-esel/COM-Classes/tree/master) branch of the main github repository.

#### AutoHotkey\_H ![](ok.png)
AutoHotkey\_H version *1.x* (by HotKeyIt, based on AutoHotkey\_L) is compatible to AutoHotkey\_L, so it should obviously be **compatible** to the code in the ***AHK\_Lv1.1*** branch.

For the version *2.x* of AutoHotkey\_H, it should be compatible to the code in the ***master*** branch, too.

#### IronAHK ![](bad.png)
IronAHK (by polyethene, .NET version of AutoHotkey, currently alpha ~*0.7*) is **not supported** as well, for the same reason as AutoHotkey classic:
It currently does not support classes.

If a possible future version of IronAHK supports class syntax, the CCF might contain classes compatible to IronAHK. However, the following facts must be considered:

* COM is deeply integrated in the system, it is not guaranteed to work on non-Windows system.
Especially how COM is laid out in memory and which interfaces are implemented by which classes might differ.

* IronAHK is built on top of the .NET framework. It is questionable whether COM calls as they are realized right now (i.e. calls to functions in memory) would be allowed by the .NET framework.

* If the syntax or behaviour of IronAHK differs from other versions (i.e. AutoHotkey\_L or AutoHotkey v2), there must be a separate branch for it.

#### Important differences to consider
When transferring code from AutoHotkey\_L to AutoHotkey v2 or vice versa, important differences to consider include:

* string handling (see *"Unicode & ANSI"* below)
* `Loop` syntax: in AutoHotkey v2, the `count` parameter is always an expression
* version comments
* the `is` operator (as of 27. 01. 2012, AutoHotkey v2 does not include such; it must be replaced by calls to `CCFramework.isInteger()`)

### Unicode & ANSI
For AutoHotkey\_L, it is important to ensure the **Unicode build** is supported as well as the **ANSI build**.
This is important when doing calls to `StrGet()` and `StrPut()` (always specify the encoding, such as `"UTF-16"`),
when handling the capacity of structs containing strings (not as pointers, but as character arrays; Unicode strings require twice the memory of ANSI strings),
when calling any COM method or `DllCall()` function that receives or outputs strings (use the appropriate string type, `"wstr"` or `"astr"`).

In AutoHotkey v2, special handling for Unicode strings **can and should be ommitted**, as AutoHotkey v2 is Unicode-only. However, ANSI strings must still be handled.

### 64bit
AutoHotkey\_L and AutoHotkey v2 (and therefore AutoHotkey\_H) are compatible with 64bit - Windows. The CCF classes should **support 64bit**, too.

To achieve this, it is required to use `A_PtrSize` to calculate structure offsets and size
and to use the `"Ptr"` type in calls to `NumGet()`, `NumPut()` and `DllCall()` (COM method calls as well as regular library calls).
One should pay attention to the fact that a lot of types actually map to this type, including `HWND`, `HBITMAP`, `HANDLE`, ...

***

## Interfaces
Basically, it is possible to wrap any interface. However, due to native COM support in all supported versions of AutoHotkey,
it is useless to wrap a "dual" interface or a dispatch interface that inherits `IDispatch` and exposes all its methods and properties via `IDispatch`.

Besides that, there are currently no limitations of what interfaces can be added to CCF.

***

## Classes
### The class name
The name of a class must exactly match the interface name, except that a leading "I", if present, is ommitted.
This "I" is part of a naming convention itself and indicates the name belongs to an interface.
In the conventions of object-oriented programming, it would not make sense to create an instance of an interface, which this code would imply:

{% highlight ahk linenos %}
instance := new IUnknown()
{% endhighlight %}

Contrary, this code does not make this implication:

{% highlight ahk linenos %}
instance := new Unknown()
{% endhighlight %}

It is also recommended to use the same capitalization as in the interface name, even though it doesn't matter in AutoHotkey.

### Base classes
The ultimate base class for almost all classes in the CCF is `_CCF_Error_Handler_`.
This class only defines the meta-function `__call()` and throws an exception if an unknown method is called on any derived class or class instance.

#### Unknown
For all interface classes, the direct base class is `Unknown`. This class implements the methods of `IUnknown` which all COM interfaces inherit.
Besides that, the `Unknown` class also has some methods that should make life easier for derived classes.

#### StructBase
So-called *"struct classes"* derive from `StructBase`. This class also has some methods to be used by derived classes.

### The framework class
The `CCFramework` class is a class that contains methods to be used by all other framework classes as well as end-users.
This is a static class (an exception is thrown when an instance is created).

***

## Methods
### Interface methods
Interface classes must wrap all methods the wrapped interface has. They must be named the same way (and the capitalization should match, too).

### More methods
Classes may also provide more methods that ease common tasks for the user. They can combine multiple method calls together, and possibly do calls to other DLL functions.
As an example, the `ImageList` class can define a method called `AddFile(path)` which loads an image from a file and adds it to the image list.

#### constructor methods
A special case are so-called *"constructor method"*. Those are methods that can be called as if they were static (i.e. that do not rely on instance information)
and that create a new instance of the class from some given information.
These methods can especially be useful if just creating an instance with `ComObjCreate()` (which is used by the constructor `Unknown.__New()`) doesn't make sense or is impossible (see *"ThrowOnCreation"* below).

These methods should be named *"From[INFO]"* where *[INFO]* is the type of the given information. For example, constructor methods could be named `FromFile()` (or `FromPath()`),
`FromHBITMAP()`, `FromRECT()` (which would accept a structure), ...

Such a method must obtain a COM interface pointer in a special way (might be a `DllCall()`) and then create a new instance, supplying that pointer.

#### internal methods
...

***

## Parameters & return values
...

### `out` and `byRef` parameters
...

***

## Helper classes
...

### Structure classes
...

### Enumeration classes
...

***

## VARIANT and VARIANTARG parameters and fields
...

***

## class fields
...

### static
All interface classes must supply a static `IID` field which holds the string representation of the interface identifier.
If there is a default (system) implementation for an interface available, a static `CLSID` field for the string representation of the class identifier must be set.
The constructor (`Unknown.__New()`) makes use of those two variables.

However, if a CLSID can't be supplied or it doesn't make sense to create an instance with `IID` and `CLSID` out of context or without special handling,
the static field `ThrowOnCreation` can be set to `true` to prevent a user from doing so.
This must be properly documented, and at least one *"constructor method"* (see above) must be supplied.

Other static fields may include module handles for frequently used DLL, such as

{% highlight ahk linenos %}
static hModule := DllCall("LoadLibrary", "str", "CommCtrl")
{% endhighlight %}

or other relevant information.

### instance
All interface classes inherit the instance fields `ptr`, which holds the COM interface pointer,
`vt`, which holds the pointer to the COM instance's vTable and `Error` which contains error information for the user.

#### dynamic properties
In some cases, interfaces have properties. These are typically represented by get- and set methods.
For example, a property named `prop` would usually be represented by `get_prop()` and `set_prop(value)` (or `put_prop(value)`) methods.

Dynamic properties should be defined for those. That means a class can implement the `__get()` and `__set()` meta-functions and dynamically call the get-/ set- method for a property.
This enables the user to do

{% highlight ahk linenos %}
instance.prop := 123
MsgBox % instance.prop
{% endhighlight %}

instead of

{% highlight ahk linenos %}
instance.set_prop(123)
MsgBox % instance.get_prop()
{% endhighlight %}

The second code would still be valid though.

***

## Directory structure
...

***

## Examples
...

***

## Documentation
...

### README files
...

***

## Requirements
...

***

## coding style
... (bracing style, explicit / implicit concatenation, ....)

***

## Summary
These guidelines are obligatory for classes to be added to the CCF. Major violations of those can prevent your code from being added to the CCF.

However, they're not set in stone. This doesn't mean they'll change every week, making any code "invalid".
But minor updates, additions and improvements, especially now in the beginnings, are likely to happen.

***

## Links
* Unicode vs. ANSI: [The Absolute Minimum Every Software Developer Absolutely, Positively Must Know About Unicode and Character Sets (No Excuses!)](http://www.joelonsoftware.com/printerFriendly/articles/Unicode.html)

* 64bit vs. 32bit: [...]()

* AutoHotkey:

    * AutoHotkey\_L documentation: [DllCall](http://l.autohotkey.net/docs/commands/DllCall.htm), with a section on [structures](http://l.autohotkey.net/docs/commands/DllCall.htm#struct)

    * DllCall type mapping: [...]()

* Object-oriented programming:

    * [Wikipedia: OOP](http://en.wikipedia.org/wiki/Object-oriented_programming)

    * [Wikipedia: Class](http://en.wikipedia.org/wiki/Class_%28computer_programming%29)

    * [Wikipedia: Interface](http://en.wikipedia.org/wiki/Interface_%28computing%29#Software_interfaces_in_object_oriented_languages)

* COM

    * msdn: [Component Object Model]()

    * IUnknown: [...]()

    * IDispatch: [...]()

    * COM in memory: [...]()

    * COM interfaces in AutoHotkey: [Tutorial]()