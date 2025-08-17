@echo off
REM ------------------------------
REM Sonic3Animations Coding - fixit2.0 Public Beta 2.0.01
REM Logs CPU and RAM safely, greets current user, requests admin
REM ------------------------------

REM Get current Windows username
set "currentUser=%username%"

REM Notify user about admin requirement
echo Hello %currentUser%! 
echo fixit2.0 Public Beta 2.0.01 requires Administrator privileges to run.
echo Please allow permission when prompted.
timeout /t 3 /nobreak

REM Admin check and auto-elevate
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

echo Running with Administrator privileges now.
timeout /t 2 /nobreak

REM Safe logging of CPU and RAM info
echo Logging CPU and RAM info for %currentUser% > "%userprofile%\Desktop\fixit_log.txt"
wmic cpu get Name,MaxClockSpeed >> "%userprofile%\Desktop\fixit_log.txt"
wmic memorychip get capacity,speed >> "%userprofile%\Desktop\fixit_log.txt"

echo Log created at Desktop as fixit_log.txt
timeout /t 3 /nobreak

echo Make sure your laptop is plugged in and all apps are closed.
timeout /t 5 /nobreak

echo Preparing to restart into BIOS...
timeout /t 5 /nobreak

echo Restart command sent. Your laptop will boot into BIOS now.
pause

shutdown /r /fw /t 0
