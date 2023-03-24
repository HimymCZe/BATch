cls
echo.
	@echo off
	@setlocal enabledelayedexpansion
	@set Opath=D:\B\
	@set Wpath=C:\WTRV\
	@set /P name="Enter file name: "
	@set Npath="C:\Downloads\StaxRip-x64-2.1.3.0-stable\Apps\Encoders\NVEnc\NVEncC64.exe"

	@set quality=30:32:34

rem	@set name=%name:~0,199%

	@SET DT=!date:~6,4!.!date:~3,2!.!date:~0,2!_!time:~0,2!.!time:~3,2!.!time:~6,2!
	@echo !DT: =0!

echo.
echo %Npath%
echo "%Opath%%name%"
echo "%Wpath%%name%"
set /P _startat="All correct? (1: Yes): "
echo.
if !_startat!==1 (
	%Npath% -i "%Opath%%name%" --cqp %quality% --codec h265 --preset quality --aq --aq-temporal --bframes 5 --ref 16 -f --audio-copy -o "%Wpath%%name%"
)

	@msg %username% "AnyOnce has finished downloading %name%."
	@timeout -1