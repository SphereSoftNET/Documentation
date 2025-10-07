| [Index](index.md) |

<hr style="height: 1px" />

## Sandcastle Help File Builder (SHFB)

- [Building `HTML Help 1 (chm)` files](#building-html-help-1-chm-files)



### [Building `HTML Help 1 (chm)` files](#)

This output format is available only at `Build` in the `Presentation style` of `VS2013`.

> ⚠️ - **Important hint on paths**
>
> If the path to the working directory contains a `.h` or `.H` the compilation
> with the HTML Help File Compiler throw warnings of not being HTML (`HHC3004 :
> warning : AlertCaution.png : The HTML tag ... is not a valid HTML tag (it does
> not begin with an alphanumeric character)`) for none HTML content and generates
> a bad `*.chm` file.
>
> Getting around this, choose a project path without a `.h` or `.H` *OR* set a
> path in `Paths` / `Output Paths` / `Help content output path` relative or absolute
> from your project that don't contains those character combination and let copy the
> result with the `Output Deployment` plugin to your project path.



<!-- FOOTER -->
<hr style="height: 1px" />
<span style="font-size: 0.7em">© SphereSoft.NET, Holger Boskugel, Berlin, Germany</span>
<a href="http://spheresoft.net" style="font-size: 0.7em; float: right">spheresoft.net</a>
