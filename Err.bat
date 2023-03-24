	@echo off
	@setlocal enabledelayedexpansion
	@color 70
rem	@mode 100,30
	@cls

	set inputNumber=%1
		if NOT EXIST !inputNumber! set /P inputNumber="Enter input number: "

	CHOICE /T 90 /C 01 /D 0 /M "Repair Error %cd%\Split.000!inputNumber!? (1:YES)"
	IF NOT !ERRORLEVEL! EQU 02 goto:eof


for %%C in (%cd%) do (
	set folderName=%%~nxC
	echo %%~nxC
)

echo -------------------------------- DELETING TEMPs --------------------------------
	IF EXIST %cd%\Split.000!inputNumber!_temp (
		cd %cd%\Split.000!inputNumber!_temp
		) ELSE (
		echo m-d-ing %cd%\Split.000!inputNumber!_temp
		md %cd%\Split.000!inputNumber!_temp
		cd %cd%\Split.000!inputNumber!_temp
		)
	for /R %%f in (*m4a *txt *avs *ffindex *srip *flac *txt *hevc) do (
		echo deleting... "%%f"
		del "%%f"
	)
	cd..
rem	timeout /T -1
echo ----------------------------- Eac3to Audio Encoding ----------------------------
	C:\Downloads\StaxRip-x64-2.1.3.0-stable\Apps\Audio\eac3to\eac3to.exe "%cd%\Split.000!inputNumber!.mkv" "%cd%\Split.000!inputNumber!_temp\Split.000!inputNumber! ID1_a1.m4a" -quality=0.35
echo -------------------------------- Moving Orignal --------------------------------
	move %cd%\Split.000!inputNumber!.mkv C:\WTRV\!folderName!_Split.000!inputNumber!_ORG.mkv
echo ------------------------------ Muxing in SoundLess -----------------------------
	"C:\Users\asdf\OneDrive\Desktop\mkvtoolnix (old)\mkvmerge.exe" -A -S -B -M -T --no-global-tags -o %cd%\Split.000!inputNumber!.mkv C:\WTRV\!folderName!_Split.000!inputNumber!_ORG.mkv
echo --------------------------------------------------------------------------------
rem	msg %username% Encoding !input! DONE.
rem	C:\DownLoads\sounder.exe "C:\Windows\Media\TaDa.wav"

:preeof
	CHOICE /T 90 /C 01 /D 0 /M "Cancel EXIT? (1:YES)"
	IF !ERRORLEVEL! EQU 02 goto:eof
	exit
:eof