	@echo off
rem	@setlocal enabledelayedexpansion

@set /P insert=insert: 
@rem	@for /F "tokens=1-2 delims=^=" %%a in ("%insert%") do streamlink -o C:\WTRV\%%b.mp4 %insert% 720p
		echo %%(uploader)s.%%(title)s[%%(height)sp%%(fps)s].%%(ext)s
		youtube-dl -o C:\WTRV\%%(uploader)s.%%(title)s[%%(height)sp%%(fps)s].%%(ext)s %insert% --restrict-filenames -f bestvideo[height=1080][fps=60]+bestaudio/bestvideo[height=1080]+bestaudio/bestvideo[height=720][fps=60]+bestaudio/bestvideo[height=720]+bestaudio/best