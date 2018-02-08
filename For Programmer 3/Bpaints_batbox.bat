@Echo off
CLS
fn.dll cursor 0

:Start
Setlocal EnableDelayedExpansion

REM :: setting up default values...

set "title=Batch Paint version 2.0 by Kvc"
set work_row=25
set work_col=80
set col_fg=7
set col_bg=0
set Char=120
set curFile=Untitled.Bim
Set grid_item=-
set Tool=Pencil
set tool_code=P
Set _Space=
Set _Batbox=
Set _Count=0
Set _Box_Count=0
Set _Extra_count=0
Set Font_Size=6
Set cmd_bg=0
Set reload=no

:Initializing
Title %title% -- Loading Modules ...Please Wait...

REM :: -- Loading Database -- ::
for /f "eol=#" %%a in (ASCII.DB) do (Set "%%a")

set /a real_row=%work_row%+10
set /a real_col=%work_col%+20
mode %real_col%,%real_row%

REM :: -- Main menu -- ::
FOR /l %%A in (1,1,!real_col!) do set "_Space=!_Space! "
Set "_Batbox=!_Batbox!/c 0x70 /g 0 0 /d "!_Space!" /g 0 0 /c 0x70 /d " New ^| Save ^| Open ^| Console Size ^| Grid [!grid_item!] ^| Font Size [!Font_Size!] ^| CMD BG [" /c 0x7!cmd_bg! /a 254 /c 0x70 /d "] ^| About Us ^| Help ^| Quit" "

REM :: -- Char box--::
set /a Char_box_start=!work_row!+1
set /a Char_box_stop=!work_col!
call :Box 0 !Char_box_start! 9 !Char_box_stop!
set /a char_box_Title=!Char_box_start!+5
Set "_Batbox=!_Batbox!/c 0x08 /g !Char_box_Title! !Char_box_start! /d "Character Set" /c 0x02 "
set /a _Temp_Y=!Char_box_start!+1
set /a _Temp_X=1
set _Temp_X_copy=!_Temp_X!
Set /a _Temp_X_limit=!_Temp_X!+!Char_box_stop!-2
FOR /l %%A in (1,1,6) do (
	Set "_Batbox=!_Batbox!/g !_Temp_X! !_Temp_Y! /a %%~A "
	set "xy[!_Extra_count!]=!_Temp_X! !_Temp_Y!"
	set "id[!_Extra_count!]=C%%~A"
	Set /a _Extra_count+=1
	Set /a _Temp_X+=2
	if !_Temp_X! geq !_Temp_X_limit! (set _Temp_X=!_Temp_X_copy!&&set /a _Temp_Y+=1)
)
FOR /l %%A in (11,1,12) do (
	Set "_Batbox=!_Batbox!/g !_Temp_X! !_Temp_Y! /a %%~A "
	set "xy[!_Extra_count!]=!_Temp_X! !_Temp_Y!"
	set "id[!_Extra_count!]=C%%~A"
	Set /a _Extra_count+=1
	Set /a _Temp_X+=2
	if !_Temp_X! geq !_Temp_X_limit! (set _Temp_X=!_Temp_X_copy!&&set /a _Temp_Y+=1)
)

FOR /l %%A in (14,1,254) do (
	Set "_Batbox=!_Batbox!/g !_Temp_X! !_Temp_Y! /a %%~A "
	set "xy[!_Extra_count!]=!_Temp_X! !_Temp_Y!"
	set "id[!_Extra_count!]=C%%~A"
	Set /a _Extra_count+=1
	Set /a _Temp_X+=2
	if !_Temp_X! geq !_Temp_X_limit! (set _Temp_X=!_Temp_X_copy!&&set /a _Temp_Y+=1)
)
Set "_Batbox=!_Batbox!/c 0x08 "

REM :: Creating a box giving an outline of default cmd console...
call :Box 0 1 !work_row! !work_col! - !grid_item! 07

