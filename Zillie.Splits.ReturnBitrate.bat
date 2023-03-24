	@echo off
	@setlocal enabledelayedexpansion

set input=%1

for %%f in (!input!*) do (
	set oBR=ERROR
	for /F %%G in ('returnbitrate "%%f"') do set oBR=%%G
	set F=%%~nf
	set F=!F:~,-4!
rem		if NOT !oBR!==!F! echo !oBR! !F! !F2! %%f
		echo !oBR! !F! %%f
		ren %%f HEVC.!F!_CRF26_!oBR!_new.mkv
)