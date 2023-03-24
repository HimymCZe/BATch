	@echo off
	@setlocal enabledelayedexpansion
	@set name=%1
	@set quality=%2

@for /l %%n in () do (
	@SET DT=!date:~6,4!.!date:~3,2!.!date:~0,2!_!time:~0,2!.!time:~3,2!.!time:~6,2!
	@SET DT=!DT: =0!
	echo !DT!

	streamlink --twitch-disable-hosting --retry-streams 90 twitch.tv/%name%

	@SET DT=!date:~6,4!.!date:~3,2!.!date:~0,2!_!time:~0,2!.!time:~3,2!.!time:~6,2!
	@SET DT=!DT: =0!
	echo !DT!

	streamlink --twitch-disable-hosting --twitch-disable-ads --hls-live-restart --stream-sorting-excludes "<720p" -o C:\WTRV\%name%_!DT!.mp4 twitch.tv/%name% %quality%
	if EXIST C:\WTRV\%name%_!DT!.mp4 "c:\Users\asdf\OneDrive\Desktop\mkvtoolnix (old)\mkvmerge.exe" -o D:\WTRV\%name%_!DT!.mkv C:\WTRV\%name%_!DT!.mp4

	for /F %%f in ('filesize C:\WTRV\%name%_!DT!.mp4') do set filesizetestC=%%f
	for /F %%f in ('filesize D:\WTRV\%name%_!DT!.mkv') do set filesizetestD=%%f
	if NOT filesizetestD==0 del C:\WTRV\%name%_!DT!.mp4

	echo !filesizetestC! !filesizetestD!
	echo.
)