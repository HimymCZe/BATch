	@echo off
	@setlocal enabledelayedexpansion

	set /P max="Enter ceiling: "
for /L %%n in (1,1,!max!) do (
	set /A _25=%%n %% 25
	set /A _30=%%n %% 30
rem	echo !_25!!_30!
	if !_25!==0 (
		if !_30!==0 (
			echo %%n == HURRAY!
		) ELSE (
			echo %%n == %%25
		)
	) ELSE (
		if !_30!==0 (
			echo %%n == %%30
		) ELSE (
rem			echo.
		)
	)
)