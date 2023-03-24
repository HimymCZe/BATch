	@echo off
	setlocal
for /L %%n in () do (
for /f "delims=" %%a in ('wmic path win32_localtime get dayofweek /format:list ') do for /f "delims=" %%d in ("%%a") do set %%d
echo day of the week : %dayofweek%
)