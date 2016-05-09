What does this script do: it restart the httpd web server.

```
echo restart apache httpd

@echo off
echo off

SET @mypath=[path to apache]\Apache Group\Apache2\bin

SET PATH=%PATH%;%@mypath%

REM echo %@mypath%
REM PATH

apache -k restart
```

http://ss64.com/nt/
https://www.apachelounge.com/viewtopic.php?t=2409
https://httpd.apache.org/docs/current/platform/windows.html
http://www.thewindowsclub.com/how-to-schedule-batch-file-run-automatically-windows-7
