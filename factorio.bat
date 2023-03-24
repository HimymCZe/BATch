	@echo off
	@setlocal enabledelayedexpansion
	@color 70
rem	@cls

for /R C:\WTRV\.AVC.Factorio %%f in (*lua) do (
rem	echo %%f
	set F=%%~nf
	set nF=%%~nf
	
	for /F %%e in ('fart -c -q -i "%%f" %1') do (
rem		neco
		if NOT %%e==!nF! (
			echo %%f
			fart -q -i "%%f" %1
			echo,
		)
	)

rem	if NOT !nF!==!F! (
rem		echo !F!
rem		echo,
rem	)

)

echo --------------------------------------------------------------------------------