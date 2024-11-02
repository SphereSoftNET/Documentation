| [Index](../index.md) | [GITLab](../GITLab.md) |

<hr style="height: 1px" />



## Runing a mcr.microsoft.com/powershell:lts-nanoserver-1809 in GITLab Docker runner with shell powershell

When you have a Gitlab Windows Docker runner with `shell` `powershell`
configured, then your are not directly able to run images which contain the
newer powershell `pwsh`.

Here is a hack to make a `powershell` available by creating a symbolic link
to `pwsh` at container startup:

```yaml
.nanoServerPowershell:
  image:
    name: mcr.microsoft.com/powershell:lts-nanoserver-1809
    docker:
      user: ContainerAdministrator # Required to create the symbolic link
    entrypoint:
      - "pwsh"
      - "-Command"
      # ";" at end of pwsh command required!
      - 'New-Item "$($Env:ProgramFiles)/Powershell/powershell.exe" -ItemType SymbolicLink -Target "$($Env:ProgramFiles)/Powershell/pwsh.exe" | Out-Null;'
```



<!-- FOOTER -->
<hr style="height: 1px" />
<span style="font-size: 0.7em">© SphereSoft.NET, Holger Boskugel, Berlin, Germany</span>
<a href="http://spheresoft.net" style="font-size: 0.7em; float: right">spheresoft.net</a>
