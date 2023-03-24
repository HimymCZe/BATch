	@echo off
	@setlocal enabledelayedexpansion

set count=0

for %%f in (C:\WTRV\.HEVC\Travelyan_2021.02.07_15.32.19_HIGH\*) do (
	set /A count+=1
	set /A mod=count %% 2
	set nm=%%f
rem	if count %% 2==1 echo !nm:~63,3!
	echo !count! !mod! !nm:~63,3!
)