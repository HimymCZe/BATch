	@echo off
	@setlocal enabledelayedexpansion
	@echo.

@SET startDT=!date:~6,4!.!date:~3,2!.!date:~0,2!_!time:~0,2!.!time:~3,2!.!time:~6,2!
@SET startDT=!startDT: =0!
echo !startDT!
echo.

chkdsk X: /F /R /X
echo.

@SET startDT=!date:~6,4!.!date:~3,2!.!date:~0,2!_!time:~0,2!.!time:~3,2!.!time:~6,2!
@SET startDT=!startDT: =0!
echo !startDT!