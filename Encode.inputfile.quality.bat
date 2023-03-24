	@echo off
	@setlocal enabledelayedexpansion

@SET startDT=!date:~6,4!.!date:~3,2!.!date:~0,2!_!time:~0,2!.!time:~3,2!.!time:~6,2!
@SET startDT=!startDT: =0!
echo !startDT!

rem	echo %1 %2
rem	echo "C:\WTRV\%~n1_!startDT!%~x1"

	set input=%1
	set quality=%2
rem		echo !quality!

rem	set /P entry="Enter file: "
rem	set /P quality="Enter quality in format "30:31:32": "
		if NOT DEFINED quality set quality=30:31:32
	echo !input! !quality! !quality::=.!

rem	for %%i in ("%1") do ()
rem	echo %%i %%~nxi
	C:\Downloads\StaxRip-x64-2.1.3.0-stable\Apps\Encoders\NVEnc\NVEncC64.exe -i !input! --cqp !quality! --codec h265 --preset quality --aq --aq-temporal --bframes 5 --ref 16 -f --audio-copy -o "C:\WTRV\%~n1_CQP.!quality::=.!_!startDT!%~x1"

	echo.
	echo.
	echo.