REM :: -- Color Box and Tool Box -- ::
call :Box !work_col! 11 13 20 - _
call :Box !work_col! 24 6 20 - .
Set /a _ColorBox_Title=!work_col!+6
set /a sub_box_col=!work_col!+3
call :box !sub_box_col! 13 5 14 - - 00
call :box !sub_box_col! 18 5 14 - - 88
Set "_Batbox=!_Batbox!/g !_ColorBox_Title! 11 /d "Color Box" /g !_ColorBox_Title! 24 /d "Tool Box" /g !_ColorBox_Title! 13 /d "FG Color" /c 0x80 /g !_ColorBox_Title! 18 /d "BG Color" /c 0x07 "
set /a _Temp_Y=25
set /a _Temp_X=!work_col!+2
for %%a in ("[]....Pencil","[ ]....Line","[ ]....Box","[ ]....Text") do (
	Set "_Batbox=!_Batbox!/g !_Temp_X! !_Temp_Y! /d "%%~a" "
	set /a _Temp_Y+=1
	)
set /a _Temp_Y=25
set /a _Temp_X=!work_col!+3
for %%a in ("P","L","B","T") do (
	Set "XY[!_Extra_count!]=!_Temp_X! !_Temp_Y!"
	Set "ID[!_Extra_count!]=T%%~a"
	Set /a _Extra_count+=1
	Set /a _Temp_Y+=1
)
set /a _Temp_X=!sub_box_col!+1
set _Temp_X_copy=!_Temp_X!
set /a _Temp_X_limit=!sub_box_col!+12
set _Temp_Y=14
set _Color_char=219
for %%a in (0 1 2 3 4 5 6 7 8 9 a b c d e f) do (
	Set /a _Temp_Y_e=!_Temp_Y!+5
	Set "_Batbox=!_Batbox!/c 0x0%%~a /g !_Temp_X! !_Temp_Y! /a !_Color_char! /g !_Temp_X! !_Temp_Y_e! /a !_Color_char! "
	set "xy[!_Extra_count!]=!_Temp_X! !_Temp_Y!"
	set "id[!_Extra_count!]=F%%~a"
	set /a _Extra_count+=1
	set "xy[!_Extra_count!]=!_Temp_X! !_Temp_Y_e!"
	set "id[!_Extra_count!]=B%%~a"
	set /a _Extra_count+=1
	Set /a _Temp_X+=2
	If !_Temp_X! gtr !_Temp_X_limit! (set _Temp_X=!_Temp_X_copy!&&set /a _Temp_Y+=1)
	)
	
REM :: -- Backspace Button -- ::
set /a _Temp_Y+=14
set /a _Temp_X=!work_col!
Set "_Batbox=!_Batbox!/c 0x8f /g !_Temp_X! !_Temp_Y! /d "    " /a 27 /a 27 /d " Backspace    " "
For /l %%a in (1,1,21) do (
	set "XY[!_Extra_count!]=!_Temp_X! !_Temp_Y!"
	set "ID[!_Extra_count!]=D1"
	set /a _Extra_count+=1
	set /a _Temp_X+=1
	)

REM :: -- Import Button -- ::
set /a _Temp_Y+=1
set /a _Temp_X=!work_col!
Set "_Batbox=!_Batbox!/c 0x70 /g !_Temp_X! !_Temp_Y! /d "    " /a 25 /a 25 /d "  Import      " "
for /l %%a in (1,1,21) do (
	set "xy[!_extra_count!]=!_Temp_X! !_Temp_Y!"
	set "id[!_extra_count!]=D2"
	set /a _Extra_count+=1
	set /a _Temp_X+=1
	)

