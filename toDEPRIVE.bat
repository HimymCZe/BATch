	@echo off
	@setlocal enabledelayedexpansion

set TOT=0
for /F %%f in ('dir /B /AD') do (set /A TOT+=1)

set cnt=0
for /F %%f in ('dir /B /AD') do (
	set /A cnt+=1
	cls
	echo %%f - !cnt!/!TOT!
	zzmpeg.exe -r 1/2 -start_number 1 -i %%f\frame%%06d.jpg -i %%f.mkv -map 0:v:0 -map 1:a:0 -vcodec nvenc -acodec copy -loop 1 %%f_DEPRIVED.mkv
)