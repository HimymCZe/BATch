	@echo off
	@setlocal enabledelayedexpansion

	set input=%1
		set last=!input:~-1,1!
rem		echo !last!
		if !last!==\ set input=!input:~0,-1!
	for %%f in (!input!) do set inputfoldername=%%~nxf & set inputfoldername=!inputfoldername: =_!
		set last=!inputfoldername:~-1,1!
rem		echo !last!
		if !last!==_ set inputfoldername=!inputfoldername:~0,-1!
	echo !input! 
	echo !inputfoldername!

	set output=%2
		if NOT DEFINED output set output=C:\WTRV
	set last=!output:~-1,1!
rem	echo !last!
	if !last!==\ set output=!output:~0,-1!
	echo !output!

echo --------------------------------------------------------------------------------

	set count=-1
	for /F %%f in ('dir /S /B /A-D !input!\*.mkv') do (
		set /A count+=1
	)
	set /A centcount=!count!/100
rem	echo !centcount! !count!

echo --------------------------------------------------------------------------------

CD /D !input!
for /L %%n in (0,1,!centcount!) do (
	for %%f in (!input!\*split.000%%n*.mkv) do (
		set line=!line! +"%%~nxf"
	)
rem	echo %%n !line!
		"c:\Users\asdf\OneDrive\Desktop\mkvtoolnix (old)\mkvmerge.exe" -o "!output!\!inputfoldername!_Output.000%%n00.mkv" !line:~2!
	set line=
)

echo --------------------------------------------------------------------------------

CD /D !output!
for %%f in (!output!\!inputfoldername!_Output*.mkv) do (
	set line=!line! +"%%~nxf"
)
rem	echo FINAL.MERGE !line!
		"c:\Users\asdf\OneDrive\Desktop\mkvtoolnix (old)\mkvmerge.exe" -o "!output!\!inputfoldername!.mkv" !line:~2!

echo --------------------------------------------------------------------------------
rem	msg %username% Encoding !input! DONE.