REM :: -- Current Settings Box -- ::
:Update_Settings
call :Box !work_col! 1 10 20
set /a _Temp_temp_X=!work_col!+2
set /a _Temp_X=!work_col!+1
set "_Batbox=!_Batbox!/c 0x08 /g !_Temp_temp_X! 1 /d "Current Settings" /c 0x07 /g !_Temp_X! 3 /d "WorkScreen:" /g !_Temp_X! 4 /d "Text BG:    [ ]" /g !_Temp_X! 5 /d "Text FG:    [ ]" /g !_Temp_X! 6 /d "Active Tool:" /g !_Temp_X! 7 /d "Active Char:" /g !_Temp_X! 8 /d "Char Code:" "
Set /a _Text_Bg_Value=!work_col!+14
Set /a _Text_Value=!work_col!+13
Set "_Batbox=!_Batbox!/c 0x0e /g !_Text_Value! 3 /d "!work_row!x!work_col!" /c 0x!col_bg!!col_bg! /g !_Text_Bg_Value! 4 /a !_Color_char! /c 0x!col_fg!!col_fg! /g !_Text_Bg_Value! 5 /a !_Color_char! /c 0x0e /g !_Text_Value! 6 /d "!Tool!" /g !_Text_Value! 7 /a !Char! /g !_Text_Value! 8 /d "!Char!" /c 0x07 "

Batbox !_Batbox!

:Load
fn.dll color 07
if defined file (
	for /f "eol=# skip=1 tokens=1-6" %%A in (!file!) do (
		if /i "%%A" == "B" (
			call :Box %%B %%C %%E %%F - - %%D Box[!_Box_Count!]
			Set "Input[%%B,%%C]=%%A;%%B;%%C;%%D;%%E;%%F"
			Set /a _Box_Count+=1
			)
		if /i "%%A" == "C" (
		Set "Input[%%B,%%C]=%%A;%%B;%%C;%%D;%%E"
		Set "_Final=!_Final!/g %%B %%C /c 0x%%D /a %%E "
		)
		)
Batbox !_Final!
Set _Final=
)

title %title% -- !Curfile!
set file=
Set _Final=

if /i "!reload!" == "yes" (
	set reload=No
	For /l %%A in (0,1,!work_col!) do (
	For /l %%B in (0,1,!work_row!) do (
	IF /i "!Input[%%A,%%B]!" Neq "" (For /f "tokens=1-5 delims=;" %%a in ("!Input[%%A,%%B]!") do (Set "_Final=!_Final!/g %%b %%c /c 0x%%d /a %%e "))
	)
	)
	For /l %%A in (0,1,!_Box_Count!) do (For /f "tokens=1-6 delims=;" %%a in ("!Box[%%A]!") do (call :Box %%b %%c %%e %%f - - %%d))
Batbox !_Final!
Set _Final=
)


:Begining
For /f "tokens=1,2,3" %%a in ('fn.dll mouse') do set /a _Y=%%a,_X=%%b,_Key=%%c

