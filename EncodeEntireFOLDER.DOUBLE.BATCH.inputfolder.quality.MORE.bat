	@echo off
	@setlocal enabledelayedexpansion

	set countFULL=0
	set count=0

rem	set input=%1
rem	set last=!input:~-1,1!
rem	echo !last!
rem	if !last!==\ set input=!input:~0,-1!
rem	echo !input!

rem	set output=%2
rem	set last=!output:~-1,1!
rem	echo !last!
rem	if !last!==\ set output=!output:~0,-1!
rem	echo !output!
rem		if NOT DEFINED output set output=C:\WTRV\.HEVC
rem			md "!output!\%%~nxF"

rem	set quality=%2
rem	echo !quality!
rem		if NOT DEFINED quality set quality=30:32:34

start Double.Batch.Encode.ODD.bat %*
start Double.Batch.Encode.EVEN.bat %*
exit