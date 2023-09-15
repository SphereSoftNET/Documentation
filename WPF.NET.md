| [Index](index.md) |

<hr style="height: 1px" />

# WPF (Windows Presentation Framework) .NET

- [Use property of `StaticResource` for a Binding](#use-property-of-staticresource-for-a-binding)



## [Use property of `StaticResource` for a Binding](#)

```xml
<UserControl DataContext="{DynamicResource MyViewModelResource}">
  <UserControl.Resources>
    <local:MyViewModel x:Key="MyViewModelResource"/>
  </UserControl.Resources>
  
  <Button Content="{Binding ButtonText, Source={StaticResource MyViewModelResource}}"
</UserControl>
```


<!-- FOOTER -->
<hr style="height: 1px" />
<span style="font-size: 0.7em">© SphereSoft.NET, Holger Boskugel, Berlin, Germany</span>
<a href="http://spheresoft.net" style="font-size: 0.7em; float: right">spheresoft.net</a>