REM :: --- Menu Bar Click --- ::
If /I "!_Y!" == "0" (
		REM :: --- Calculating centre of current cmd console... for putting Dialogue Box --- ::
		Set /a _Mid_X=!real_col! / 2 - 20
		Set /a _Mid_Y=!real_row! / 2 - 6
		
		Set _Mid_X_real=!_Mid_X!
		Set _Mid_Y_real=!_Mid_Y!
		
		Set _Space=
		For /l %%A in (1,1,32) do (Set "_Space=!_Space! ")
		
		REM :: --- 'New' Option -- ::
		If !_X! Geq 0 If !_X! Leq 5 (
		fn.dll sprite 0 0 80 " New "
		if !_Count! gtr 0 (
			Call :Box !_Mid_X! !_Mid_Y! 8 40 - - 88
			fn.dll sprite !_Mid_Y! !_Mid_X! 9f " BPaints!_Space!"
			Set /a _Mid_X+=2
			Set /a _Mid_Y+=2
			fn.dll sprite !_Mid_Y! !_Mid_X! 87 "Do You Want to save Changes these ^?^?"
			Call :Button Save 8f Save N 2 "Don't Save" 8f DoNotSave N 2 Cancel 80 Cancel N 2
			Set /a _Mid_X-=1
			Set /a _Mid_Y+=2
			
			Set _Mid_Y_copy=!_Mid_Y!
			Set /a _Mid_Y_copy_plus_4=!_Mid_Y_copy!+4
			
			Set /a _1_X=!_Mid_X!
			Set /a _1_X_plus_8=!_1_X!+8
			
			Set /a _2_X=!_Mid_X!+10
			Set /a _2_X_plus_16=!_2_X!+16

			Set /a _3_X=!_Mid_X!+26
			Set /a _3_X_plus_10=!_3_X!+10

			Batbox /o !_1_X! !_Mid_Y! !save! /o !_2_X! !_Mid_Y! !DoNotSave! /o !_3_X! !_Mid_Y! !Cancel! /o 0 0
			fn.dll sprite 0 0 70 " New "
			:Menu_New_Mouse_click
			For /f "tokens=1,2,3" %%a in ('fn.dll mouse') do set /a _Y=%%a,_X=%%b,_Key=%%c
			If !_Y! Geq !_Mid_Y_copy! If !_Y! Leq !_Mid_Y_copy_plus_4! (
				If !_X! Geq !_1_X! IF !_X! Leq !_1_X_plus_8! (goto :Save_it)
				If !_X! Geq !_2_X! IF !_X! Leq !_2_X_plus_16! (goto :Renew)
				If !_X! Geq !_3_X! IF !_X! Leq !_3_X_plus_10! (goto :Reload)
				)
			goto :Menu_New_Mouse_click
			)
			goto :Renew
		)
		
		REM :: --- 'Save' Option -- ::
		If !_X! Geq 7 If !_X! Leq 12 (
		fn.dll sprite 0 6 80 " Save "
		fn.dll sleep 200
		fn.dll sprite 0 6 70 " Save "
		:Save_it
		Set _Mid_X=!_Mid_X_real!
		Set _Mid_Y=!_Mid_Y_real!
		Call :Box !_Mid_X! !_Mid_Y! 8 40 - - 88
		fn.dll sprite !_Mid_Y! !_Mid_X! 9f " Save As!_Space!"
		Set /a _Mid_X+=2
		Set /a _Mid_Y+=2
		fn.dll sprite !_Mid_Y! !_Mid_X! 87 "Type Name of File and press Enter..."
		Set /a _Mid_X+=1
		Set /a _Mid_Y+=3
		:Menu_Save_User_Input
		Set File=Untitled
		batbox /g !_Mid_X! !_Mid_Y! /d "!_Space!" /g !_Mid_X! !_Mid_Y!
		fn.dll cursor 100
		Set /p "File="
		fn.dll cursor 0
		If not defined file goto (:Menu_Save_User_Input)
		If Exist "!File!" (
		Set _Mid_X=!_Mid_X_real!
		Set _Mid_Y=!_Mid_Y_real!
		Call :Box !_Mid_X! !_Mid_Y! 8 40 - - 88
		fn.dll sprite !_Mid_Y! !_Mid_X! 9f " Replace!_Space!"
		Set /a _Mid_X+=2
		Set /a _Mid_Y+=2
		fn.dll sprite !_Mid_Y! !_Mid_X! 87 "File already Exist... Overwrite^?^?"
		Call :Button " Yes " 8f Yes N 2 " No " 8f No N 2
		Set /a _Mid_X+=4
		Set /a _Mid_Y+=2
		Set _Mid_Y_copy=!_Mid_Y!
		Set /a _Mid_Y_copy_plus_4=!_Mid_Y_copy!+4
		
		Set /a _1_X=!_Mid_X!
		Set /a _1_X_plus_9=!_1_X!+9
		
		Set /a _2_X=!_Mid_X!+12
		Set /a _2_X_plus_8=!_2_X!+8
		
		Batbox /o !_1_X! !_Mid_Y! !Yes! /o !_2_X! !_Mid_Y! !No! /o 0 0
		fn.dll sprite 0 0 70 " New "
		:Menu_Save_Overwrite_Mouse_click
		For /f "tokens=1,2,3" %%a in ('fn.dll mouse') do set /a _Y=%%a,_X=%%b,_Key=%%c
		If !_Y! Geq !_Mid_Y_copy! If !_Y! Leq !_Mid_Y_copy_plus_4! (
			If !_X! Geq !_1_X! IF !_X! Leq !_1_X_plus_9! (goto :Save)
			If !_X! Geq !_2_X! IF !_X! Leq !_2_X_plus_8! (goto :Reload)
			)
		goto :Menu_Save_Overwrite_Mouse_click
		)
		goto :Save
		)

		REM :: --- 'Open' Option -- ::
		If !_X! Geq 13 If !_X! Leq 19 (
		Batbox /g 6 0 /c 0x80 " Open " /w 200 /g 6 0 /c 0x70 " Open "
		:Open_it
		Set _Mid_X=!_Mid_X_real!
		Set _Mid_Y=!_Mid_Y_real!
		Call :Box !_Mid_X! !_Mid_Y! 8 40 - - 88
		fn.dll sprite !_Mid_Y! !_Mid_X! 9f " Open   !_Space!"
		Set /a _Mid_X+=2
		Set /a _Mid_Y+=2
		fn.dll sprite !_Mid_Y! !_Mid_X! 07 "Drag File Here and press Enter..."
		Set /a _Mid_X+=1
		Set /a _Mid_Y+=3
		:Menu_Open_User_Input
		batbox /g !_Mid_X! !_Mid_Y! /d "!_Space!" /g !_Mid_X! !_Mid_Y!
		fn.dll cursor 100
		Set /p "File="
		fn.dll cursor 0
		If not defined file (Set Reload=Yes && Goto :Load)
		If not exist "!file!" (
		batbox /g !_Mid_X! !_Mid_Y! /c 0x08 /d " Invalid File... " /w 900
		Set Reload=Yes
		Goto :Load
		)
		Goto :Load
		)	
	)

