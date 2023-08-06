@echo off

rem <summary>
rem Tortoise GIT enhancement batch (merge file name in middle tab)
rem <summary>
rem <revisionHistory>
rem   <revision version="2023.06.23" date="2023-06-23" author="Holger Boskugel, github.com/SphereSoftNET">Initial implementation</revision>
rem </revisionHistory>


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
