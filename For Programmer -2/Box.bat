@Echo off
cls
Setlocal Enabledelayedexpansion

::The following Function is created by kvc...don't modify it...if you don't know what are you doing...
::it takes following arguments...
rem [%1 = X-ordinate]
rem [%2 = Y-co_ordinate]
rem [%3 = height of box]
rem [%4 = width of box] 
rem [%5 = width From where to separate box,if don't specified or specified '-' (minus),then box will not be separated.]
rem [%6 = Background element of Box,if not specified or specified '-' (minus),then no background will be shown...It should be a single Character...]
rem [%7 = if you want a dialog box, instead of box,use '+' (plus),otherwise use '-'(minus) or specify nothing in this parameter...]
rem [%8 = the colour Code for the Box,e.g. fc,08,70,07 etc...don't define it if you want default colour...or type '-' (minus) for no color change...]

rem TIP : Don't specify %6 and %7 together ..as one of them will be ignored then !!!
rem #kvc

set string=
set color=%~8
if defined color (if /i "!color!" == "-" (set color=)) ELSE (set color=07)
set x_val=%~1
set y_val=%~2
set sepr=%~5
if /i "!sepr!" == "-" (set sepr=)
set spaceElement=
set edge_char=Ä
set char=%~6
if /i "!char!" == "-" (set char=)
set dialog=%~7
if defined dialog (
	if /i "!dialog:~0,1!" == "+" (set "char=Û"&&set "edge_char=Û") ELSE (set "edge_char=Ä")
	)
if defined char (set char=!char:~0,1!) ELSE (set "char= ")
set line=
set /a spaces=%~4 - 2
for /l %%a in (1,1,!spaces!) do (set "spaceElement=!spaceElement!!char!"&&set "line=!line!!edge_char!")
if /i "!sepr!" neq "" (
	set line[1]=!line:~0,%sepr%!
	set line[2]=!line:~%sepr%!
	set line[2]=!line[2]:~1!
	set line=!line[1]!Â!line[2]!
	set spaceElement[1]=!spaceElement:~0,%sepr%!
	set spaceElement[2]=!spaceElement:~%sepr%!
	set spaceElement[2]=!spaceElement[2]:~1!
	set spaceElement=!spaceElement[1]!³!spaceElement[2]!
	)
if /i "!edge_char!" == "Û" (
	set vertex_1=Û
	set vertex_2=Û
	set vertex_3=Û
	set vertex_4=Û
	set edge_left_right=Û
	) ELSE (
	set vertex_1=Ú
	set vertex_2=¿
	set vertex_3=À
	set vertex_4=Ù
	set edge_left_right=³
	)
if %~3 lss 2 (
	set "string=!string!/g !y_val! !x_val! /d "!edge_left_right!!spaceElement!!edge_left_right!" "
	goto :bb
	)
set "string=!string!/g !y_val! !x_val! /d "!vertex_1!!line!!vertex_2!" "
set /a box_height=%~3 - 2
for /l %%a in (1,1,!box_height!) do (
	set /a y_val+=1
	set "string=!string!/g !y_val! !x_val! /d "!edge_left_right!!spaceElement!!edge_left_right!" "
	)
set /a y_val+=1
if /i "%sepr%" neq "" (set line=!line[1]!Á!line[2]!)
set "string=!string!/g !y_val! !x_val! /d "!vertex_3!!line!!vertex_4!" "

:bb
endlocal && batbox.exe !string! /g 0 0
goto :eof

