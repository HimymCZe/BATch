	@echo off
	@setlocal enabledelayedexpansion

@SET DT=!date:~6,4!.!date:~3,2!.!date:~0,2!_!time:~0,2!.!time:~3,2!.!time:~6,2!
@SET DT=!DT: =0!

	echo !DT!
	fart -n *eml Content-Base
	fart -n *eml Content-Base|Clip
	echo.

set /P _startat="You sure to delete ALL this? (1: Yes): "
if !_startat!==1 (
	del *eml
)