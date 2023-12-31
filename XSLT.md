| [Index](index.md) |

<hr style="height: 1px" />

# XSL(T) - Extensible Stylesheet Language (Transformation)

- [Ensure open/close XML/(X)HTML tags](#ensure-openclose-xmlxhtml-tags)



## Ensure open/close XML/(X)HTML tags

The main code is

```xml
<xsl:text xml:space="preserve"><![CDATA[]]></xsl:text>
```

So you can create a `script` tag:

```xml
<script>
  <xsl:text xml:space="preserve"><![CDATA[]]></xsl:text>
</script>
```

which then looks like:

```xml
<script></script>
```

or a `textarea` tag:

```xml
<textarea>
  <xsl:value-of select="ns:AnyText"/>
  <xsl:text xml:space="preserve"><![CDATA[]]></xsl:text>
</textarea>
```

which could look like:

```xml
<textarea>Content of AnyText source element</textarea>
```

or:

```xml
<textarea></textarea>
```

when XML element `ns:AnyText` not exists, has white space only or is empty.



<!-- FOOTER -->
<hr style="height: 1px" />
<span style="font-size: 0.7em">© SphereSoft.NET, Holger Boskugel, Berlin, Germany</span>
<a href="http://spheresoft.net" style="font-size: 0.7em; float: right">spheresoft.net</a>
