	@echo off
	@setlocal enabledelayedexpansion
	@SET DT=!date:~6,4!.!date:~3,2!.!date:~0,2!_!time:~0,2!.!time:~3,2!.!time:~6,2!

set aa=c:\Users\asdf\OneDrive\Desktop\._CLOSED\
set bb=g:\...___\
echo !DT!

for /F %%f in ('dir /B /AD !aa!') do (
	for /F %%g in ('dir /B /AD !bb!*%%f*') do (
		set gg=%%g
		set ggg=!gg:~1,18!
		set cc=!gg:~0,1!
rem		echo %%g - !gg! - !ggg! - !cc!
rem		if !cc!==^. echo DEL /S /Q "!bb!!gg!"
		if !cc!==^. DEL /S /Q "!bb!!gg!"
	)
rem	set a=%%f
rem	echo !a!
)