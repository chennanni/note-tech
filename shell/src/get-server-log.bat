What does this script do: it uses PuTTY to connect to the server and download the log.

@echo off
REM ---------------------Set Path ------------------------------
SET PATH=[path to putty]\PuTTY;%PATH%
REM ---------------------Download Log 2------------------------
plink -ssh [server2-address] -l [username] -pw [password] cat [absolute-log-address]/something.log > server2-log.txt
REM ---------------------Download Log 3-----------------------
plink -ssh [server3-address] -l [username] -pw [password] cat [absolute-log-address]/something.log > server3-log.txt
