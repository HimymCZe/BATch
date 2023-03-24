@echo off
setlocal enabledelayedexpansion

set _count=0
set total=0
for %%f in (*.mkv *.mp4) do set /a total+=1

for %%f in (*.mkv) do (
set /a _count+=1
echo !time! ^- %%f ^- !_count!^/!total!
set video=%%f
md !video:.mkv=!
zzmpeg -i !video! -q:v 2 -vf select="eq(pict_type\,PICT_TYPE_I)" -vsync 0 !video:.mkv=!/frame%%06d.jpg
cd !video:.mkv=!
md PerMinute

	set count=0
	for %%x in (frame*jpg) do (
		set /a count+=1
		set /a "mod=!count! %% 30"
		if !mod!==0 echo !count!%%x & copy %%x PerMinute\%%x
	)
	cd..
)

for %%f in (*.mp4) do (
set /A _count+=1
echo !time! ^- %%f ^- !_count!^/!total!
set video=%%f
md !video:.mp4=!
zzmpeg -i !video! -q:v 2 -vf select="eq(pict_type\,PICT_TYPE_I)" -vsync 0 !video:.mp4=!/frame%%06d.jpg
cd !video:.mp4=!
md PerMinute

	set count=0
	for %%x in (frame*jpg) do (
		set /a count+=1
		set /a "mod=!count! %% 30"
		if !mod!==0 echo !count!%%x & copy %%x PerMinute\%%x
	)
	cd..
)

