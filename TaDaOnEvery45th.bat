	@echo off
	@setlocal enabledelayedexpansion

	cls

	set input=%1
	if NOT exist !input! set /P input="Set Folder: "
	set last=!input:~-1,1!
rem	echo !last!
	if !last!==\ set input=!input:~0,-1!
rem	echo !input!

for %%F in (%input%) do (
	set OnlyFolderInput=%%~nF
)

set n=45
for %%F in (%input%/*) do (
	set lastfile=%%~nF
)
set lastfilenumber=!lastfile:~9,3!

:recurse
	@SET startDT=!date:~6,4!.!date:~3,2!.!date:~0,2!_!time:~0,2!.!time:~3,2!.!time:~6,2!
	@SET startDT=!startDT: =0!
rem	echo !startDT!

	if EXIST !input!\*!n!_new.mkv (
		echo !startDT! !input!\*!n!_new.mkv FOUND
		C:\DownLoads\sounder.exe C:\Windows\Media\tada.wav
		if !n! LSS !lastfilenumber! (
rem			echo LSS
			set /A n+=45
			if !n! GTR !lastfilenumber! set n=!lastfilenumber!
			goto:recurse
		)
	) ELSE (
		for %%F in (%input%/*_new.mkv) do (
			set lastNEWfile=%%~nF
		)
rem		echo !input!\*!n!_new.mkv
		set lastNEWfilenumber=!lastNEWfile:~9,3!
		echo !startDT! !OnlyFolderInput!:   !lastNEWfilenumber! ==^> !n! !lastfile! :(
		timeout /T 90 > nul
		if /I !lastNEWfilebumber! LEQ !lastfilenumber! goto:recurse
	)