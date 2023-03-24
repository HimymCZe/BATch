	@echo off
	@setlocal enabledelayedexpansion
	@color 70
	@cls


	set _working_cd=%cd%
	cd ..
	set _upper_cd=%cd%
	cd %_working_cd%

rem	echo %_working_cd%
rem	echo %_upper_cd%

	for /F %%f in ('dir /S /B /AD') do (
		for %%g in (%%f\*english*srt) do (
			echo %%~nxg ^=^=^> %%~nxf%%~xg
			copy /Y %%g %_upper_cd%\%%~nxf%%~xg
		)
	)

	CHOICE /T 90 /C 10 /D 0 /M "EXIT? (0:EXIT) (1:Continue)"
	IF !ERRORLEVEL! EQU 02 exit
:oef