REM :: -- Tools Usage -- ::
Set /a Work_col_1=!work_col!-1
if !_Y! gtr 1 if !_X! gtr 0 if !_X! lss !work_col_1! if !_Y! lss !work_row! (
	REM :: -- Pencil Tool -- ::
	if /i "!tool_code!" == "P" (
		if /i "!_Key!" == "1" (
			batbox /c 0x!col_bg!!col_fg! /g !_X! !_Y! /a !Char!
			set "Input[!_X!,!_Y!]=C;!_X!;!_Y!;!col_bg!!col_fg!;!Char!"
			Set "Input[!_Count!]=!_X!,!_Y!"
			Set /a _Count+=1
			) ELSE (
			batbox /c 0x!col_bg!!col_bg! /g !_X! !_Y! /a !Char!
			set Input[!_X!,!_Y!]=
			)
			goto :Begining
	)
	
	REM :: -- Line Tool -- ::
	if /i "!tool_code!" == "l" (
	rem :: 
	)
	
	REM :: -- Box Tool -- ::
	if /i "!tool_code!" == "B" (
		if not defined xy_1 (
			set "xy_1=!_X! !_Y!"
			set x_1=!_X!
			set y_1=!_Y!
			Batbox /c 0x!col_bg!!col_fg! /g !_X! !_Y! /a !Char!
			goto :Begining
			)
		set "xy_2=!_X! !_Y!"
		set x_2=!_X!
		set y_2=!_Y!

		rem Handing error, if user input reverses...
		if !y_1! gtr !y_2! (
			set tmp_=!y_1!
			set y_1=!y_2!
			set y_2=!tmp_!
			)
		
		if !x_1! gtr !x_2! (
			set tmp_=!x_1!
			set x_1=!x_2!
			set x_2=!tmp_!
			)

		
		set /a box_wid=!x_2!-!x_1!+1
		set /a box_len=!y_2!-!y_1!+1
		
		set /a x_1_end=!x_1!+!box_wid!
		set /a y_1_end=!y_1!+!box_len!
		
		For /l %%A in (!x_1!,1,!x_1_end!) do (
		For /l %%B in (!y_1!,1,!y_1_end!) do (
		set Input[%%A,%%B]=
		)
		)
		call :Box !x_1! !y_1! !box_len! !box_wid! - - !col_bg!!col_fg! Box[!_Box_Count!]
		set "Input[!x_1!,!y_1!]=B;!X_1!;!Y_1!;!col_bg!!col_fg!;!box_len!;!box_wid!"
		Set "Input[!_Count!]=!x_1!,!y_1!"
		Set /a _Count+=1
		Set /a _Box_Count+=1
			
		set xy_1=
		set xy_2=
		goto :Begining
	)
	REM :: -- Text tool -- ::
	if /i "!tool_code!" == "T" (
	set text=
	batbox /c 0x!col_bg!!col_fg! /g !_X! !_Y!
	fn.dll cursor 100
	set /p "text="
	if defined text (
	getlen "!text!"
	set len=!Errorlevel!
	For /l %%A in (0,1,!len!) do (
	Set char=63
	For /l %%B in (32,1,126) do (If /i "!text:~%%A,1!" == "!%%B!" (Set char=%%B))
	Set "Input[!_X!,!_Y!]=C;!_X!;!_Y!;!col_bg!!col_fg!;!char!"
	Set "Input[!_Count!]=!_X!,!_Y!"
	Set /a _Count+=1
	Set /a _X+=1
	)
	)
	fn.dll cursor 0
	goto :Begining
	)
)
for /l %%z in (0,1,!_Extra_count!) do (
	if /i "!_X! !_Y!" == "!xy[%%z]!" (
		if /i "!id[%%z]:~0,1!" == "F" (set col_fg=!id[%%z]:~1,1!)
		if /i "!id[%%z]:~0,1!" == "B" (set col_bg=!id[%%z]:~1,1!)
		if /i "!id[%%z]:~0,1!" == "C" (set char=!id[%%z]:~1!)
		if /i "!id[%%z]:~0,1!" == "T" (
			set tool_code=!id[%%z]:~1,1!
			if /i "!tool_code!" == "p" (set "Tool=Pencil")
			if /i "!tool_code!" == "l" (set "Tool=Line  ")
			if /i "!tool_code!" == "b" (set "Tool=Box   ")
			if /i "!tool_code!" == "t" (set "Tool=Text  ")
			set /a _Temp_Y=25
			set /a _Temp_X=!work_col!+3
			
			for %%a in ("p" "l" "b" "t") do (
			if /i "!tool_code!" == "%%~a" (batbox /c 0x07 /g !_Temp_X! !_Temp_Y! /a 1) ELSE (batbox /g !_Temp_X! !_Temp_Y! /a 255)
			set /a _Temp_Y+=1
			)
		)
		If /i "!id[%%z]:~0,1!" == "D" (
			REM :: -- Backspace Tool -- ::
			if /i "!id[%%z]:~1,1!" == "1" (
			Set /a _Count-=1
			For %%A in (!_Count!) do (
			Set Input[!Input[%%A]!]=
			Set Input[%%A]=
			)
			)
		)
		Set "_Batbox=/c 0x0e /g !_Text_Value! 3 /d "!work_row!x!work_col!" /c 0x!col_bg!!col_bg! /g !_Text_Bg_Value! 4 /a !_Color_char! /c 0x!col_fg!!col_fg! /g !_Text_Bg_Value! 5 /a !_Color_char! /c 0x0e /g !_Text_Value! 6 /d "!Tool!" /g !_Text_Value! 7 /a !Char! /g !_Text_Value! 8 /d "    " /g !_Text_Value! 8 /d "!Char!" /c 0x07 "
		Batbox !_Batbox!
	)
)

