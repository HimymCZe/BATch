	@echo off
	@setlocal enabledelayedexpansion

for /L %%N in (0,0,1) do (
	set /A A=!random!
	set /A B=!random!
	set /A count+=1
	if NOT !A!==!B! (
rem		echo !count! = !A!.!B!
	) else (
		set /A n+=1
		echo !count! = !A!.!B! ... ... ... !n!
	)
)