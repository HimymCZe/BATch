	@echo off
	@setlocal enabledelayedexpansion

set file=%1
set maxbytesize=1000

FOR /F "usebackq" %%A IN ('%file%') DO echo %%~zA