# Helper classes
This folder holds classes that are used to represent structs or enumerations used by one or several COM Classes.

## Struct classes
### Requirements
* The classes must derive from the StructBase class.
* The field names must exactly match those in the struct definition.
* The fields must be accessible via get/set.
* Nested structs must be implemented as separate struct classes. Add an instance of the nested struct, access the values like this: `struct.nestedstruct.field := value`
* Each class must implement the abstract methods defined and documented in StructBase.
* For more information, see the StructBase documentation.

### Usage
Usually, it should be possible to pass either the struct instance or a pointer (for example obtained by calling `ToStructPtr()`) to a method.
A COM class can also document the structs it can handle for each function (if not all can be handled).
Of course, it must also be documented ***what*** struct instances can be passed.

# Enumeration classes
### Requirements
* The member names must exactly match those in the enumeration definition, except that a leading prefix, if present, is ommitted.
* Use static fields.

### Usage
The enumeration members can be used in methods or for struct fields. Ensure the corresponding enumeration is documented.
This should also replace cases where you could pass "string flags".