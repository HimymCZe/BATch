	@echo off
	@setlocal enabledelayedexpansion

rem	echo.
rem	echo.
rem	echo.

rem	example:= D:\WTRV\xnapy_darky2_841876259_2021.01.11_08.33.23.mkv
rem	example:= 20503 // sekundy:= duration

	set count=0
	set input=%1
		if NOT DEFINED input set /P input="Input?: "
		for /F %%f in ('dir /S /B /A-D Y:\WTRV\*!input!*') do (
			set /A count+=1
			set newInput=%%f
		)
		if !count!==1 set input=!newInput!	
		if !count! GEQ 2 echo There are too many (!count!) !input!. & goto:eof
rem	set last=!input:~-1,1!
rem	echo !last!
rem	if !last!==\ set input=!input:~0,-1!
rem	echo !input!

rem	set output=%2
		if NOT DEFINED output set output=C:\WTRV\.AVC
rem	echo !input! !quality! !quality::=.! !output!

	set /A TimeOutTime=0-1
	set input2=%2
		if DEFINED input2 if /I !input2! GEQ 0 set /A TimeOutTime+=!input2!
	
	set "startTime=!time: =0!" & set "start=!startTime:%time:~8,1%=%%100)*100+1!"


for /F %%f in ("!input!") do (
	echo --------------------------------------------------------------------------------
	echo %%~nf !output! !input2! !TimeOutTime!
	echo --------------------------------------------------------------------------------
rem	echo.
	md !output!\%%~nf
echo	md !output!\%%~nf
echo	----------------------------------------  -re deleted ----------------------------------------
	ffmpeg -v quiet -stats -i %%f -c copy -f segment -segment_time 600 -reset_timestamps 1 !output!\%%~nf\Split.%%06d.mkv -y

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

	echo --------------------------------------------------------------------------------
rem	echo.

	C:\DownLoads\sounder.exe C:\Windows\Media\tada.wav
rem	CHOICE /T 90 /C 10 /D 0 /M "Run Again? (1:YES)"
rem	IF !ERRORLEVEL! EQU 01 Split.Into.FEW.Pieces.bat
)	
	timeout /t !TimeOutTime!
rem	exit
:eof