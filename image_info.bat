::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::                                                    :::
:::          Carliv Image Kitchen for Android          :::
:::   boot+recovery images copyright-2015 carliv@xda   :::
:::   including support for MTK powered phones images  :::
:::                                                    :::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
cd %~dp0
IF EXIST "%~dp0\bin" SET PATH=%PATH%;"%~dp0\bin"
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
setlocal enabledelayedexpansion
set "red=\033[91m"
set "cyan=\033[96m"
set "yellow=\033[93m"
set "deft=\033[0m"    
echo(    
echo **********************************************************
echo *                                                        *
echo *         %cyan%Carliv Image Kitchen for Android %deft%v0.1          * | klr
echo *     boot+recovery images copyright-2015 %cyan%carliv@xda%deft%     * | klr
echo *    including support for MTK powered phones images     *
echo *                     WINDOWS version                    *
echo *             Printing the image info script             *
echo *                                                        *
echo **********************************************************
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if "%~1" == "" goto noinput
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "file=%~nx1"
echo Your image:%yellow% %~nx1 | klr
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo Display the informations for%yellow% %file%%deft%. | klr
echo(
imageinfo %file%
echo(
echo(
echo Done. All informations are saved in%yellow% %~n1.img-infos.txt%deft%. | klr
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:noinput
echo(
echo(
echo %red%No image file selected. Exit script.%deft% | klr
echo(
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:end
echo(
pause