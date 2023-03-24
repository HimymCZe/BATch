	@echo off
	@setlocal enabledelayedexpansion

for /F %%f in ('dir /B /AD') do (
	cd %%f
	set count=0
	for %%e in (*jpg) do (
		set /A count+=1
	)
	cd ..
	set /A hh=count/1800
	set /A mm=count-!hh!*1800
	set /A mm=mm/30
	set /A ss=count-!hh!*1800-!mm!*30
	set /A ss=ss*2

	if !hh! lss 10 set hh=0!hh!
	if !mm! lss 10 set mm=0!mm!
	if !ss! lss 10 set ss=0!ss!

	echo !hh!:!mm!:!ss! - %%f
)