@echo off
:: Set the log file dynamically to the folder where this script is located
set LOGFILE="%~dp0loginscript.log"

echo ====================================================== >> %LOGFILE%
echo %date% %time% - STARTUP SCRIPT INITIATED >> %LOGFILE%

:: Chrome (Normal)
tasklist /fi "imagename eq chrome.exe" | find /i "chrome.exe" >nul
if %errorlevel% equ 0 (
    echo %date% %time% - Chrome is already running. Skipping... >> %LOGFILE%
) else (
    echo %date% %time% - Launching Chrome... >> %LOGFILE%
    start chrome
    echo %date% %time% - Successfully launched Chrome. >> %LOGFILE%
)

:: AuthVR5 (Minimized)
tasklist /fi "imagename eq AuthVR5.exe" | find /i "AuthVR5.exe" >nul
if %errorlevel% equ 0 (
    echo %date% %time% - AuthVR5 is already running. Skipping... >> %LOGFILE%
) else (
    echo %date% %time% - Launching AuthVR5 minimized... >> %LOGFILE%
    start "" /min cmd /c "start "" /min "C:\Program Files\AuthVR5\AuthVR5.exe" >nul 2>&1"
    echo %date% %time% - Successfully launched AuthVR5. >> %LOGFILE%
)

:: Zoom Workplace (Normal)
tasklist /fi "imagename eq Zoom.exe" | find /i "Zoom.exe" >nul
if %errorlevel% equ 0 (
    echo %date% %time% - Zoom is running in background. Bringing to front... >> %LOGFILE%
    start "" "C:\Program Files\ZoomVDI\bin\Zoom.exe"
) else (
    echo %date% %time% - Launching Zoom... >> %LOGFILE%
    start "" "C:\Program Files\ZoomVDI\bin\Zoom.exe"
    echo %date% %time% - Successfully launched Zoom. >> %LOGFILE%
)

:: Sublime Text (Minimized)
tasklist /fi "imagename eq sublime_text.exe" | find /i "sublime_text.exe" >nul
if %errorlevel% equ 0 (
    echo %date% %time% - Sublime Text is already running. Skipping... >> %LOGFILE%
) else (
    echo %date% %time% - Launching Sublime Text minimized... >> %LOGFILE%
    start "" /min "C:\Program Files\Sublime Text\sublime_text.exe"
    echo %date% %time% - Successfully launched Sublime Text. >> %LOGFILE%
)

:: MobaXterm (Minimized)
tasklist /fi "imagename eq MobaXterm.exe" | find /i "MobaXterm.exe" >nul
if %errorlevel% equ 0 (
    echo %date% %time% - MobaXterm is already running. Skipping... >> %LOGFILE%
) else (
    echo %date% %time% - Launching MobaXterm minimized... >> %LOGFILE%
    start "" /min "C:\Program Files (x86)\Mobatek\MobaXterm\MobaXterm.exe"
    echo %date% %time% - Successfully launched MobaXterm. >> %LOGFILE%
)

:: Outlook (Minimized)
tasklist | findstr /i "olk.exe OUTLOOK.EXE" >nul
if %errorlevel% equ 0 (
    echo %date% %time% - Outlook is already running. Skipping... >> %LOGFILE%
) else (
    echo %date% %time% - Launching Outlook minimized... >> %LOGFILE%
    start "" /min "C:\Shortcuts\Outlook - Shortcut.lnk"
    echo %date% %time% - Successfully launched Outlook. >> %LOGFILE%
)

:: Teams (Minimized)
tasklist | findstr /i "ms-teams.exe Teams.exe" >nul
if %errorlevel% equ 0 (
    echo %date% %time% - Teams is already running in background. Skipping... >> %LOGFILE%
) else (
    echo %date% %time% - Launching Teams minimized... >> %LOGFILE%
    start "" /min "C:\Shortcuts\Microsoft Teams - Shortcut.lnk"
    echo %date% %time% - Successfully launched Teams. >> %LOGFILE%
)

echo %date% %time% - ALL LAUNCH COMMANDS COMPLETED >> %LOGFILE%
exit
