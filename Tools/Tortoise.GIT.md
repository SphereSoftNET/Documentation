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

rem Uncomment the related line when auto detection off WinMerge not works
rem set _WINMERGE_FULL_PATH=C:\Program Files\WinMerge\WinMergeU.exe
rem set _WINMERGE_FULL_PATH=C:\Program Files\WinMerge\WinMerge.exe
rem set _WINMERGE_FULL_PATH=C:\Program Files (x86)\WinMerge\WinMergeU.exe
rem set _WINMERGE_FULL_PATH=C:\Program Files (x86)\WinMerge\WinMerge.exe

rem Auto detect WinMerge executable first 32bit and then 64bit
if exist "%ProgramFiles(x86)%\WinMerge\WinMerge*.exe" for /F "delims=" %%F in ('dir "%ProgramFiles(x86)%\WinMerge\WinMerge*.exe" /B /O') do set _WINMERGE_FULL_PATH=%ProgramFiles(x86)%\WinMerge\%%F
if exist "%ProgramFiles%\WinMerge\WinMerge*.exe" for /F "delims=" %%F in ('dir "%ProgramFiles%\WinMerge\WinMerge*.exe" /B /O') do set _WINMERGE_FULL_PATH=%ProgramFiles%\WinMerge\%%F

start "" "%_WINMERGE_FULL_PATH%" /maximize /ub /fm /wl /wr /dl "%~5" /dm "%~6 (%~nx4)" /dr "%~7" /am "%~1" "%~2" "%~3" /o "%~4"

goto M_END

:M_SYNTAX
echo Tortoise GIT configuration:
echo "%~f0" %%theirs %%base %%mine %%merged %%tname %%bname %%yname
echo.
pause
echo.

:M_END
```


<!-- FOOTER -->
<hr style="height: 1px" />
<a href="http://spheresoft.net" style="font-size: 0.7em; float: right">spheresoft.net</a>
