	@echo off
	@setlocal enabledelayedexpansion

cls

for /F "delims=" %%e in ('dir /B /A-D C:\wtrv\') do (
rem	set a=!random!
rem	set b=!a:~,-1!
rem	echo !a! !b! 

	for /F %%f in ('filesize "C:\WTRV\%%e"') do set fsC=%%f
	set /A fsCD=!fsC:~,-3!/!fsC:~,-6!
	echo %%e !fsC:~,-6! !fsC:~,-3! !fsCD!
)