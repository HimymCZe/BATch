	cls
	@echo off
	@setlocal enabledelayedexpansion
	@color 71

	echo.
	echo ^^!^^!^^! DOES NOT Output .log.rar file(s) ^^!^^!^^!
	echo ^^!^^!^^! DOES NOT Output .log.rar file(s) ^^!^^!^^!
	echo ^^!^^!^^! DOES NOT Output .log.rar file(s) ^^!^^!^^!
	echo.

	set input=%1
		if NOT DEFINED input set /P input="Insert input: "
	@color 70

set StartCD=%cd%
for %%e in (C:\DownLoads c:\Users\asdf\Desktop c:\Users\asdf\OneDrive C:\WTRV L: Y: Z:) do (
rem	set e=%%e
rem	echo !e! %%e
	cd /D %%e
	echo Searching %%e: 
	for /R %%f in (*!input!*) do (
		set LastSix=%%~nxf
		set LastSix=!LastSix:~-7!
		if NOT "!LastSix!" == "log.rar" (
			echo %%~nxf
			echo		%%~zf	%%~dpf
rem			echo %%~nf*%%~xf*%%~zf*%%~dpf
rem			echo.
			)
		)
	)
cd /D !StartCD!

	CHOICE /T 90 /C 01 /D 0 /M "Cancel EXIT? (1:YES)"
	IF !ERRORLEVEL! EQU 02 cmd
	exit
:eof
