	@echo off
	@setlocal enabledelayedexpansion

for /L %%n in () do (
	set count=0
	for /F %%e in ('dir /B /AD C:\WTRV\.AVC\*xnapy*') do (
rem		echo %%e
rem		if EXIST C:\WTRV\.HEVC\%%e echo HALELUJA C:\WTRV\.HEVC\%%e EXIST
		if NOT EXIST C:\WTRV\.HEVC\%%e echo CREATING C:\WTRV\.HEVC\%%e & md C:\WTRV\.HEVC\%%e
		for /F %%h in ('dir /B /A-D C:\WTRV\.AVC\%%e') do (
			set /A count+=1
		)
		for /F %%f in ('dir /B /A-D C:\WTRV\.AVC\%%e') do (
			if !count! GEQ 2 (
				echo %%e \ %%f : !count!
				for /F %%h in ('filesize C:\WTRV\.AVC\%%e\%%f') do (
					if NOT %%h==0 (
						echo.
						echo %%e \ %%f : %%h : !count!
						echo.
						C:\Downloads\StaxRip-x64-2.1.3.0-stable\Apps\Encoders\NVEnc\NVEncC64.exe -i C:\WTRV\.AVC\%%e\%%f --cqp 30:32:34 --codec h265 --preset quality --aq --aq-temporal --bframes 5 --ref 16 --output-res 1280x720 --vpp-resize lanczos4 -f --audio-copy -o C:\WTRV\.HEVC\%%e\%%f
					) ELSE (
						echo.
						echo %%e \ %%f : %%h : !count!
						echo.
						echo NO ENCODE
						echo.
					)
				if EXIST C:\WTRV\.HEVC\%%e\%%f for /F %%g in ('filesize C:\WTRV\.HEVC\%%e\%%f') do if NOT %%g==0 (echo %%g & del C:\WTRV\.AVC\%%e\%%f)
				)
			) ELSE (
				echo %%e \ %%f : %%h : !count!
				timeout /T 10
			)
		)
	)
)