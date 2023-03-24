	@echo off
	@setlocal enabledelayedexpansion

rem	example:= D:\WTRV\xnapy_darky2_841876259_2021.01.11_08.33.23.mkv
rem	example:= 20503 // sekundy:= duration
	set /A duration=%2+50
	set count=1
	set /A numberofsegments=duration/50

for /F %%f in ("%1") do (
	for /L %%n in (0,50,!duration!) do (
		echo %%~nf !count!/!numberofsegments! - Also DEPRICATED, cause too slow for large files /reopening and searching/
		md C:\WTRV\.AVC\%%~nf
echo 		md C:\WTRV\.HEVC\%%~nf
rem		ffmpeg -i %1 -c copy -ss %%n -t 50 C:\WTRV\.AVC\%%~nf\Split.!count!.mkv
		set /A count+=1
		echo.
		echo.
		echo.
	)
) 
