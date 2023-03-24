	@echo off
	@setlocal enabledelayedexpansion

cls
set duplicite=
for /F "tokens=1-3 delims=.'" %%a in ('dir /B /A-D *.rar') do (
rem	echo %%a
	if /I NOT !DUPLICITE!==%%a echo %%a	%%b	%%c
	set duplicite=%%a
	)