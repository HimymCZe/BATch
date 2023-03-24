	@echo off
	@setlocal enabledelayedexpansion
	set /p name="YouTube LINK here => "

for /l %%n in (1,1,40) do (
	set char=!name:~0,1!
REM	echo !char! !name:~0,1! !name:~1,1! !name:~0,12!
	if /I NOT !char!=== set name=!name:~1,99!
REM	if /I !char!=== set /A n=40
)

REM streamlink -o !name:~0,12!.mp4 youtube.com/watch?v!name:~0,12! best
REM	timeout /t 5