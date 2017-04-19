@echo off

REM This is the build script for Turbo C.  
REM Needs to run in DOSBox, VM or a real DOS machine.
REM Turbo C 3.2 download: https://turboc.codeplex.com/

if "%1"=="" goto :HELP

echo ---------------------------------------------------

REM In most cases, you just need to point to your TURBOC directory
set TURBOC_DIR=c:\TURBOC3
set DGE_DIR=C:\dge

set LIB=%TURBOC_DIR%\lib
set INCLUDE=%TURBOC_DIR%\include
set PATH=%TURBOC_DIR%;%TURBOC_DIR%\bin;C:\vim\vim73;%PATH%

set 
echo ---------------------------------------------------


REM requires Large memory model in most cases (-ml)
REM http://www.digitalmars.com/ctg/ctgMemoryModel.html



cd %DGE_DIR%\src\libkb
tcc.exe -ml -y -G -O -C -j1 -I%INCLUDE% -I%DGE_DIR%\src\libkb -L%LIB% kb*.c
copy %DGE_DIR%\src\libkb\*.OBJ %DGE_DIR%\src\

cd %DGE_DIR%\src
tcc.exe -ml -y -G -O -C -j1 -I%INCLUDE% -I%DGE_DIR%\src\libkb -L%LIB% tst_inpt.c dge*.c
REM  libkb\*.c
REM  dge_bmp.c dge_gfx.c dge_snd.c
REM kbhandle.c kblinux.c kbmlock.c kbos.c kbsignal.c kbtables.c


mkdir %DGE_DIR%\build\tc
copy *.exe %DGE_DIR%\build\tc

mkdir %DGE_DIR%\build\tc\res
mkdir %DGE_DIR%\build\tc\res\images

copy %DGE_DIR%\res\images\*.bmp %DGE_DIR%\build\tc\res\images

goto :END

:HELP
echo ##################################################
echo Usage: buildtcc.bat [program name] (without ext)
echo 	example: buildtcc.bat test_gfx
echo ##################################################
goto :END


:END

