	@echo off
	@setlocal enabledelayedexpansion

for /L %%n in (0,1,745) do (
	set /A a=%%n-695
	set /A a=a*50
	set /A b=%%n-694
	set /A b=%%n*50
	echo !a!:!b!
	ffmpeg -i "c:\WTRV\Belynz - 2017 10 14 12-51-45 - Cross the Meme Eastbound 2017 _ RoadToMoreThanChewwysSubCount - https_simtweaks com_(720p)_end.mkv" -c copy -ss !a! -t 50s "c:\WTRV\Belynz - 2017 10 14 12-51-45\Split.%%n.mkv"
)