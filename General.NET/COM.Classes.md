[Index](../index.md) | [General .NET](../General.NET.md)

---

# COM Classes in .NET
- Assembly must be COM visible
- Each class and interface must have a `GuidAttribute` with a unique GUID value
- Optionally use of `ProgIdAttribute`
- Class must have a parameterless constructor
- It seems, that the first impleted interface will be taken for COM?
- No generic base classes or first generic interfaces allowed
- Only `public` members are accessible under COM (no `protected` etc.)
- Inherited interface members mit be implemented again (with `new`) at inheriting interface
- Additional interfaces without reimplementation with `new` are accessible only after specific cast (implement cast methods for that)
- Parameters of kind "ByRef" (`ref`, `out`) must be implemented of COM type `Variant` (`Object`)
- Parameters must have an equivalent in COM (for `Variant`); known types without equivalent are
  - `Byte` and
  - Structures
- Nested classes are allowed and named with a "+" (plus) as concatenation
- It seems, no inheritance of classes possible? or from public classes only?

- COM libraries without registration and without strong names are usable in/with manifests

- Manifest Side by side errors occurs when
  - Manifest file has false structure or values
  - Duplicate GUID's or ProgId's used
- `CreateObject(...)` error will occur when
  - Exception occured in constructor
