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
echo *               The repacking images script              *
echo *                                                        *
echo **********************************************************
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if "%~nx1" == "" goto noinput
echo You have selected the%yellow% %~nx1 %deft%folder. | klr
echo(
echo Processing the%yellow% %~nx1 folder%deft%. | klr
echo(
set "folder=%~nx1"
icacls %folder% /grant Everyone:(IO)(CI)
cd %folder%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo(
echo Repacking the image....
echo(
for /f "delims=" %%a in ('dir /b *-kernel') do @set nfile=!nfile!%%~na
set "file=%nfile%"
if not exist "%file%.img-kernel" goto error
set kernel=!kernel!%file%.img-kernel
echo The kernel is:%yellow%         %kernel%%deft% | klr
echo(
echo Getting the ramdisk compression....
echo(
if not exist "ramdisk" goto error
for /f "delims=" %%a in (%file%.img-ramdisk-compress) do @set compress=!compress!%%a
echo Ramdisk compression:%yellow% %compress%%deft% | klr
goto %compress%
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:gz
echo(
mkbootfs ramdisk | gzip > %file%.img-ramdisk.gz
set ramdisk=!ramdisk!%file%.img-ramdisk.gz
echo The ramdisk is:%yellow%      %ramdisk%%deft% | klr
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lzma
echo(
mkbootfs ramdisk | xz -Flzma > %file%.img-ramdisk.lzma
set ramdisk=!ramdisk!%file%.img-ramdisk.lzma
echo The ramdisk is:%yellow%      %ramdisk%%deft% | klr
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:xz
echo(
mkbootfs ramdisk | xz -1 -Ccrc32 > %file%.img-ramdisk.xz
set ramdisk=!ramdisk!%file%.img-ramdisk.xz
echo The ramdisk is:%yellow%      %ramdisk%%deft% | klr
goto repack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:bz2
echo(
mkbootfs ramdisk | bzip2 > %file%.img-ramdisk.bz2
set ramdisk=!ramdisk!%file%.img-ramdisk.bz2
echo The ramdisk is:%yellow%      %ramdisk%%deft% | klr
goto repack
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:repack
echo(
echo Getting the image repacking arguments....
echo(
if not exist "%file%.img-board" goto noboard
for /f "delims=" %%a in (%file%.img-board) do @set nameb=!nameb!%%a
echo Board:%yellow%             '%nameb%'%deft% | klr
echo(
:noboard
if not exist "%file%.img-base" goto nobase
for /f "delims=" %%a in (%file%.img-base) do @set base=!base!%%a
echo Base:%yellow%              %base%%deft% | klr
echo(
:nobase
for /f "delims=" %%a in (%file%.img-pagesize) do @set pagesize=!pagesize!%%a
echo Pagesize:%yellow%          %pagesize%%deft% | klr
echo(
if not exist "%file%.img-cmdline" goto nocmdline
for /f "delims=" %%a in (%file%.img-cmdline) do @set scmdline=!scmdline!%%a
echo Command line:%yellow%      '%scmdline%'%deft% | klr
echo(
:nocmdline
if not exist "%file%.img-kernel_offset" goto nokoff
for /f "delims=" %%a in (%file%.img-kernel_offset) do @set koff=!koff!%%a
echo Kernel offset:%yellow%     %koff%%deft% | klr
echo(
:nokoff
if not exist "%file%.img-ramdisk_offset" goto noramoff
for /f "delims=" %%a in (%file%.img-ramdisk_offset) do @set ramoff=!ramoff!%%a
echo Ramdisk offset:%yellow%    %ramoff%%deft% | klr
echo(
:noramoff
if not exist "%file%.img-second_offset" goto nosecoff
for /f "delims=" %%a in (%file%.img-second_offset) do @set fsecoff=!fsecoff!%%a
echo Second offset:%yellow%     %fsecoff%%deft% | klr
set secoff=--second_offset %fsecoff%
echo(
:nosecoff
if not exist "%file%.img-second" goto nosecd
set fsecd=!fsecd!%file%.img-second
echo Second bootloader:%yellow% %fsecd%%deft% | klr
set "second=--second %fsecd%"
echo(
:nosecd
if not exist "%file%.img-tags_offset" goto notagoff
for /f "delims=" %%a in (%file%.img-tags_offset) do @set tagoff=!tagoff!%%a
echo Tags offset:%yellow%       %tagoff%%deft% | klr
echo(
:notagoff
if not exist "%file%.img-dt" goto nodt
set fdt=!fdt!%file%.img-dt
echo Device tree blob:%yellow%  %fdt%%deft% | klr
set "dtb=--dt %fdt%"
echo(
:nodt
echo(
:newimage
echo Please enter the desired name for the new repacked image without extension (img). Like this %yellow%boot%deft%-stock-2201 or carliv-%yellow%recovery%deft%-30 or %yellow%boot%deft%-new. | klr
set /P newimage=Insert the name here: || set newimage="0"
if "%newimage%"=="0" goto noimage
if not "%newimage%"=="%newimage:boot=%" goto command
if not "%newimage%"=="%newimage:recovery=%" goto command
goto wrongname
echo(
:command
echo Your new image is%yellow% %newimage%.img%deft%. | klr
echo(
echo Executing the repacking command....
echo( 
mkbootimg --kernel %kernel% --ramdisk %ramdisk% --pagesize %pagesize% --base %base% --board "%nameb%" --kernel_offset %koff% --ramdisk_offset %ramoff% --tags_offset %tagoff% %second% --cmdline "%scmdline%" %secoff% %dtb% -o ..\%newimage%.img
del "%file%.img-ramdisk.%compress%"
cd ..\
echo(
echo(
echo Done. Your new image was repacked as%yellow% %newimage%.img%deft%. | klr
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:noinput
echo(
echo(
echo %red%No folder selected. Exit script.%deft% | klr
echo(
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:wrongname
echo(
echo(
echo %red%The name have to include the type of image in it, %yellow%boot%red% or%yellow% recovery%red%.%deft% | klr
echo(
goto newimage
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:noimage
echo(
echo(
echo %red%Please enter a name for the repacked image first.%deft% | klr
echo(
goto newimage
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:error
echo(
echo(
echo %red%There is an error in your folder. The kernel or ramdisk is missing. Exit script.%deft% | klr
echo(
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:end
echo(
pause