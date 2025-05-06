@echo off
title ADB Tools - RaphCorp
color 1
set data="%appdata%\RaphCorp\ADBTools"
cd %appdata%
if exist RaphCorp\ADBTools\ (
  goto :start
) else (
  goto :firstlaunch
)
color 4
echo An unexpected error occured
pause
exit

:firstlaunch
echo Welcome to ADB Tools ! A RaphCorp made program.
echo.
echo It's your first time launching this program, ADB Tools need ADB, do you want to let ADB Tools set it up ? (Needed for the program to work) (Y/n)
echo.
set /p choice=" > "
if /i "%choice%"=="y" goto :setup
if /i "%choice%"=="Y" goto :setup
cls
color 4
echo You have denied application setup. Press any key to quit.
pause>nul
exit

:setup
cls
echo ADB Tools is setting up... Please wait.
cd %appdata%
mkdir RaphCorp
cd RaphCorp
mkdir ADBTools
cd ADBTools
echo Downloading files...
curl -SLJO https://github.com/Genymobile/scrcpy/releases/download/v3.2/scrcpy-win64-v3.2.zip
curl -SLJO https://raw.githubusercontent.com/RaphCorp/adbtools/refs/heads/main/Data/Cracks/Cracks.zip
echo Extracting files...
tar -xf scrcpy-win64-v3.2.zip
tar -xf Cracks.zip
echo Deleting old archive...
del /q /f /s scrcpy-win64-v3.2.zip
del /q /f /s Cracks.zip
echo Reorganising files...
move /Y scrcpy-win64-v3.2\* . >nul
rmdir /S /Q scrcpy-win64-v3.2 >nul
color 2
echo.
echo Setup done ! Press any key to access the program !
pause
goto :start


:: Utility tools
:usbNetworkShare
cls
color 4
echo Indev
pause
goto :start

:wakeUpAndUnlock
cls
echo [Wake Up And Unlock]
echo.
echo Enter phone password [WARNING: INPUT IS NOT CENSORED]
set /p phonePassword=" > "
adb shell input keyevent 82
adb shell input swipe 500 1000 300 300
adb shell input text %phonePassword%
echo.
color 2
echo Phone unlocked !
goto :start

:toggleHotspot
cls
echo [Toggle Hotspot]
echo.
echo Enabling Hotspot....
adb shell am start -n com.android.settings/.TetherSettings
adb shell input keyevent 20
adb shell input keyevent 66
adb shell input keyevent 66
adb shell input keyevent KEYCODE_APP_SWITCH
timeout 1 /NOBREAK>nul
adb shell input swipe 800 1200 500 10
adb shell input tap 10 10
cls
echo [Toggle Hotspot]
echo.
color 2
echo Done !
pause
goto :start

:Freecine
cls
echo [Freecine download]
echo;
echo Installing freecine (French)...
adb install %data%\Cracks\freecinefr.apk
color 2
echo Installation done.
pause
goto :start

:Spotify
cls
echo [Spotify Premium download]
echo.
echo Installing Spotify Premium...
adb install %data%\Cracks\Spotify.apk
color 2
echo Installation done.
pause
goto :start

:start
cd %data%
set %tool%=""
color 1
cls
echo Welcome to ADB Tools !
echo.
echo [Screen]
echo.
echo [1] Open phone screen viewer (Scrcpy)
echo.
echo [Utility]
echo.
echo [2] Enable USB Network sharing (indev)
echo [3] Wake up phone and enter password (wake up and unlock phone)
echo [4] Toggle Wifi Hotspot (phone must be unlocked and on if needed use [3] DO NOT OPEN HOTPOST SETTINGS)
echo.
echo [Cracks]
echo.
echo [5] Install Freecine
echo [6] Install Spotify (Premium)
echo.

set /p tool=" > "
if /i "%tool%"=="1" cls && color 2 && echo Phone screen opened successfully ! && call scrcpy-noconsole.vbs && pause
if /i "%tool%"=="2" goto :usbNetworkShare
if /i "%tool%"=="3" goto :wakeUpAndUnlock
if /i "%tool%"=="4" goto :toggleHotspot
if /i "%tool%"=="5" goto :Freecine
if /i "%tool%"=="6" goto :Spotify

goto :start