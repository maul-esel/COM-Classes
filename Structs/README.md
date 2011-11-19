# Helper structs
This folder holds classes that are used to represent structs used by one or several COM Classes.

## Requirements for such a class:
* All classes must define a constructor (`__New()`), optionally with a list of initial values.
* the member names must exactly match those in the struct definition
* the members must be accessible via get/set
* each class must implement a method called `To'StructPtr()` (no parameters), that converts the current values into a structure in memory and returns a pointer to it.

## Usage:
Usually, it should be possible to pass either the struct instance or a pointer (for example obtained by calling `ToStructPtr()`) to a method.
A COM class can also document the structs it can handle for each function (if not all can be handled).
Of course, it must also be documented what structs instances can be passed, with a link to the class' documentation.