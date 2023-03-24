	@echo off
	@setlocal enabledelayedexpansion
	@cls

	set startCD=%cd%
		if NOT EXIST C:\WTRV\.HEVC md C:\WTRV\.HEVC
	cd /D C:\WTRV\.HEVC
	set input=%1
		if NOT DEFINED input set input=Z:\.A.xXx.1080p\.ReEncode
	set last=!input:~-1,1!
rem	echo !last!
	if !last!==\ set input=!input:~0,-1!
	echo !input!

echo -------------------------------- Counting TOTAL --------------------------------
	set count=0
	set TOTAL=0
	for %%f in (!input!\*.mp4 !input!\*.mkv) do set /A TOTAL+=1

echo -------------------------------- Making Iframes --------------------------------
	for %%f in (!input!\*.mp4 !input!\*.mkv) do (

		@SET DT=!date:~6,4!.!date:~3,2!.!date:~0,2!_!time:~0,2!.!time:~3,2!.!time:~6,2!
		@SET DT=!DT: =0!
rem		@echo !DT!
	
		set /A count+=1
		echo 	!count!/!TOTAL!	!DT!	%%~nf
			IF NOT EXIST C:\WTRV\.HEVC\%%~nf md C:\WTRV\.HEVC\%%~nf
rem		echo frame=  210 fps=8.4 q=2.0 Lsize=N/A time=00:30:49.51 bitrate=N/A speed=73.9x

		C:\Users\asdf\Desktop\BBC\ffmpeg_leden.unor.2020.exe -v quiet -stats -i %%f -q:v 2 -vf select="eq(pict_type\,PICT_TYPE_I)" -vsync 0 C:\WTRV\.HEVC\%%~nf\frame%%06d.jpg
		echo.
	)

echo ------------------------------ Deleting 1-9 frames -----------------------------
rem	set count=0
	for /R %%f in (frame*1.jpg frame*2.jpg frame*3.jpg frame*4.jpg frame*5.jpg frame*6.jpg frame*7.jpg frame*8.jpg frame*9.jpg) do (
rem		set /A count+=1
rem		echo 	!count!/!TOTAL!	!DT!	%%~nf
		del %%f
	)

echo ------------------------------------ RARing ------------------------------------
	set count=0
	for %%f in (!input!\*.mp4 !input!\*.mkv) do (

		@SET DT=!date:~6,4!.!date:~3,2!.!date:~0,2!_!time:~0,2!.!time:~3,2!.!time:~6,2!
		@SET DT=!DT: =0!
rem		@echo !DT!
	
		set /A count+=1
		echo 	!count!/!TOTAL!	!DT!	%%~nf
		"C:\Program Files\WinRAR\Rar.exe" a -m0 %%~nf.rar %%~nf/* >NUL
rem		echo.
	)

echo ------------ Renaming Z:\.A.xXx.1080p\.ReEncode MP4 =^> RAR and back ------------
	for %%f in (!input!\*.mp4 !input!\*.mkv) do (
		ren %%f %%~nf.rar
	)
	robocopy !input! C:\WTRV\.HEVC /COPY:AT >nul
	for %%f in (!input!\*.rar) do (
		ren %%f %%~nf.mp4
	)

echo -------------------------------- DELETE ALL ??? ---------------------------------
	C:\DownLoads\sounder.exe C:\Windows\Media\tada.wav
	CHOICE /C 10 /M "DELETE ALL ??? (1:YES)"
	IF !ERRORLEVEL! EQU 01 (
		for /R %%f in (frame*0.jpg) do del "%%f"
		for /F "delims=" %%d in ('dir /s /b /ad ^| sort /r') do rd "%%d"
		for %%f in (!input!\*.mp4) do del "%%f"
	)
	md C:\WTRV\.XXX.DELETED.rar > nul
	for %%f in (*.rar) do move %%f C:\WTRV\.XXX.DELETED.rar\%%~nxf

echo ---------------------------------- Run Again? -----------------------------------
	set runYYY=0
	CHOICE /C 1230 /M "Run Again? (0:Exit) (1:YES) (2:Continue) (3:Run yYy.bat) "
	IF !ERRORLEVEL! EQU 04 exit
	IF !ERRORLEVEL! EQU 03 set runYYY=1
	IF !ERRORLEVEL! EQU 02 goto :eof 
	IF !ERRORLEVEL! EQU 01 C:\Users\asdf\Desktop\BBC\Folder.to.I-frame_Move_Rar_Move_COMPLETE.BATCH.bat

echo --------------------------------------------------------------------------------

	if !runYYY!==1 (
		set YYYsublet=""
		set /P YYYsublet="Set yYy.bat %%f sublet: "
		call C:\Users\asdf\Desktop\BBC\yYy.bat !YYYsublet!
	)







:eof
cd /D !startCD!