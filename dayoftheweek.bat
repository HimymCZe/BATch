	@echo off
	set /p dd=dd:
	set /p mm=mm:
	set /p yy=yy:
set /a a=(14-mm)/12,yr=yy-a,m=mm+12*a-2,"dow=(dd+yr+yr/4-yr/100+yr/400+31*m/12)%%7"
echo %dow% - not wroking