goto :Begining




:Save
Set _Batbox=
Set _Box_Count_copy=0
echo !work_row!x!work_col!>>"!File!.Bim"

For /l %%X in (0,1,!work_col!) do (
	For /l %%Y in (0,1,!work_row!) do (
	If /i "!Input[%%X,%%Y]!" NEQ "" (
	echo !Input[%%X,%%Y]!>>"!File!.Bim"
	For /f "tokens=1,2,3,4,5 delims=;" %%A in ("!Input[%%X,%%Y]!") do (
				If /i "%%A" == "C" (Set "_Batbox=!_Batbox!/c 0x%%~D /g %%B %%C /a %%E ")
				If /i "%%A" == "B" (For %%I in (!_Box_Count_Copy!) do (Set "_Batbox=!_Batbox! !Box[%%I]!") && Set /a _Box_Count_Copy+=1)
			)
		)
	)
)
echo.!_Batbox!>"!File!.Batbox"
Endlocal
goto :Start

:Renew
Echo renew
pause

:Reload
Set _Batbox=
Set _Box_Count_copy=0

For /l %%X in (0,1,!work_col!) do (
	For /l %%Y in (0,1,!work_row!) do (
		If /i "!Input[%%X,%%Y]!" NEQ "" (
			For /f "tokens=1,2,3,4,5 delims=;" %%A in ("!Input[%%X,%%Y]!") do (
				If /i "%%A" == "C" (Set "_Batbox=!_Batbox!/c 0x%%~D /g %%B %%C /a %%E ")
				If /i "%%A" == "B" (For %%I in (!_Box_Count_Copy!) do (Set "_Batbox=!_Batbox! !Box[%%I]! ") && Set /a _Box_Count_Copy+=1)
			)
		)
	)
)
	
