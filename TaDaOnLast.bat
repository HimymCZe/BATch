	@echo off
	@setlocal enabledelayedexpansion

	set input=%1
		if NOT DEFINED input set /P input="Set Folder: "
	set last=!input:~-1,1!
rem	echo !last!
	if !last!==\ set input=!input:~0,-1!
rem	echo !input!

for %%F in (%input%) do (
	set OnlyFolderInput=%%~nF
)

for %%F in (%input%/*) do (
	set lastfile=%%~nF
)
	set lastfileLAST=!lastfile:~-4,4!
rem	echo !lastfileLAST!
	if !lastfileLAST!==_new (
		echo !startDT! !input!\!lastfile!.mkv FOUND	
		C:\DownLoads\sounder.exe C:\Windows\Media\tada.wav
		goto:eof
	)

:recurse
	timeout /T 90>nul

	@SET startDT=!date:~6,4!.!date:~3,2!.!date:~0,2!_!time:~0,2!.!time:~3,2!.!time:~6,2!
	@SET startDT=!startDT: =0!
rem	echo !startDT!

	if exist !input!\!lastfile!_new.mkv (
		echo !startDT! !input!\!lastfile!_new.mkv FOUND
		C:\DownLoads\sounder.exe C:\Windows\Media\tada.wav
	) ELSE (
		for %%F in (%input%/*_new.mkv) do (
			set lastNEWfile=%%~nF
		)
		echo !startDT! !OnlyFolderInput! !lastNEWfile! !lastfile! :{
	)
	if NOT exist !input!\!lastfile!_new.mkv	goto:recurse
:eof