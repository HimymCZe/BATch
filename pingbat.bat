	@echo off
	@Setlocal EnableDelayedExpansion

@SET startDT=!date:~6,4!.!date:~3,2!.!date:~0,2!_!time:~0,2!.!time:~3,2!.!time:~6,2!
@SET startDT=!startDT: =0!
@SET prefail=0
@SET fail=0
@SET line43=0
@SET output=0
@SET TOTAL=0
FOR /l %%n in () do (
	@set count=0
	@SET DT=!date:~6,4!.!date:~3,2!.!date:~0,2!_!time:~0,2!.!time:~3,2!.!time:~6,2!
	echo !DT: =0! >> pingbatLOG_!startDT!.txt
	FOR /f "TOKENS=*" %%i in ('ping -n 1 8.8.8.8') do (
		set LINE=%%i
		set /A count+=1
		echo LINE !count!: !LINE! >> pingbatLOG_!startDT!.txt
		if !count!==2 (
			set FRST=!LINE:~0,1!
			set THRD=!LINE:~2,1!
			if !FRST!==R (
				if !THRD!==p set output=!DT: =0! @ !LINE:~29,10! & timeout /t 10 /nobreak>nul
				if NOT !THRD!==p set output=!DT: =0! @ !LINE! & timeout /t 1 /nobreak>nul
			)
			if !FRST!==G set output=!DT: =0! @ !LINE! & netsh interface set interface Ethernet disable & msg %username% "!LINE!" & timeout /t 1 /nobreak>nul & netsh interface set interface Ethernet enable & timeout /t 4 /nobreak>nul
			if NOT !FRST!==R if NOT !FRST!==G set output=!DT: =0! @ !LINE! & timeout /t 1 /nobreak>nul
		)
		if !count!==4 (
			set line43=!LINE:~43,1!
			if !prefail!==!line43! (
				if !line43!==0 set fail=0
				if !line43!==1 set /A fail+=!line43!
			)
			set prefail=!line43!
			set /A TOTAL+=!LINE:~43,1!
		)
	)
	echo !output! ... !prefail!==!line43! T=!TOTAL!
	echo Fail state: !fail! ... !prefail!==!line43! T=!TOTAL! >> pingbatLOG_!startDT!.txt
	echo. >> pingbatLOG_!startDT!.txt
	if !fail!==2 echo Fail state: 3 - Restarting & netsh interface set interface Ethernet disable & msg %username% "Fail state: 3" & timeout /t 1 /nobreak>nul & netsh interface set interface Ethernet enable & set fail=0 & timeout /t 4 /nobreak>nul
)