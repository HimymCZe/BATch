	color 70
	@echo off

set count=0
	for /f "delims=" %%d in ('dir /s /b /ad ^| sort /r') do (
		set /A count+=1
		rd "%%d"
	)
echo	%count% directories deleted.