	@echo off
	@setlocal enabledelayedexpansion

rem		robocopy c:\WTRV\.AVC\Travelyan_2021.02.20_19.06.28\ c:\WTRV\.AVC\Travelyan_TEST\ /CREATE /E
rem		cd /D c:\WTRV\.AVC\Travelyan_TEST

rem		for /R c:\WTRV\.AVC\Travelyan_2021.02.20_19.06.28\ %%f in (*log *_new.mkv) do (
rem			set testfilepath=%%f
rem	rem		echo !testfilepath!
rem	rem		echo !testfilepath:~0,23!TEST!testfilepath:~42,60!
rem			copy /Y !testfilepath! !testfilepath:~0,23!TEST!testfilepath:~42,60!
rem		)

rem	cls
	color 7D
	set input=%1
		cd /D %1
	set output=C:\WTRV
	for %%f in (!input!) do set inputfoldername=%%~nxf & set inputfoldername=!inputfoldername: =_!
		set last=!inputfoldername:~-1,1!
rem		echo !last!
		if !last!==_ set inputfoldername=!inputfoldername:~0,-1!
	echo !input! 
	echo !inputfoldername!
	echo !output!
	echo !inputfoldername!___HEVC.Splits.CPU.CRF26.600___HEVC.Splits.NvEnc.30.32.34.600
echo --------------------------------------------------------------------------------
echo	0:EXIT
echo	1:HEVC.Splits.CPU.CRF26.600
echo	2:HEVC.Splits.NvEnc.30.32.34.600
echo	4:HEVC.Splits.NvEnc.30.34.38.600
echo	6:HEVC.Splits.NvEnc.30.36.42.600
echo	8:HEVC.Splits.NvEnc.MiXeD.600
echo		A:UnEncoded.AVC.Source
echo			D:HEVC.Splits.NvEnc.360p
echo			U:HEVC.Splits.360p.CRF26.600
echo			5:HEVC.Splits.NvEnc.540p

if 0==1 (
CHOICE /N /C 12468ADU50 /M "Continue?: "
	IF !ERRORLEVEL! EQU 10 color 70 & goto :eof
	IF !ERRORLEVEL! EQU  9 color 70 & set HEVC.Splits=HEVC.Splits.NvEnc.540p
	IF !ERRORLEVEL! EQU  8 color 70 & set HEVC.Splits=HEVC.Splits.360p.CRF26.600
	IF !ERRORLEVEL! EQU 07 color 70 & set HEVC.Splits=HEVC.Splits.NvEnc.360p
	IF !ERRORLEVEL! EQU 06 color 70 & set HEVC.Splits=UnEncoded.AVC.Source
	IF !ERRORLEVEL! EQU 05 color 70 & set HEVC.Splits=HEVC.Splits.NvEnc.MiXeD.600
	IF !ERRORLEVEL! EQU 04 color 70 & set HEVC.Splits=HEVC.Splits.NvEnc.30.36.42.600
	IF !ERRORLEVEL! EQU 03 color 70 & set HEVC.Splits=HEVC.Splits.NvEnc.30.34.38.600
	IF !ERRORLEVEL! EQU 02 color 70 & set HEVC.Splits=HEVC.Splits.NvEnc.30.32.34.600
	IF !ERRORLEVEL! EQU 01 color 70 & set HEVC.Splits=HEVC.Splits.CPU.CRF26.600
)
color 70 & set HEVC.Splits=HEVC.Splits.NvEnc.360p

echo --------------------------------- MOVING  LOGS ---------------------------------

	for /R %%f in (*log) do (
		move %%f !input!\%%~nxf >nul
	)
rem	timeout /T -1

echo -------------------------------- DELETING TEMPs --------------------------------

	for /R %%f in (*m4a *txt *avs *ffindex *srip *flac *txt *hevc *h265 *opus) do (
rem		echo deleting... "%%f"
		del "%%f"
	)
rem	timeout /T -1

echo -------------------------- REMOVING EMPTY DIRECTORIES --------------------------

	for /f "delims=" %%d in ('dir /s /b /ad ^| sort /r') do (
rem		echo rd "%%d"
		rd "%%d"
	)
rem	timeout /T -1

echo ------------------------- CREATING  Avg QP LOG and RAR -------------------------
echo --------------------------------------------------------------------------------

	for %%f in (*log) do (
		echo %%f
		type %%f | find "frame type I"
		type %%f | find "frame type P"
		type %%f | find "frame type B"
		type %%f | find "frame I"
		type %%f | find "frame P"
		type %%f | find "frame B"
		type %%f | find "encoded"
		type %%f | find "encode time"
rem		type %%f | find "Avg QP"
		echo,
	)>>log.log
rem	timeout /T -1
	"C:\Program Files\WinRAR\Rar.exe" m -m0 !output!\!inputfoldername!___!HEVC.Splits!.log.rar *log

echo --------------------------------- MERGER START ---------------------------------

	set count=-1
	for /F %%f in ('dir /S /B /A-D !input!\*_new.mkv') do (
		set /A count+=1
	)
	set /A centcount=!count!/100
rem	echo !centcount! !count!

echo --------------------------------------------------------------------------------

CD /D !input!
for /L %%n in (0,1,!centcount!) do (
	for %%f in (!input!\*split.000%%n*_new.mkv) do (
		set line=!line! +"%%~nxf"
	)
rem	echo %%n !line!
		"c:\Users\asdf\OneDrive\Desktop\mkvtoolnix (old)\mkvmerge.exe" -o "!output!\!inputfoldername!___Output.000%%n00.mkv" !line:~2!
	set line=
)

echo --------------------------------------------------------------------------------

CD /D !output!
	if !centcount! GEQ 1 (
		for %%f in (!output!\!inputfoldername!___Output*.mkv) do (
			set line=!line! +"%%~nxf"
		)
rem			echo FINAL.MERGE !line!
				"c:\Users\asdf\OneDrive\Desktop\mkvtoolnix (old)\mkvmerge.exe" -o "!output!\!inputfoldername!___!HEVC.Splits!.mkv" !line:~2!
	)
	if !centcount! == 0 ren !output!\!inputfoldername!___Output.000000.mkv !inputfoldername!___!HEVC.Splits!.mkv

echo -------------------------------- FINAL CLEAN UP --------------------------------

for /L %%n in (0,1,!centcount!) do (
	echo deleting... "!output!\!inputfoldername!___Output.000%%n00.mkv"
	del "!output!\!inputfoldername!___Output.000%%n00.mkv"
)

echo --------------------------------------------------------------------------------

if 0==1 (
rem	msg %username% Encoding !input! DONE.
		start /B C:\DownLoads\sounder.exe C:\Windows\Media\tada.wav

	CHOICE /T 90 /C 10 /D 0 /M "EXIT? (0:EXIT) (1:Continue)"
	IF !ERRORLEVEL! EQU 02 exit
)
timeout /T 5
:oef