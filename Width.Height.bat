	@echo off
	@setlocal enabledelayedexpansion


set ME=c:\Users\asdf\OneDrive\Desktop\MediaInfo_CLI_20.09_Windows_x64\MediaInfo.exe
set input=%1

set First=1
for /F "tokens=1-2 delims=:" %%a in ('!ME! !input! -f ^| find /I "width"') do (
	if !First!==1 set Wide=%%b
	set /A First+=1
	)

set First=1
for /F "tokens=1-2 delims=:" %%a in ('!ME! !input! -f ^| find /I "height"') do (
	if !First!==1 set High=%%b
	set /A First+=1
	)


set /A Wide9=!Wide!*9
set /A High16=!High!*16
echo !Wide! !Wide9! !High! !High16! !input!