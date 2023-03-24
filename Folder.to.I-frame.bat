	@echo off
	@setlocal enabledelayedexpansion

	set input=%1
	set last=!input:~-1,1!
rem	echo !last!
	if !last!==\ set input=!input:~0,-1!
rem	echo !input!

for %%f in (!input!\*) do set /A TOTAL+=1

for %%f in (!input!\*) do (

	@SET DT=!date:~6,4!.!date:~3,2!.!date:~0,2!_!time:~0,2!.!time:~3,2!.!time:~6,2!
	@SET DT=!DT: =0!
rem	@echo !DT!

	set /A count+=1
	echo 	!count!/!TOTAL!	!DT!	%%~nf
	IF NOT EXIST C:\WTRV\.HEVC\%%~nf md C:\WTRV\.HEVC\%%~nf
rem	echo frame=  210 fps=8.4 q=2.0 Lsize=N/A time=00:30:49.51 bitrate=N/A speed=73.9x
	C:\Users\asdf\Desktop\BBC\ffmpeg_leden.unor.2020.exe -v quiet -stats -i %%f -q:v 2 -vf select="eq(pict_type\,PICT_TYPE_I)" -vsync 0 C:\WTRV\.HEVC\%%~nf\frame%%06d.jpg
	echo.
)