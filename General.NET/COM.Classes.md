| [Index](../index.md) | [General .NET](../General.NET.md) |

---

# COM Classes in .NET

- Assembly must be COM visible
- Each exposed class, interface and enumeration must have a [`GuidAttribute`](https://learn.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.guidattribute)
  with a unique [GUID](https://learn.microsoft.com/de-de/dotnet/api/system.guid) value
- Optionally use of [`ProgIdAttribute`](https://learn.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.progidattribute)
- Class must have a parameterless constructor
- It seems, that the first impleted interface will be taken for COM?
- No generic base classes or first generic interfaces allowed
- Only [`public`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/public)
  members are accessible under COM (no [`protected`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/protected) etc.)
- Inherited interface members mit be implemented again (with [`new`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/new-modifier))
  at inheriting interface
- Additional interfaces without reimplementation with [`new`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/new-modifier)
  are accessible only after specific cast (implement cast methods for that)
- Parameters of kind "ByRef" ([`ref`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/ref),
  [`out`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/out))
  must be implemented of COM type [`Variant`](https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/variant-data-type)
  ([`Object`](https://learn.microsoft.com/en-us/dotnet/api/system.object))
- Parameters must have an equivalent in COM (for [`Variant`](https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/variant-data-type));
  known types without equivalent are
  - [`Byte`](https://learn.microsoft.com/en-us/dotnet/api/system.byte) and
  - [Structures](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/struct)
- Nested classes are allowed and named with a "+" (plus) as concatenation
- It seems, no inheritance of classes possible? or from public classes only?
- Classes, members that can't/shouldn't be exposed to COM must be marked with a
  [ComVisibleAttribute](https://learn.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.comvisibleattribute)
  of value [`false`](https://learn.microsoft.com/en-us/dotnet/api/system.boolean)
- [`For Each`](https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/for-eachnext-statement)
  enumerable support for COM needs direct [`IEnumerator`](https://learn.microsoft.com/en-us/dotnet/api/system.collections.ienumerator)
  `GetEnumerator()` method implementation, could be done with [`IEnumerable`](https://learn.microsoft.com/en-us/dotnet/api/system.collections.ienumerable)
  interface with precidence over [`IEnumerable<T>`](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.ienumerable-1)
  (type library exporter give them the [`DispId`](https://learn.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.dispidattribute)
  of -4 / 0xFFFC for a [NewEnum implementation](https://learn.microsoft.com/de-de/office/vba/language/concepts/getting-started/using-for-eachnext-statements))
- Returning array with values needs to be of element type [`Object`](https://learn.microsoft.com/en-us/dotnet/api/system.object),
  so `Linq` `Cast<Object>().ToArray()` would help here

- COM libraries without registration and without strong names are usable in/with manifests
  (use tool [`MT`](https://learn.microsoft.com/en-us/windows/win32/sbscs/mt-exe) for that)

## Errors

- Manifest Side by side errors occurs when
  - Manifest file has false structure or values
  - Duplicate GUID's or ProgId's used
- `CreateObject(...)` ([VBA](https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/createobject-function),
  [VBScript](https://learn.microsoft.com/en-us/previous-versions//xzysf6hc(v=vs.85))) error will occur when
  - Exception occured in constructor
