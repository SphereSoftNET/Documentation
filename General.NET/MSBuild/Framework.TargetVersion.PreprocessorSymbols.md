| [Index](../../index.md) | [General .NET](../../General.NET.md) | [MS Build](../MSBuild.md) |

<hr style="height: 1px" />

<!-- TOC (needs manual creation and ID linkage in headers!) -->
- [Framework target version preprocessor symbols](#framework-target-version-preprocessor-symbols)
  - [MS Build target](#ms-build-target)
  - [Integrate MS Build target in project](#integrate-ms-build-target-in-project)
  - [Messages during build process](#messages-during-build-process)
  - [Target Framework.NET versions and related Preprocessor symbols](#target-frameworknet-versions-and-related-preprocessor-symbols)

<hr style="height: 1px" />

# [Framework target version preprocessor symbols](#)

This is a solution for Framework.NET target version missing Preprocessor Symbols during MS Build process.



## [MS Build target](#)

The setup is done with a MS Build target:

```xml
<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <Target Name="SSN_TargetFrameworkVersionPreprocessorSymbol" BeforeTargets="BeforeBuild">
    <PropertyGroup>
      <!-- See also https://learn.microsoft.com/en-us/dotnet/standard/frameworks#preprocessor-symbols -->
      <TargetFrameworkVersionPreprocessorSymbol Condition="$(TargetFrameworkVersion) == 'v4.8'">NET48</TargetFrameworkVersionPreprocessorSymbol>
      <TargetFrameworkVersionPreprocessorSymbol Condition="$(TargetFrameworkVersion) == 'v4.7.1'">NET471</TargetFrameworkVersionPreprocessorSymbol>
      <TargetFrameworkVersionPreprocessorSymbol Condition="$(TargetFrameworkVersion) == 'v4.7'">NET47</TargetFrameworkVersionPreprocessorSymbol>
      <TargetFrameworkVersionPreprocessorSymbol Condition="$(TargetFrameworkVersion) == 'v4.6.2'">NET462</TargetFrameworkVersionPreprocessorSymbol>
      <TargetFrameworkVersionPreprocessorSymbol Condition="$(TargetFrameworkVersion) == 'v4.6.1'">NET461</TargetFrameworkVersionPreprocessorSymbol>
      <TargetFrameworkVersionPreprocessorSymbol Condition="$(TargetFrameworkVersion) == 'v4.6'">NET46</TargetFrameworkVersionPreprocessorSymbol>
      <TargetFrameworkVersionPreprocessorSymbol Condition="$(TargetFrameworkVersion) == 'v4.5.2'">NET452</TargetFrameworkVersionPreprocessorSymbol>
      <TargetFrameworkVersionPreprocessorSymbol Condition="$(TargetFrameworkVersion) == 'v4.5.1'">NET451</TargetFrameworkVersionPreprocessorSymbol>
      <TargetFrameworkVersionPreprocessorSymbol Condition="$(TargetFrameworkVersion) == 'v4.5'">NET45</TargetFrameworkVersionPreprocessorSymbol>
      <TargetFrameworkVersionPreprocessorSymbol Condition="$(TargetFrameworkVersion) == 'v4.0'">NET40</TargetFrameworkVersionPreprocessorSymbol>
      <TargetFrameworkVersionPreprocessorSymbol Condition="$(TargetFrameworkVersion) == 'v3.5'">NET35</TargetFrameworkVersionPreprocessorSymbol>
      <TargetFrameworkVersionPreprocessorSymbol Condition="$(TargetFrameworkVersion) == 'v3.0'">NET30</TargetFrameworkVersionPreprocessorSymbol>
      <TargetFrameworkVersionPreprocessorSymbol Condition="$(TargetFrameworkVersion) == 'v2.0'">NET20</TargetFrameworkVersionPreprocessorSymbol>
      <TargetFrameworkVersionPreprocessorSymbol Condition="$(TargetFrameworkVersion) == 'v1.1'">NET11</TargetFrameworkVersionPreprocessorSymbol>
    </PropertyGroup>
    <Message Condition="$(TargetFrameworkVersionPreprocessorSymbol) != ''" Text="Add of predecessor symbols 'NETFRAMEWORK' and '$(TargetFrameworkVersionPreprocessorSymbol)' for target Framework.NET version $(TargetFrameworkVersion) ..." Importance="high"/>
    <Message Condition="$(TargetFrameworkVersionPreprocessorSymbol) != ''" Text="DefineConstants before: $(DefineConstants)" Importance="high"/>
    <PropertyGroup>
      <DefineConstants Condition="$(TargetFrameworkVersionPreprocessorSymbol) != ''">$(DefineConstants);NETFRAMEWORK;$(TargetFrameworkVersionPreprocessorSymbol)</DefineConstants>
    </PropertyGroup>
    <Message Condition="$(TargetFrameworkVersionPreprocessorSymbol) != ''" Text="DefineConstants after:  $(DefineConstants)" Importance="high"/>
  </Target>
</Project>
```

This target can be downloaded from [here](NET.SphereSoft.TargetFrameworkVersionPreprocessorSymbols.target).



## [Integrate MS Build target in project](#)

To integrate the target into your project build, you must place it somewhere into
your project folder. We recommend under the sub folder `Properties`.

Then add the target with an `Import` XML element into your project file:

```xml
<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <!-- ... -->
  <Import Project="Properties\NET.SphereSoft.TargetFrameworkVersionPreprocessorSymbols.target" Condition="Exists('Properties\NET.SphereSoft.TargetFrameworkVersionPreprocessorSymbols.target')" />
</Project>
```



## [Messages during build process](#)

```
Add of preprocessor symbols 'NETFRAMEWORK' and 'NET471' for target Framework.NET version v4.7.1 ...
DefineConstants before: DEBUG;TRACE
DefineConstants after:  DEBUG;TRACE;NETFRAMEWORK;NET471
```



## [Target Framework.NET versions and related Preprocessor symbols](#)

This follows the `MSBuild` together with the `Project SDK`, see also:  
https://learn.microsoft.com/en-us/dotnet/standard/frameworks#preprocessor-symbols

| TargetFrameworkVersion | TargetFrameworkVersionPreprocessorSymbol | DefineConstants |
| --- | --- | --- |
| v4.8   | NET48  | NETFRAMEWORK;NET48  |
| v4.7.1 | NET471 | NETFRAMEWORK;NET471 |
| v4.7   | NET47  | NETFRAMEWORK;NET47  |
| v4.6.2 | NET462 | NETFRAMEWORK;NET462 |
| v4.6.1 | NET461 | NETFRAMEWORK;NET461 |
| v4.6   | NET46  | NETFRAMEWORK;NET46  |
| v4.5.2 | NET452 | NETFRAMEWORK;NET452 |
| v4.5.1 | NET451 | NETFRAMEWORK;NET451 |
| v4.5   | NET45  | NETFRAMEWORK;NET45  |
| v4.0   | NET40  | NETFRAMEWORK;NET40  |
| v3.5   | NET35  | NETFRAMEWORK;NET35  |
| v3.0   | NET30  | NETFRAMEWORK;NET30  |
| v2.0   | NET20  | NETFRAMEWORK;NET20  |
| v1.1   | NET11  | NETFRAMEWORK;NET11  |



<!-- FOOTER -->
<hr style="height: 1px" />
<a href="http://spheresoft.net" style="font-size: 0.7em; float: right">spheresoft.net</a>
