	@echo off
	@setlocal enabledelayedexpansion
	@set delay=90

if "%~1"=="" (
	@set /P name="Enter stream NAME: "
	@set /P quality="Available streams: audio_only, 160p, 360p, 480p, 720p (worst), 720p60, 1080p60 (best): "
) ELSE (
	if "%~2"=="" (
		@set name=%1
		@set /P quality="Available streams: audio_only, 160p, 360p, 480p, 720p (worst), 720p60, 1080p60 (best): "
	) ELSE (
		@set name=%1
		@set quality=%2
	)
)

@for /l %%n in (1,1,1) do (
	@SET DT=!date:~6,4!.!date:~3,2!.!date:~0,2!_!time:~0,2!.!time:~3,2!.!time:~6,2!
	@SET DT=!DT: =0!
	echo !DT!

	streamlink --twitch-disable-hosting --retry-streams !delay! twitch.tv/%name%

	@SET DT=!date:~6,4!.!date:~3,2!.!date:~0,2!_!time:~0,2!.!time:~3,2!.!time:~6,2!
	@SET DT=!DT: =0!
	echo !DT!
	msg %username% "%name%_!DT! is ON."

	streamlink --twitch-disable-hosting --twitch-disable-ads --hls-live-restart --stream-sorting-excludes "<720p" -o C:\WTRV\%name%_!DT!.mp4 twitch.tv/%name% %quality%

	if EXIST C:\WTRV\%name%_!DT!.mp4 "c:\Users\asdf\OneDrive\Desktop\mkvtoolnix (old)\mkvmerge.exe" -o D:\WTRV\%name%_!DT!.mkv C:\WTRV\%name%_!DT!.mp4

	for /F %%f in ('filesize C:\WTRV\%name%_!DT!.mp4') do set fsC=%%f
	for /F %%f in ('filesize D:\WTRV\%name%_!DT!.mkv') do set fsD=%%f
	if EXIST D:\WTRV\%name%_!DT!.mkv (
		set fsCD=0 &if !fsC! GEQ 999888 set /A fsCD=!fsD:~,-4!/!fsC:~,-6!
rem		echo !fsCD!
		if !fsCD! GEQ 90 (
rem			echo !fsCD! GEQ 90
			ren D:\WTRV\%name%_!DT!.mkv %name%_!DT!_!fsCD!%%.mkv
			del C:\WTRV\%name%_!DT!.mp4
		) ELSE (
rem			echo !fsCD! GEQ 90 ... NOT
		)
	)

	if EXIST D:\WTRV\%name%_!DT!.mkv echo D:\WTRV\%name%_!DT!.mkv !fsC! !fsD! !fsCD!
	if EXIST D:\WTRV\%name%_!DT!_!fsCD!%%.mkv echo D:\WTRV\%name%_!DT!_!fsCD!%%.mkv !fsC! !fsD! !fsCD!
	echo.
)