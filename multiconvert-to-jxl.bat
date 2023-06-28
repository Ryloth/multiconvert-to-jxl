cls
@echo off
set compatCJXL=0
:: Author: Andrew Westaway
:: Date: 20230625
:: ==========
echo We are going to convert:
echo %1 to JXL
echo:
:: ==========
echo ==========START CONVERSION==========
echo:
REM check if photo is compatable with cjxl
if %~x1==.jpg GOTO :alreadyCompat
if %~x1==.png GOTO :alreadyCompat
if %~x1==.gif GOTO :alreadyCompat
if %~x1==.apng GOTO :alreadyCompat
:: ==========
echo IF YOU CHOOSE A JPG YOU SHOULD NOT SEE THIS!
echo Using Magick to convert incompatable %~x1 to png:
echo %1 to D:\%~n1_temp.png
echo:
REM convert photo with magick
"D:\PortableApps_Windows\PortableApps\ImageMagick\magick.exe" %1 D:\%~n1_temp.png
echo Using cjxl to png
echo This may take a few minutes!
echo Started conversion at %TIME%
echo:
"D:\PortableApps_Windows\PortableApps\jxl-x64-windows-static_20230605\cjxl.exe" -d 9 -e 1 --compress_boxes=0 D:\%~n1_temp.png D:\%~n1_from%~x1_bycjxl_d1e9cb0.jxl
echo Ended conversion at %TIME%
echo:
del D:\%~n1_temp.png
echo Removing temporary png
echo:
GOTO :madeCompat
:: ==========
:alreadyCompat
echo Using cjxl to convert
echo %1 to D:\%~n1_from%~x1_bycjxl_d1e9cb0.jxl
echo:
"D:\PortableApps_Windows\PortableApps\jxl-x64-windows-static_20230605\cjxl.exe" -e 1 --compress_boxes=0 %1 D:\%~n1_from%~x1_bycjxl_d1e9cb0.jxl
echo:
:madeCompat
set compatCJXL=1
echo Using Magick to convert
echo %1 to D:\%~n1_from%~x1_byMagick_default.jxl
echo:
"D:\PortableApps_Windows\PortableApps\ImageMagick\magick.exe" %1 D:\%~n1_from%~x1_byMagick_default.jxl
echo Using IrfanView to convert
echo %1 to D:\%~n1_from%~x1_byIrfanview_default.jxl
echo:
"D:\PortableApps_Windows\PortableApps\IrfanViewPortable\App\IrfanView64\i_view64.exe" %1 /convert=D:\%~n1_from%~x1_byIrfanview_default.jxl
echo Conversions completed
echo:
:: ==========
echo ==========COPY TAGS==========
echo:
REM exiftool origonal tags to cjxl photo
if compatCJXL==1 (
echo Using ExifTool on cjxl to copy tags from
echo %1 to D:\%~n1_bycjxl_d1e9cb0.jxl
echo:
D:\PortableApps_Windows\PortableApps\exiftool\exiftool.exe -TagsFromFile %1 D:\%~n1_from%~x1_bycjxl_d1e9cb0.jxl
echo:)
REM exiftool origonal tags to magick photo
echo Using ExifTool on Magick to copy tags from
echo %1 to D:\%~n1_from%~x1_byMagick_default.jxl
echo:
D:\PortableApps_Windows\PortableApps\exiftool\exiftool.exe -TagsFromFile %1 D:\%~n1_from%~x1_byMagick_default.jxl
echo:
REM exiftool origonal tags to irfanview photo
echo Using ExifTool on IrfanView to copy tags from
echo %1 to D:\%~n1_from%~x1_byIrfanview_default.jxl
echo:
D:\PortableApps_Windows\PortableApps\exiftool\exiftool.exe -TagsFromFile %1 D:\%~n1_from%~x1_byIrfanview_default.jxl
echo:
:: ==========
REM FINSIHED!
echo Complete!