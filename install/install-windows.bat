@echo off
setlocal

set "SCRIPT_DIR=%~dp0"
set "SRC=%SCRIPT_DIR%calcsx_exporter"
set "DEST=%APPDATA%\Autodesk\Autodesk Fusion 360\API\Scripts"

if not exist "%SRC%" (
    echo ERROR: cannot find 'calcsx_exporter' folder next to this installer.
    echo Make sure you extracted the full release zip before running this.
    pause
    exit /b 1
)

if not exist "%DEST%" mkdir "%DEST%"

if exist "%DEST%\calcsx_exporter" (
    echo Removing previous installation at %DEST%\calcsx_exporter
    rmdir /s /q "%DEST%\calcsx_exporter"
)

xcopy /E /I /Y /Q "%SRC%" "%DEST%\calcsx_exporter" >nul

echo.
echo Installed to: %DEST%\calcsx_exporter
echo.
echo Next steps:
echo   1. Restart Fusion 360 if it is running
echo   2. Open UTILITIES ^> Scripts and Add-Ins ^> My Scripts
echo   3. Select 'calcsx_exporter' and click Run
echo.
pause
