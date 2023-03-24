	@echo off
	@setlocal enabledelayedexpansion

for /f "tokens=3" %%a in ('
    robocopy "%~1" "%TEMP%" /S /L /BYTES /XJ /NFL /NDL /NJH /R:0 ^| find "Bytes"
') do (
	set return=%%a
	set returnMB=!return:~0,-6!
	set returnGB=!return:~0,-9!
	set returnTB=!return:~0,-12!
)
rem	echo !returnTB! !returnGB! !returnMB!
	if NOT DEFINED returnMB (
		echo !return!
	) ELSE (
		if NOT DEFINED returnGB (
			echo !return:~0,-6!MB
		) ELSE (
			if NOT DEFINED returnTB (
				echo !return:~0,-9!GB
			) ELSE (
				echo !return:~0,-12!TB
			)
		)
	)