	@setlocal enabledelayedexpansion
	@echo off

	set count=0
	set input=%1
		if NOT DEFINED !input! set /P input="Enter input number: "


	echo %ree%\*%input%.mkv
		for %%f in (%ree%\*split*!input!.mkv) do (
			set /A count+=1
rem			echo %%f║nonew
			set newInput=%%f
			set newInput=!newInput:~0,-4!
		)
		for %%f in (%ree%\*split*!input!_new.mkv) do (
			set /A count+=1
rem			echo %%f║new
			set newInput=%%f
			set newInput=!newInput:~0,-8!
		)
		if !count!==0 echo SomeTingWong (!count!) !input!. & goto:eof
		if !count! GEQ 2 echo There are too many (!count!) !input!. & goto:eof

	echo !newInput!

echo	--------------------------------------------------------------------------------

rem	CHOICE /T 90 /C 01 /D 0 /M "F-seg !input!? (1:YES)"
rem	IF NOT !ERRORLEVEL! EQU 02 goto:eof

		for %%f in (%ree%\*split*!input!.mkv) do (
			echo ffmpeg -v quiet -stats
			echo 	-i %%f -c copy -f segment -reset_timestamps 1
			echo 		!newInput!.%%06d.mkv
echo	--------------------------------------------------------------------------------
			ffmpeg -v quiet -stats -i %%f -c copy -f segment -reset_timestamps 1 !newInput!.%%06d.mkv
		)
		for %%f in (%ree%\*split*!input!_new.mkv) do (
			echo ffmpeg -v quiet -stats
			echo 	-i %%f -c copy -f segment -reset_timestamps 1
			echo 		!newInput!.%%06d_new.mkv
echo	--------------------------------------------------------------------------------
			ffmpeg -v quiet -stats -i %%f -c copy -f segment -reset_timestamps 1 !newInput!.%%06d_new.mkv
		)
		echo.
		:eof