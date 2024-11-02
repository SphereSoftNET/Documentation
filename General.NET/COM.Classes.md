| [Index](../index.md) | [General .NET](../General.NET.md) |

<hr style="height: 1px" />

<!-- TOC (needs manual creation and ID linkage in headers!) -->
- [Design of COM usable classes in .NET](#design-of-com-usable-classes-in-net)
  - [Errors](#errors)

<hr style="height: 1px" />

## [Design of COM usable classes in .NET](#)

- Assembly must be COM visible
- Each exposed class, interface and enumeration must have a [`GuidAttribute`](https://learn.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.guidattribute)
  with a unique [GUID](https://learn.microsoft.com/en-us/dotnet/api/system.guid) value
- Optionally use of [`ProgIdAttribute`](https://learn.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.progidattribute)
- Class must have a parameterless constructor
- It seems, that the first implemented interface will be taken for COM?
- No generic base classes or first generic interfaces (without inherited none generic interface) allowed
- Only [`public`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/public)
  members are accessible under COM (no [`protected`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/protected) etc.)
- Inherited interface members might be implemented again (with [`new`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/new-modifier))
  at inheriting interface
- Additional interfaces without reimplementation with [`new`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/new-modifier)
  are accessible only after specific cast (implement cast methods for that)
- Parameters of kind "ByRef" ([`ref`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/ref),
  [`out`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/out))
  must be implemented of COM type [`Variant`](https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/variant-data-type)
  ([`Object`](https://learn.microsoft.com/en-us/dotnet/api/system.object))
- Parameters must have an equivalent in COM (for [`VARIANT`](https://learn.microsoft.com/en-us/windows/win32/api/oaidl/ns-oaidl-variant) structure);
  known types without equivalent in [VBScript](https://learn.microsoft.com/en-us/windows/win32/lwef/using-vbscript) are
  - [`Byte`](https://learn.microsoft.com/en-us/dotnet/api/system.byte) and
  - [Structures](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/struct)
- Parameters for object instances, stored in a variable before method calls, should have COM type
  [`Variant`](https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/variant-data-type)
  ([`Object`](https://learn.microsoft.com/en-us/dotnet/api/system.object))
- Nested classes are allowed and named with a "+" (plus) as concatenation
- Use of [`public`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/public)
  [`abstract`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/abstract)
  classes are possible
- Classes, members that can't/shouldn't be exposed to COM must be marked with a
  [`ComVisibleAttribute`](https://learn.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.comvisibleattribute)
  of value [`false`](https://learn.microsoft.com/en-us/dotnet/api/system.boolean)
- [`For Each`](https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/for-eachnext-statement)
  enumerable support for COM needs direct [`IEnumerator`](https://learn.microsoft.com/en-us/dotnet/api/system.collections.ienumerator)
  `GetEnumerator()` method implementation, could be done with [`IEnumerable`](https://learn.microsoft.com/en-us/dotnet/api/system.collections.ienumerable)
  interface with precidence over [`IEnumerable<T>`](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.ienumerable-1)
  (type library exporter exports as [`IEnumVARIANT`](https://learn.microsoft.com/en-us/windows/win32/api/oaidl/nn-oaidl-ienumvariant)
  and give them the [`DispId`](https://learn.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.dispidattribute)
  of [-4 / 0xFFFFFFFC](https://learn.microsoft.com/en-us/previous-versions/windows/desktop/automat/dispid-constants)
  for a [_NewEnum implementation](https://learn.microsoft.com/en-us/office/vba/language/concepts/getting-started/using-for-eachnext-statements))
- Handling arrays out and in with values needs to be of element type [`Object`](https://learn.microsoft.com/en-us/dotnet/api/system.object),
  so `Linq` `Cast<Object>().ToArray()` would help here and for in correct cast then the incoming elements
- Handling of optional parameters by [`params`](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/params)
  in (VB/VBA/VBScript as [`ParamArray`]()) requires an implementation as COM type [`Variant`](https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/variant-data-type)
  ([`Object`](https://learn.microsoft.com/en-us/dotnet/api/system.object)) array.
  The framework handles this as a [SAFEARRAY](https://learn.microsoft.com/en-us/windows/win32/api/oaidl/ns-oaidl-safearray)([VARIANT](https://learn.microsoft.com/en-us/windows/win32/api/oaidl/ns-oaidl-variant)).
  When exporting the type library (TLB) with [TlbExp](https://learn.microsoft.com/en-us/dotnet/framework/tools/tlbexp-exe-type-library-exporter)
  it becomes a [`vararg`](https://learn.microsoft.com/en-us/windows/win32/midl/vararg) attribute there also.
  Specific implementation and change in TLB/IDL is required for VB, while VBScript can direct use it.

  - VB98/VB6 require a pointer to the SAFEARRAY(VARIANT). In that case it needs:
    - implement the parameter as `ref Object[]`
    - compile your library or application
    - export the type library with [`TlbExp`](https://learn.microsoft.com/en-us/dotnet/framework/tools/tlbexp-exe-type-library-exporter)
    - open the type library with the tool [`oleview`](https://learn.microsoft.com/en-us/windows/win32/com/ole-com-object-viewer)
    - save the content as IDL file
    - add the atribute [`vararg`](https://learn.microsoft.com/en-us/windows/win32/midl/vararg) after the attribute [`id`](https://learn.microsoft.com/en-us/windows/win32/midl/id)
    - compile the IDL file with [`midl`](https://learn.microsoft.com/en-us/windows/win32/com/midl-compiler)
      (requires the [`cl`](https://learn.microsoft.com/en-us/cpp/build/reference/compiler-options) and includes)
  

- COM libraries without registration and without strong names are usable in/with manifests
  (use tool [`MT`](https://learn.microsoft.com/en-us/windows/win32/sbscs/mt-exe) for that)



### Errors

- Manifest Side by side errors occurs when
  - Manifest file has false structure or values
  - Duplicate GUID's or ProgId's used
- `CreateObject(...)` ([VBA](https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/createobject-function),
  [VBScript](https://learn.microsoft.com/en-us/previous-versions//xzysf6hc(v=vs.85))) error will occur when
  - Exception occured in constructor



### Samples for `params`

#### Default implemention (accessible for `VBScript`)

```cs
MyParamArrayMethod(params Object[] values)
```

Results in VB

```vb
MyParamArrayMethod(ByVal ParamArray values() As Object)
```

Being in IDL

```ìdl
[id(1), vararg]
HRESULT MyParamArrayMethod([in] SAFEARRAY(VARIANT) values);
```

#### Required implementation for VB98/VB6

```cs
MyParamArrayMethod(ref Object[] values)
```

Should result in VB

```vb
MyParamArrayMethod(ByVal ParamArray values() As Object)
```

Requires in IDL

```ìdl
[id(1), vararg]
HRESULT MyParamArrayMethod([in] SAFEARRAY(VARIANT)* values);
```


### Sample for `For Each` enumerator with generic `IEnumerable<T>` implementation

```cs
public class ForEachSample :
  IEnumerable<String>
{
  private readonly List<String> _list = new List<String>();

  public ForEachSample()
  {
  }

  public IEnumerator GetEnumerator() => ((IEnumerable<String>)this).GetEnumerator();
  
  IEnumerator<String> IEnumerable<String>.GetEnumerator() => _list.GetEnumerator();
}
```



<!-- FOOTER -->
<hr style="height: 1px" />
<span style="font-size: 0.7em">© SphereSoft.NET, Holger Boskugel, Berlin, Germany</span>
<a href="http://spheresoft.net" style="font-size: 0.7em; float: right">spheresoft.net</a>
