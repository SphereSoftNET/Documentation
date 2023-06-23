| [Index](../index.md) | [Tools](../Tools.md) |

<hr style="height: 1px" />

# Tortoise GIT

## With WinMerge
When using `WinMerge` in merge mode of `Tortoise GIT` you might be missing an
information about the current file you working on. For this you can create a
batch file and then start `WinMerge` with your informations.

The following batch file adds the name of the underlaying file for the merge in
the header of the middle pane. The call for such batch file you have to place
in the settings of `Tortoise GIT` for the `Merge Tool` as follows:
```
"<PathToYourBatchFile>\<YourBatchFileName>.bat" %theirs %base %mine %merged %tname %bname %yname
```

The content of your batch file can be like this:
```batch
@echo off

if "%7"=="" goto M_SYNTAX

set _WINMERGE_FULL_PATH=C:\Program Files (x86)\WinMerge\WinMergeU.exe
rem set _WINMERGE_FULL_PATH=C:\Program Files\WinMerge\WinMergeU.exe

rem Reduce base file name to name first (remove extension)
set _WINMERGE_FILE_NAME=%~n2

rem Reduce base file name to base name second (remove merge name)
for %%i in ("%_WINMERGE_FILE_NAME%") do set _WINMERGE_FILE_NAME=%%~ni

start "" "%_WINMERGE_FULL_PATH%" /maximize /ub /fm /wl /wr /dl "%~5" /dm "%~6 (%_WINMERGE_FILE_NAME%)" /dr "%~7" /am "%~1" "%~2" "%~3" /o "%~4"

goto M_END

:M_SYNTAX
echo Tortoise GIT configuration:
echo "%~0" %%theirs %%base %%mine %%merged %%tname %%bname %%yname
echo.
pause
echo.

:END
```


<!-- FOOTER -->
<hr style="height: 1px" />
<a href="http://spheresoft.net" style="font-size: 0.7em; float: right">spheresoft.net</a>
