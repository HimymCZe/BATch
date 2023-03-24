	@echo off
	@setlocal enabledelayedexpansion

	echo.
	echo.
	echo.

rem	example:= D:\WTRV\xnapy_darky2_841876259_2021.01.11_08.33.23.mkv
rem	example:= 20503 // sekundy:= duration


	set output=%2
		if NOT DEFINED output set output=C:\WTRV\.AVC
rem	echo !input! !quality! !quality::=.! !output!
	
	set "startTime=!time: =0!" & set "start=!startTime:%time:~8,1%=%%100)*100+1!"
for /F %%f in ("%1") do (
	echo %%~nf !output!
	echo.
	md !output!\%%~nf
echo	md !output!\%%~nf
echo	----------------------------------------  -re deleted ----------------------------------------
	ffmpeg -i %1 -c copy -f segment -segment_time 50 -reset_timestamps 1 !output!\%%~nf\Split.%%06d.mkv -y
)
	set "endTime=!time: =0!" & set "end=!endTime:%time:~8,1%=%%100)*100+1!"

	REM GET ELAPSED TIME:
	REM --------------------------------------------------------------------------------
	set /A "elap=((((10!end:%time:~2,1%=%%100)*60+1!%%100)-((((10!start:%time:~2,1%=%%100)*60+1!%%100), elap-=(elap>>31)*24*60*60*100"

	REM CONVERT ELAPSED TIME TO HH:MM:SS:CC FORMAT:
	REM --------------------------------------------------------------------------------
	set /A "cc=elap%%100+100,elap/=100,ss=elap%%60+100,elap/=60,mm=elap%%60+100,hh=elap/60+100"

	echo --------------------------------------------------------------------------------
	echo Start:    !startTime!
	echo End:      !endTime!
	echo		- -- -- -- -- -
	echo Elapsed:  !hh:~1!:!mm:~1!:!ss:~1!,!cc:~1!
rem	echo.

	timeout /t 99
	exit