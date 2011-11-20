# Helper classes
This folder holds classes that are used to represent structs or enumerations used by one or several COM Classes.

## Struct classes
### Requirements
* the member names must exactly match those in the struct definition
* the members must be accessible via get/set
* each class must implement a method called `ToStructPtr()` (no parameters), that converts the current values into a structure in memory and returns a pointer to it.
* each class must implement a (static) `FromStructPtr(ptr)` method, which accepts a pointer to a memory struct and returns a new instance of the class.

### Usage
Usually, it should be possible to pass either the struct instance or a pointer (for example obtained by calling `ToStructPtr()`) to a method.
A COM class can also document the structs it can handle for each function (if not all can be handled).
Of course, it must also be documented what struct instances can be passed, with a link to the class' documentation.

# Enumeration classes
### Requirements
* the member names must exactly match those in the enumeration definition, except a eading prefix (if present) is ommitted.
* use static fields!

### Usage
The enumeration members can be used in methods or for struct fields. Ensure the corresponding enumeration is documented.
This should also replace cases where you could pass "string flags".