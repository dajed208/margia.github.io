@echo off
setlocal
REM ======================================================================
REM  Genera Margia para Windows y lo verifica.
REM  Requisito: Python 3.10 o superior, instalado con "Add python.exe to PATH".
REM  Resultado: carpeta "dist_final\Margia" lista para copiar a otro equipo.
REM ======================================================================
cd /d "%~dp0\.."
title Construyendo Margia

echo.
echo [1/5] Comprobando Python...
where python >nul 2>nul
if errorlevel 1 (
  echo    No se encontro Python. Instalelo desde https://www.python.org/downloads/
  echo    y marque la casilla "Add python.exe to PATH" durante la instalacion.
  goto :error
)
python -c "import sys; sys.exit(0 if sys.version_info >= (3, 10) else 1)"
if errorlevel 1 (
  echo    Se necesita Python 3.10 o superior. Version encontrada:
  python --version
  goto :error
)
python --version
for /f %%v in ('python iniciar.py --version') do set VERSION=%%v
echo    Version de Margia: %VERSION%

echo.
echo [2/5] Instalando PyInstaller y las librerias de Excel y PDF...
python -m pip install --disable-pip-version-check --upgrade pyinstaller -r requirements.txt
if errorlevel 1 (
  echo    No se pudieron instalar las librerias. Revise su conexion a internet.
  goto :error
)

echo.
echo [3/5] Generando el programa (puede tardar unos minutos)...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
python -m PyInstaller --noconfirm --clean --onedir --console ^
  --name Margia ^
  --icon "installer\icono.ico" ^
  --add-data "frontend;frontend" ^
  --add-data "backend\db\schema.sql;backend\db" ^
  --collect-data reportlab ^
  --hidden-import openpyxl ^
  --hidden-import PIL.Image ^
  iniciar.py
if errorlevel 1 goto :error
if not exist "dist\Margia\Margia.exe" (
  echo    PyInstaller termino pero no genero dist\Margia\Margia.exe
  goto :error
)

echo.
echo [4/5] Armando la carpeta para entregar (dist_final\Margia)...
if exist dist_final rmdir /s /q dist_final
mkdir dist_final\Margia
xcopy "dist\Margia" "dist_final\Margia" /e /i /q /y >nul || goto :error
xcopy config "dist_final\Margia\config" /e /i /q /y >nul || goto :error
xcopy plantillas "dist_final\Margia\plantillas" /e /i /q /y >nul || goto :error
mkdir "dist_final\Margia\data"
copy /y docs\MANUAL_USUARIO.md "dist_final\Margia\" >nul
copy /y docs\MANUAL_TECNICO.md "dist_final\Margia\" >nul
copy /y docs\DESPLIEGUE.md "dist_final\Margia\" >nul
copy /y installer\LEAME.txt "dist_final\Margia\" >nul

echo.
echo [5/5] Verificando el programa generado...
"dist_final\Margia\Margia.exe" --verificar
if errorlevel 1 (
  echo.
  echo    El programa se genero, pero la verificacion encontro fallas (ver arriba).
  goto :error
)
if exist "dist_final\Margia\data\costos.db" del /q "dist_final\Margia\data\costos.db"

echo.
echo ======================================================================
echo  LISTO (Margia %VERSION%). Para entregar: copie la carpeta "dist_final\Margia"
echo  completa al otro equipo y ejecute Margia.exe.
echo.
echo  Opcional - instalador con acceso directo en el menu Inicio y el
echo  escritorio: instale Inno Setup (https://jrsoftware.org/isinfo.php) y
echo  abra installer\Margia.iss con el.
echo ======================================================================
echo.
pause
exit /b 0

:error
echo.
echo ======================================================================
echo  NO SE PUDO COMPLETAR. Lea el mensaje de arriba para ver la causa.
echo ======================================================================
echo.
pause
exit /b 1