call :Box 0 1 !work_row! !work_col! - !grid_item! 07
batbox !_Batbox!
goto :Begining












Rem :: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ::
Rem ::                             EXTRA FUNCTIONS ARE BELOW THIS AREA...
Rem :: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ::



Rem :: ------------------------------------------------------------------------------------------------ ::
Rem ::                             The Box function ver. 3.0 by kvc
Rem :: ------------------------------------------------------------------------------------------------ ::

::The following Function is created by kvc...don't modify it...if you don't know what are you doing...
::it takes following arguments...
:: it is the ver.4.0 of Box function... and it's faster than previous function... #kvc
rem :: Unwanted parameters are removed ... (i.e. Dialogue Box...) Make the color code for FG and BG same for simply getting a dialogue box...

rem [%1 = X-ordinate]
rem [%2 = Y-co_ordinate]
rem [%3 = height of box]
rem [%4 = width of box] 
rem [%5 = width From where to separate box,if don't specified or specified '-' (minus),then box will not be separated.]
rem [%6 = Background element of Box,if not specified or specified '-' (minus),then no background will be shown...It should be a single Character...]
rem [%7 = the colour Code for the Box,e.g. fc,08,70,07 etc...don't define it if you want default colour...or type '-' (minus) for no color change...]
rem [%8 = Returns the batbox executable code in this parameter, donot specify it...if you don't want the code...]

rem #kvc

rem :: Visit https://bathprogrammers.blogspot.com for more extensions / plug-ins like this.... :]
rem #TheBATeam

:Box
setlocal Enabledelayedexpansion
set _string=
set "_SpaceWidth=/d ""
set _final=

set x_val=%~1
set y_val=%~2
set sepr=%~5
if /i "!sepr!" == "-" (set sepr=)
set char=%~6
if /i "!char!" == "-" (set char=)
if defined char (set char=!char:~0,1!) ELSE (set "char= ")
set color=%~7
if defined color (if /i "!color!" == "-" (set color=) Else (set "color=/c 0x%~7"))
Set _return=%~8

set _Hor_line=/a 196
set _Ver_line=/a 179
set _Top_sepr=/a 194
set _Base_sepr=/a 193
set _Top_left=/a 218
set _Top_right=/a 191
set _Base_right=/a 217
set _Base_left=/a 192

set /a _Color_char_width=%~4-2
set /a _box_height=%~3-2

for /l %%A in (1,1,!_Color_char_width!) do (
	if /i "%%A" == "%~5" (
	set "_string=!_string! !_Top_sepr!"
	set "_SpaceWidth=!_SpaceWidth!" !_Ver_line! /d ""
	) ELSE (
	set "_string=!_string! !_Hor_line!"
	set "_SpaceWidth=!_SpaceWidth!!char!"
	)
)

set "_SpaceWidth=!_SpaceWidth!""
set "_final=!_final! /g !x_val! !y_val! !_Top_left! !_string! !_Top_right!"
set /a y_val+=1

for /l %%A in (1,1,!_box_height!) do (
set "_final=!_final! /g !x_val! !y_val! !_Ver_line! !_SpaceWidth! !_Ver_line!"
set /a y_val+=1
)

set "_final=!_final! /g !x_val! !y_val! !_Base_left! !_string:194=193! !_Base_right!"
batbox.exe !color! !_final! /c 0x07
endlocal && if "%~8" neq == "" (set "%~8=%color% %_final% /c 0x07 ")
goto :eof

Rem :: ------------------------------------------------------------------------------------------------ ::
Rem ::                             The Button function by kvc
Rem :: ------------------------------------------------------------------------------------------------ ::

:: This Function is created by Kvc At '1:06 AM 5/16/2015'

:: this function prints a Button like interface / image on cmd console...using batbox.exe,getlen.exe
:: you have to specify the text of the button... like "OK, cancel, Retry etc..." as 1st parameter...
:: if the name contains spaces...then use Double quotes to write the name of button in 1st parameter...

:: in 2nd parameter you have to specify the color of the button...in Hex-code...use 'color /?' for help...
:: and the full prepared code of button...that can be executed with batbox.exe in the cmd console is returned
:: in the 3rd parameter...which is nothing, but the name of the variable...e.g. result etc.

:: E.g. : Call button.bat "Button 1" 0a result_1 Y 1 "Button 2" 02 result_2 N 2
:: The Prepared code for the "Button_1" and "Button_2" will be saved in the variables named 'result_1' and 'result_2'...
:: and now you can simply put the button's code anywhere on cmd console using the "Batbox.exe" plugin...

:: E.g. : batbox.exe /o 10 15 %result_1% /o 30 15 %result_2%

:Button
:loop_of_button_fn
setlocal 
set "button_text=%~1"
if not defined button_text (goto :EOF)
set color=%~2
call :corresponding_shade_color "%color:~1,1%" corresponding_shade_1
call :corresponding_shade_color "%color:~0,1%" corresponding_shade_2
set corresponding_shade=%corresponding_shade_2%%corresponding_shade_1%
if not defined color (goto :EOF)
getlen.exe "%button_text%"
set len=%errorlevel%
if not defined len (Echo. getlen.exe is not found in your system... &&pause&&exit /b)
set /a button_width=4+%len%
set "button_text=  %button_text%  "
set gradient=
if /i "%~4" == "Y" set gradient=/c 0x%corresponding_shade% 
if /i "%~5" == "2" (set "element=/a 196")
if /i "%~5" == "3" (set "element=/a 205")
for /l %%a in (1,1,%button_width%) do (set "horizontal_line=!element! !horizontal_line!" && set "free_space= !free_space!")
set /a button_width+=1
if /i "%~5" == "1" (set "code=/c 0x%color% /g 0 0 /d "!free_space!" /g 0 1 /d "!button_text!" %gradient%/g 0 2 /d "!free_space!" /c 0x07")
if /i "%~5" == "2" (set "code=/c 0x%color% /g 0 0 /a 218 !horizontal_line!/a 191 /g 0 1 /a 179 /d "!button_text!" /a 179 %gradient%/g 0 2 /a 192 !horizontal_line! /a 217 /c 0x07")
if /i "%~5" == "3" (set "code=/c 0x%color% /g 0 0 /a 201 !horizontal_line!/a 187 /g 0 1 /a 186 /d "!button_text!" /a 186 %gradient%/g 0 2 /a 200 !horizontal_line! /a 188 /c 0x07")
endlocal && set %~3=%code%
for /l %%a in (1,1,5) do shift /1
goto :loop_of_button_fn

:corresponding_shade_color
if /i "%~1" == "a" set %~2=2
if /i "%~1" == "b" set %~2=3
if /i "%~1" == "c" set %~2=4
if /i "%~1" == "d" set %~2=5
if /i "%~1" == "e" set %~2=6
if /i "%~1" == "f" set %~2=7
for /l %%a in (0,1,9) do if /i "%~1" == "%%a" set %~2=8
goto :eof