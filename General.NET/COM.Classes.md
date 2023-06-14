| [Index](../index.md) | [General .NET](../General.NET.md) |

---

# COM Classes in .NET
- Assembly must be COM visible
- Each class and interface must have a [`GuidAttribute`](https://learn.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.guidattribute) with a unique [GUID](https://learn.microsoft.com/de-de/dotnet/api/system.guid) value
- Optionally use of [`ProgIdAttribute`](https://learn.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.progidattribute)
- Class must have a parameterless constructor
- It seems, that the first impleted interface will be taken for COM?
- No generic base classes or first generic interfaces allowed
- Only [`public`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/public) members are accessible under COM (no [`protected`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/protected) etc.)
- Inherited interface members mit be implemented again (with [`new`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/new-modifier)) at inheriting interface
- Additional interfaces without reimplementation with [`new`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/new-modifier) are accessible only after specific cast (implement cast methods for that)
- Parameters of kind "ByRef" ([`ref`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/ref), [`out`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/out)) must be implemented of COM type [`Variant`](https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/variant-data-type) ([`Object`](https://learn.microsoft.com/en-us/dotnet/api/system.object))
- Parameters must have an equivalent in COM (for [`Variant`](https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/variant-data-type)); known types without equivalent are
  - [`Byte`](https://learn.microsoft.com/en-us/dotnet/api/system.byte) and
  - Structures
- Nested classes are allowed and named with a "+" (plus) as concatenation
- It seems, no inheritance of classes possible? or from public classes only?

- COM libraries without registration and without strong names are usable in/with manifests

- Manifest Side by side errors occurs when
  - Manifest file has false structure or values
  - Duplicate GUID's or ProgId's used
- `CreateObject(...)` ([VBA](https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/createobject-function), [VBScript](https://learn.microsoft.com/en-us/previous-versions//xzysf6hc(v=vs.85))) error will occur when
  - Exception occured in constructor
