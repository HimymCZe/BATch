	@echo off
	@setlocal enabledelayedexpansion

rem	cd /d "%sourcefolder%"
rem	echo %cd%	

for %%f in (%CD%) do set name=%%~nxf
set line=
for %%a in (*.mkv) do (
	set line=!line! +"%%~a"
rem	echo !line!
)

rem	echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo !line:~2!
	"c:\Users\asdf\OneDrive\Desktop\mkvtoolnix (old)\mkvmerge.exe" --generate-chapters when-appending -o "%name%.mkv" !line:~2!