	@echo off
	@setlocal enabledelayedexpansion

	cls

	set input=%1
	if NOT exist !input! set /P input="Set Folder: "
	set last=!input:~-1,1!
rem	echo !last!
	if !last!==\ set input=!input:~0,-1!
rem	echo !input!
	
	set TOTAL=0
	set "startTime=!time: =0!" & set "start=!startTime:%time:~8,1%=%%100)*100+1!"
for %%f in ("!input!"\*%%*) do (
	set /A TOTAL+=1
	set FullFule=%%f
	set File=%%~nxf
	set n==20

	for /L %%n in (20,1,120) do (
		set Letter=!File:~%%n,1!
rem		echo !Letter!
		if !Letter! == %% set FileLetter=%%n
	)
	set /A MinusThree=!FileLetter!-3
	set /A PlusOne=!FileLetter!+1
	for /L %%n in (!MinusThree!,1,!MinusThree!) do set Zacatek=!File:~0,%%n!
	for /L %%n in (!PlusOne!,1,!PlusOne!) do set Konec=!File:~%%n,100!
	echo %%~nxf ==^> !TOTAL!
	echo !Zacatek!!Konec!
	ECHO --------------------------------------------------------------------------------
)

	set /P cntn="Rename all this? (1:YES): "
		if NOT !cntn! EQU 1 echo !cntn! & exit /B

for %%f in ("!input!"\*%%*) do (
	set FullFule=%%f
	set File=%%~nxf
	set n==20

	for /L %%n in (20,1,120) do (
		set Letter=!File:~%%n,1!
rem		echo !Letter!
		if !Letter! == %% set FileLetter=%%n
	)
	set /A MinusThree=!FileLetter!-3
	set /A PlusOne=!FileLetter!+1
	for /L %%n in (!MinusThree!,1,!MinusThree!) do set Zacatek=!File:~0,%%n!
	for /L %%n in (!PlusOne!,1,!PlusOne!) do set Konec=!File:~%%n,100!
	ren %%f !Zacatek!!Konec!
)
	REM --------------------------------------------------------------------------------
	set "endTime=!time: =0!" & set "end=!endTime:%time:~8,1%=%%100)*100+1!"

	REM GET ELAPSED TIME:
	REM --------------------------------------------------------------------------------
	set /A "elap=((((10!end:%time:~2,1%=%%100)*60+1!%%100)-((((10!start:%time:~2,1%=%%100)*60+1!%%100), elap-=(elap>>31)*24*60*60*100"

	REM CONVERT ELAPSED TIME TO HH:MM:SS:CC FORMAT:
	REM --------------------------------------------------------------------------------
	set /A "cc=elap%%100+100,elap/=100,ss=elap%%60+100,elap/=60,mm=elap%%60+100,hh=elap/60+100"

	ECHO --------------------------------------------------------------------------------
	echo Start:    !startTime!
	echo End:      !endTime!
	echo		- -- -- -- -- -
	echo Elapsed:  !hh:~1!:!mm:~1!:!ss:~1!,!cc:~1!
rem	echo.
	
rem	timeout /t 99
rem	exit