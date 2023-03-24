	@echo off
	@setlocal enabledelayedexpansion
	@color 70
	@mode 120,15

	set input=%1
	set last=!input:~-1,1!
	echo !last!
	if !last!==\ set input=!input:~0,-1!
rem	echo !input!

rem	set output=%2
rem	set last=!output:~-1,1!
rem	echo !last!
rem	if !last!==\ set output=!output:~0,-1!
rem	echo !output!

rem	set quality=%2
rem	echo !quality!
		if NOT DEFINED quality set quality=30:31:32

set countFULL=0
set count=0

for /F %%C in ('dir /S /B /A-D "%1"') do (
	set /A countFULL+=1
)

echo --------------------------------------------------------------------------------
for %%F in ("!input!") do (
	set output=C:\WTRV\.HEVC
	md "!output!\%%~nxF"
rem	(echo %%F & echo %%~nxF & echo !output!)

		set "SstartTime=!time: =0!" & set "Sstart=!SstartTime:%time:~8,1%=%%100)*100+1!"
		for /F %%E in ('dir /S /B /A-D "!input!"') do (
			set /A count+=1
			set /A mod=count%%2
				if !mod!==1 (

			set "startTime=!time: =0!" & set "start=!startTime:%time:~8,1%=%%100)*100+1!"

				@C:\Users\asdf\Desktop\BBC\ffmpeg_leden.unor.2020.exe -v quiet -stats -i %%E -filter_complex "[0:v]setpts=0.25*PTS[v];[0:a]atempo=4.0[a]" -map "[v]" -map "[a]" -s 1280x720 -r 60 -c:v nvenc -rc constqp !output!\%%~nxF\%%~nE.mkv

			set "endTime=!time: =0!" & set "end=!endTime:%time:~8,1%=%%100)*100+1!"

			for /F %%G in ('returnbitrate "!output!\%%~nxF\HEVC.%%~nxE"') do set oBR=%%G
				if oBR GEQ 0 (
rem					echo oBR {!oBR!} G.E.Q. 0
					ren "!output!\%%~nxF\HEVC.%%~nxE" "HEVC.%%~nE_!quality::=.!_!oBR!_new%%~xE"
				)

			REM GET ELAPSED TIME:
			REM --------------------------------------------------------------------------------
			set /A "Felap=((((10!end:%time:~2,1%=%%100)*60+1!%%100)-((((10!Sstart:%time:~2,1%=%%100)*60+1!%%100), Felap-=(Felap>>31)*24*60*60*100"
			set /A "elap=((((10!end:%time:~2,1%=%%100)*60+1!%%100)-((((10!start:%time:~2,1%=%%100)*60+1!%%100), elap-=(elap>>31)*24*60*60*100"
			set /A "ETA=(felap*(countFULL-count))/(count+1)"

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
	C:\DownLoads\sounder.exe "C:\Windows\Media\Speech On.wav"
	timeout /T 90
	exit