	@echo off
REM CONVERT JULIAN DAY NUMBER TO MONTH, DAY, YEAR
REM ANTONIO PEREZ AYALA
SET /A W=(%1*100-186721625)/3652425, X=W/4, A=%1+1+W-X, B=A+1524, C=(B*100-12210)/36525, D=36525*C/100, E=(B-D)*10000/306001, F=306001*E/10000, DD=B-D-F, MM=E-1, YY=C-4716
IF %MM% GTR 12 SET /A MM-=12, YY+=1
REM INSERT LEFT ZEROS, IF NEEDED
IF %DD% LSS 10 SET DD=0%DD%
IF %MM% LSS 10 SET MM=0%MM%
REM SHOW THE DATE
ECHO %DD%.%MM%.%YY%