@echo off

REM This is the build script for Turbo C.  
REM Needs to run in DOSBox, VM or a real DOS machine.
REM Turbo C 3.2 download: https://turboc.codeplex.com/

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

cd %DGE_DIR%\src

delete *.OBJ
delete *.EXE

tcc.exe -ml -y -G -O -C -j1 -I%INCLUDE% -L%LIB%  *.c 

mkdir %DGE_DIR%\build\tc
copy *.exe %DGE_DIR%\build\tc


