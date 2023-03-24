	@echo off
	@setlocal enabledelayedexpansion

rem	echo %*
set inputcounter=0
for /F "tokens=1-2 delims=:" %%a in ('c:\Users\asdf\OneDrive\Desktop\MediaInfo_CLI_20.09_Windows_x64\MediaInfo.exe "%*" -f ^| find "Duration"') do (
	set /A inputcounter+=1
	if !inputcounter!==1 (
rem		set a=%%a
rem		set /A nmb=%%b %% 1000
rem		echo %%b !nmb! !inputcounter!
		set /A Dur=%%b/1000
	)
)
set inputcounter=0

	echo !Dur! "%*"