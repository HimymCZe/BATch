	@echo off
	@setlocal enabledelayedexpansion

echo %1

if "%~1"=="" (
	echo no arg
) ELSE (
	echo %1 EXIST
)