	@echo off
	@setlocal enabledelayedexpansion
	@color 70
	@mode 101,30

	set input=%1
rem	set last=!input:~-1,1!
	echo !last!
	if !last!==\ set input=!input:~0,-1!
rem	echo !input!

rem	set output=%2
rem	set last=!output:~-1,1!
rem	echo !last!
rem	if !last!==\ set output=!output:~0,-1!
rem	echo !output!

	set quality=%2
rem	echo !quality!
		if NOT DEFINED quality set quality=30:32:34

set countFULL=0
set count=0
timeout /T 15

for /F %%C in ('dir /S /B /A-D "%1"') do (
	set /A countFULL+=1
)

echo --------------------------------------------------------------------------------
for /F %%F in ("!input!") do (
	set output=C:\WTRV\.HEVC
	md "!output!\%%~nxF"
rem	(echo %%F & echo %%~nxF & echo !output!)

		set "SstartTime=!time: =0!" & set "Sstart=!SstartTime:%time:~8,1%=%%100)*100+1!"
		for /F %%E in ('dir /S /B /A-D "!input!"') do (
			set /A count+=1
			set /A mod=count%%2
				if !mod!==0 (

			set "startTime=!time: =0!" & set "start=!startTime:%time:~8,1%=%%100)*100+1!"

				C:\Downloads\StaxRip-x64-2.1.3.0-stable\Apps\Encoders\NVEnc\NVEncC64.exe -i "%%E" --avhw --cqp !quality! %3 %4 %5 %6 %7 %8 --codec h265 --preset quality -f --audio-copy -o "!output!\%%~nxF\HEVC.%%~nxE"

			set "endTime=!time: =0!" & set "end=!endTime:%time:~8,1%=%%100)*100+1!"

			set oBR=ERROR
			for /F %%G in ('returnbitrate "!output!\%%~nxF\HEVC.%%~nxE"') do set oBR=%%G
rem					echo oBR {!oBR!} G.E.Q. 0
					ren "!output!\%%~nxF\HEVC.%%~nxE" "HEVC.%%~nE_!quality::=.!_!oBR!_new%%~xE"

			REM GET ELAPSED TIME:
			REM --------------------------------------------------------------------------------
			set /A "Felap=((((10!end:%time:~2,1%=%%100)*60+1!%%100)-((((10!Sstart:%time:~2,1%=%%100)*60+1!%%100), Felap-=(Felap>>31)*24*60*60*100"
			set /A "elap=((((10!end:%time:~2,1%=%%100)*60+1!%%100)-((((10!start:%time:~2,1%=%%100)*60+1!%%100), elap-=(elap>>31)*24*60*60*100"
			set /A "ETA=(felap*(countFULL-count))/count"

			REM CONVERT ELAPSED TIME TO HH:MM:SS:CC FORMAT:
			REM --------------------------------------------------------------------------------
			set /A "fcc=Felap%%100+100,Felap/=100,fss=Felap%%60+100,Felap/=60,fmm=Felap%%60+100,fhh=Felap/60+100"
			set /A "cc=elap%%100+100,elap/=100,ss=elap%%60+100,elap/=60,mm=elap%%60+100,hh=elap/60+100"
			set /A "acc=ETA%%100+100,ETA/=100,ass=ETA%%60+100,ETA/=60,amm=ETA%%60+100,ahh=ETA/60+100"

			echo --------------------------------------------------------------------------------
			echo	!count!/!countFULL!	  HEVC.!quality::=.!_%%~nE_!oBR!_new%%~xE
			echo Start:    !SstartTime!	!startTime!
			echo End:			!endTime!	 E  T  A  :
			echo		= -- -- -- -- = -- -- -- -- === -- -- -- -- =
			echo Elapsed:  !fhh:~1!:!fmm:~1!:!fss:~1!,!fcc:~1!	!hh:~1!:!mm:~1!:!ss:~1!,!cc:~1!	!ahh:~1!:!amm:~1!:!ass:~1!,!acc:~1!
rem			echo.
		))
)

echo --------------------------------------------------------------------------------
rem	msg %username% Encoding !input! DONE.
	C:\DownLoads\sounder.exe "C:\Windows\Media\Speech Off.wav"
	timeout /T 90
	exit