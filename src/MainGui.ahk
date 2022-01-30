;==================================INCLUDES
#include header.ahk


;==================================INITIALIZATION

;confirm that working file exists, as this also ensures that directory tree works
if !IsObject(WorkingFile)
{
	ErrorPrompt(0x01)
}
else
{
	WorkingFile.Close()
}


Loop, Read, WeeklyReport.txt
{
	WeeklyReportList.Push(A_LoopReadLine)
}


;this literally doesn't work. will need to update function
weekReportTooOld := CalculateTimeDifference()
if (weekReportTooOld == true)
{
	ErrorPrompt(0x0c)
	weekReportBackUp := FileOpen(WeeklyReportBackUp.txt, "a")
	Loop, Read, WeeklyReport.txt
	{
		weekReportBackUp.Write(%A_LoopReadLine%`n)
	}
	weekReportBackUp.Close()
	weekReport := FileOpen(WeeklyReport.txt, "w")
}
else
{
	;do nothing
}


FileGetSize, CheckA, resources\parts\AAA.txt																																	;file size of primary part list, saved to 'CheckA'
FileGetSize, CheckZ, resources\parts\ZZZ.txt																																	;file size of back-up part list, saved to 'CheckZ'
if (CheckA > CheckZ)
{
	FileDelete, resources\parts\ZZZ.txt
	Loop, Read, resources\parts\AAA.txt
	{
		FileAppend, %A_LoopReadLine%`n, resources\parts\ZZZ.txt																									;get rid of the escape n for funny lamp meme
	}
}
else if (CheckA < CheckZ - 2)																																								;minus 2, to account for the extra carriage return byte added by the last `n added CR;LF
{
	Loop, Read, resources\parts\ZZZ.txt
	{
		Partnames.Push(A_LoopReadLine)
	}
	ErrorPrompt(0x02)
}
else
{
	Loop, Read, resources\parts\AAA.txt
	{
		Partnames.Push(A_LoopReadLine)
	}
}
;==================================VARIABLES==================================


;==================================GUI ELEMENTS===============================
Gui,10:New,, Get Started!
Gui 10:Add, Button, w90 gSignIn, Sign-In
Gui 10:Add, Button, w90 x+75 gSkipSignIn, Skip
Gui 10:Show


Gui,11:New,, Enter Work mode:
Gui 11:Add, Button, w90  gReworkMode, Rework
Gui 11:Add, Button, w90 y+15 gDebugMode, Debug
Gui 11:Add, Text, x+15 y10, (ctrl+alt+o) = Opens today's file.
Gui 11:Add, Text,, (ctrl+alt+t) = Scrolls down to "DELL_AIO_RTV"
Gui 11:Add, Text,, (ctrl+alt+m) = Scrolls down to "DELL_AIO_DMR"
Gui 11:Add, Text,, (ctrl+alt+d) = Creates a divider line.
Gui 11:Add, Text,, (ctrl+alt+s) = Shows the current gui.
Gui 11:Add, Text,, (ctrl+alt+Numpad1) = copies the "first-in-line" part number.
Gui 11:Hide


Gui,12:New,, Check General Tools
Gui 12:Add, Edit, vDebugServiceTag w80, Service Tag
Gui 12:Add, Button, w90 y+10 gFindDevice, Check Weekly
Gui 12:Add, Button, w90 x+75 gBackToMain, Main
Gui 12:Hide


Gui,1:New,, Check Parts For Rework
Gui 1:Add, CheckBox, w115 x10 y10 vACAD, ACAD
Gui 1:Add, CheckBox, w115 y+5 vBattery, Battery
Gui 1:Add, CheckBox, w115 y+5 vBatteryCable, Battery Cable
Gui 1:Add, CheckBox, w115 y+5 vBottomCover, Bottom Cover
Gui 1:Add, CheckBox, w115 y+5 vCamera, Camera
Gui 1:Add, CheckBox, w115 y+5 vCoinBattery, CoinBattery
Gui 1:Add, CheckBox, w115 y+5 vCPUFan, CPUFan
Gui 1:Add, CheckBox, w115 y+5 vDCIN, DC-IN Jack
Gui 1:Add, CheckBox, w115 y+5 vEDP, EDP
Gui 1:Add, CheckBox, w115 y+5 vGPUFan, GPUFan
Gui 1:Add, CheckBox, w115 y+5 vHDD, HDD
Gui 1:Add, CheckBox, w115 y+5 vHDDBracket, HDDBracket
Gui 1:Add, CheckBox, w115 y+5 vHDDCable, HDDCable
Gui 1:Add, CheckBox, w115 y+5 vHeatsink, Heatsink
Gui 1:Add, CheckBox, w115 x140 y10 vHUD, HUD
Gui 1:Add, CheckBox, w115 y+5 vIOBoard, IOBoard
Gui 1:Add, CheckBox, w115 y+5 vIOCable, IOCable
Gui 1:Add, CheckBox, w115 y+5 vKeyboard, Keyboard
Gui 1:Add, CheckBox, w115 y+5 vLCD, LCD
Gui 1:Add, CheckBox, w115 y+5 vLCDBevel, LCD Bevel
Gui 1:Add, CheckBox, w115 y+5 vLCDCover, LCDCover
Gui 1:Add, CheckBox, w115 y+5 vMemory, Memory
Gui 1:Add, CheckBox, w115 y+5 vMotherboard, Motherboard
Gui 1:Add, CheckBox, w115 y+5 vODD, ODD
Gui 1:Add, CheckBox, w115 y+5 vODDBoard, ODD Board
Gui 1:Add, CheckBox, w115 y+5 vPalmrest, Palmrest
Gui 1:Add, CheckBox, w115 y+5 vPowerBoard, PowerBoard
Gui 1:Add, CheckBox, w115 y+5 vPowerButton, PowerButton
Gui 1:Add, CheckBox, w115 x270 y10 vPowerCord, PowerCord
Gui 1:Add, CheckBox, w115 y+5 vSDD, SDD
Gui 1:Add, CheckBox, w115 y+5 vSDDBracket, SDDBracket
Gui 1:Add, CheckBox, w115 y+5 vSpeaker, Speaker
Gui 1:Add, CheckBox, w115 y+5 vStylus, Stylus
Gui 1:Add, CheckBox, w115 y+5 vTopCover, Top Cover
Gui 1:Add, CheckBox, w115 y+5 vTouchpad, Touchpad
Gui 1:Add, CheckBox, w115 y+5 vTouchpadBracket, TouchpadBracket
Gui 1:Add, CheckBox, w115 y+5 vTouchpadCable, TouchpadCable
Gui 1:Add, CheckBox, w115 y+5 vUSBBracket, USBBracket
Gui 1:Add, CheckBox, w115 y+5 vWifiBracket, WifiBracket
Gui 1:Add, CheckBox, w115 y+5 vWifiCard, WifiCard
Gui 1:Add, Button, w90 x+10 y10 gBackToMain, Main
Gui 1:Add, Button, w90 y+10 gAddPartNums, Part Numbers
Gui 1:Add, Edit, vServiceTag w80, Service Tag
Gui 1:Add, Edit, vDPS w80, DPS
Gui 1:Add, Button, w90 y+10 gResetFields, Reset
Gui 1:Hide


Gui,2:New,, Enter your part numbers
Gui 2:Add, Edit, vACADPartNumber w100 x10 y10, ACAD
Gui 2:Add, Edit, vBatteryPartNumber w100, Battery
Gui 2:Add, Edit, vBatteryCablePartNumber w100, BatteryCable
Gui 2:Add, Edit, vBottomCoverPartNumber w100, BottomCover
Gui 2:Add, Edit, vCameraPartNumber w100, Camera
Gui 2:Add, Edit, vCoinBatteryPartNumber w100, CoinBattery
Gui 2:Add, Edit, vCPUFanPartNumber w100, CPUFan
Gui 2:Add, Edit, vDCINPartNumber w100,  DCIN
Gui 2:Add, Edit, vEDPPartNumber w100,  EDP
Gui 2:Add, Edit, vGPUFanPartNumber w100, GPUFan
Gui 2:Add, Edit, vHDDPartNumber w100,  HDD
Gui 2:Add, Edit, vHDDBracketPartNumber w100, HDDBracket
Gui 2:Add, Edit, vHDDCablePartNumber w100,  HDDCable
Gui 2:Add, Edit, vHeatsinkPartNumber w100 x115 y10,  Heatsink
Gui 2:Add, Edit, vHUDPartNumber w100,  HUD
Gui 2:Add, Edit, vIOBoardPartNumber w100, IOBoard
Gui 2:Add, Edit, vIOCablePartNumber w100, IOCable
Gui 2:Add, Edit, vKeyboardPartNumber w100,  Keyboard
Gui 2:Add, Edit, vLCDPartNumber w100,  LCD
Gui 2:Add, Edit, vLCDBevelPartNumber w100,  LCDBevel
Gui 2:Add, Edit, vLCDCoverPartNumber w100, LCDCover
Gui 2:Add, Edit, vMemoryPartNumber w100, Memory
Gui 2:Add, Edit, vMotherboardPartNumber w100,  Motherboard
Gui 2:Add, Edit, vODDPartNumber w100, ODD
Gui 2:Add, Edit, vODDBoardPartNumber w100,  ODDBoard
Gui 2:Add, Edit, vPalmrestPartNumber w100,  Palmrest
Gui 2:Add, Edit, vPowerBoardPartNumber w100, PowerBoard
Gui 2:Add, Edit, vPowerButtonPartNumber w100, PowerButton
Gui 2:Add, Edit, vPowerCordPartNumber w100 x220 y10, PowerCord
Gui 2:Add, Edit, vSDDPartNumber w100,  SDD
Gui 2:Add, Edit, vSDDBracketPartNumber w100, SDDBracket
Gui 2:Add, Edit, vSpeakerPartNumber w100, Speaker
Gui 2:Add, Edit, vStylusPartNumber w100, Stylus
Gui 2:Add, Edit, vTopCoverPartNumber w100,  TopCover
Gui 2:Add, Edit, vTouchpadPartNumber w100,  Touchpad
Gui 2:Add, Edit, vTouchpadBracketPartNumber w100, TouchpadBracket
Gui 2:Add, Edit, vTouchpadCablePartNumber w100,  TouchpadCable
Gui 2:Add, Edit, vUSBBracketPartNumber w100, USBBracket
Gui 2:Add, Edit, vWifiBracketPartNumber w100, WifiBracket
Gui 2:Add, Edit, vWifiCardPartNumber w100,  WifiCard
Gui 2:Add, Button, w90 y10 gGUI2Submit, Submit
Gui 2:Add, Button, w90 y+10 gResetFields, Reset
Gui 2:Add, Button, w90 y+10 gBackTo1, Back
Gui 2: Hide


Gui,3:New,, Enter your -NEW- PPIDs
Gui 3:Add, Edit, vACADPPIDn w100 x10 y10, ACAD
Gui 3:Add, Edit, vBatteryPPIDn w100, Battery
Gui 3:Add, Edit, vBatteryCablePPIDn w100, BatteryCable
Gui 3:Add, Edit, vBottomCoverPPIDn w100, BottomCover
Gui 3:Add, Edit, vCameraPPIDn w100, Camera
Gui 3:Add, Edit, vCoinBatteryPPIDn w100, CoinBattery
Gui 3:Add, Edit, vCPUFanPPIDn w100, CPUFan
Gui 3:Add, Edit, vDCINPPIDn w100,  DCIN
Gui 3:Add, Edit, vEDPPPIDn w100,  EDP
Gui 3:Add, Edit, vGPUFanPPIDn w100, GPUFan
Gui 3:Add, Edit, vHDDPPIDn w100,  HDD
Gui 3:Add, Edit, vHDDBracketPPIDn w100, HDDBracket
Gui 3:Add, Edit, vHDDCablePPIDn w100,  HDDCable
Gui 3:Add, Edit, vHeatsinkPPIDn w100 x115 y10,  Heatsink
Gui 3:Add, Edit, vHUDPPIDn w100,  HUD
Gui 3:Add, Edit, vIOBoardPPIDn w100, IOBoard
Gui 3:Add, Edit, vIOCablePPIDn w100, IOCable
Gui 3:Add, Edit, vKeyboardPPIDn w100,  Keyboard
Gui 3:Add, Edit, vLCDPPIDn w100,  LCD
Gui 3:Add, Edit, vLCDBevelPPIDn w100,  LCDBevel
Gui 3:Add, Edit, vLCDCoverPPIDn w100, LCDCover
Gui 3:Add, Edit, vMemoryPPIDn w100, Memory
Gui 3:Add, Edit, vMotherboardPPIDn w100,  Motherboard
Gui 3:Add, Edit, vODDPPIDn w100, ODD
Gui 3:Add, Edit, vODDBoardPPIDn w100,  ODDBoard
Gui 3:Add, Edit, vPalmrestPPIDn w100,  Palmrest
Gui 3:Add, Edit, vPowerBoardPPIDn w100, PowerBoard
Gui 3:Add, Edit, vPowerButtonPPIDn w100, PowerButton
Gui 3:Add, Edit, vPowerCordPPIDn w100 x220 y10, PowerCord
Gui 3:Add, Edit, vSDDPPIDn w100,  SDD
Gui 3:Add, Edit, vSDDBracketPPIDn w100, SDDBracket
Gui 3:Add, Edit, vSpeakerPPIDn w100, Speaker
Gui 3:Add, Edit, vStylusPPIDn w100, Stylus
Gui 3:Add, Edit, vTopCoverPPIDn w100,  TopCover
Gui 3:Add, Edit, vTouchpadPPIDn w100,  Touchpad
Gui 3:Add, Edit, vTouchpadBracketPPIDn w100, TouchpadBracket
Gui 3:Add, Edit, vTouchpadCablePPIDn w100,  TouchpadCable
Gui 3:Add, Edit, vUSBBracketPPIDn w100, USBBracket
Gui 3:Add, Edit, vWifiBracketPPIDn w100, WifiBracket
Gui 3:Add, Edit, vWifiCardPPIDn w100,  WifiCard
Gui 3:Add, Button, w90 y10 gAddOldPPIDs, Old PPIDs
Gui 3:Add, Button, w90 y+10 gResetFields, Reset
Gui 3:Add, Button, w90 y+10 gBackTo2, Back
Gui 3:Hide


Gui,4:New,, Enter your -OLD- PPIDs
Gui 4:Add, Edit, vACADPPIDo w100 x10 y10, ACAD
Gui 4:Add, Edit, vBatteryPPIDo w100, Battery
Gui 4:Add, Edit, vBatteryCablePPIDo w100, BatteryCable
Gui 4:Add, Edit, vBottomCoverPPIDo w100, BottomCover
Gui 4:Add, Edit, vCameraPPIDo w100, Camera
Gui 4:Add, Edit, vCoinBatteryPPIDo w100, CoinBattery
Gui 4:Add, Edit, vCPUFanPPIDo w100, CPUFan
Gui 4:Add, Edit, vDCINPPIDo w100,  DCIN
Gui 4:Add, Edit, vEDPPPIDo w100,  EDP
Gui 4:Add, Edit, vGPUFanPPIDo w100, GPUFan
Gui 4:Add, Edit, vHDDPPIDo w100,  HDD
Gui 4:Add, Edit, vHDDBracketPPIDo w100, HDDBracket
Gui 4:Add, Edit, vHDDCablePPIDo w100,  HDDCable
Gui 4:Add, Edit, vHeatsinkPPIDo w100 x115 y10,  Heatsink
Gui 4:Add, Edit, vHUDPPIDo w100,  HUD
Gui 4:Add, Edit, vIOBoardPPIDo w100, IOBoard
Gui 4:Add, Edit, vIOCablePPIDo w100, IOCable
Gui 4:Add, Edit, vKeyboardPPIDo w100,  Keyboard
Gui 4:Add, Edit, vLCDPPIDo w100,  LCD
Gui 4:Add, Edit, vLCDBevelPPIDo w100,  LCDBevel
Gui 4:Add, Edit, vLCDCoverPPIDo w100, LCDCover
Gui 4:Add, Edit, vMemoryPPIDo w100, Memory
Gui 4:Add, Edit, vMotherboardPPIDo w100,  Motherboard
Gui 4:Add, Edit, vODDPPIDo w100, ODD
Gui 4:Add, Edit, vODDBoardPPIDo w100,  ODDBoard
Gui 4:Add, Edit, vPalmrestPPIDo w100,  Palmrest
Gui 4:Add, Edit, vPowerBoardPPIDo w100, PowerBoard
Gui 4:Add, Edit, vPowerButtonPPIDo w100, PowerButton
Gui 4:Add, Edit, vPowerCordPPIDo w100 x220 y10, PowerCord
Gui 4:Add, Edit, vSDDPPIDo w100,  SDD
Gui 4:Add, Edit, vSDDBracketPPIDo w100, SDDBracket
Gui 4:Add, Edit, vSpeakerPPIDo w100, Speaker
Gui 4:Add, Edit, vStylusPPIDo w100, Stylus
Gui 4:Add, Edit, vTopCoverPPIDo w100,  TopCover
Gui 4:Add, Edit, vTouchpadPPIDo w100,  Touchpad
Gui 4:Add, Edit, vTouchpadBracketPPIDo w100, TouchpadBracket
Gui 4:Add, Edit, vTouchpadCablePPIDo w100,  TouchpadCable
Gui 4:Add, Edit, vUSBBracketPPIDo w100, USBBracket
Gui 4:Add, Edit, vWifiBracketPPIDo w100, WifiBracket
Gui 4:Add, Edit, vWifiCardPPIDo w100,  WifiCard
Gui 4:Add, Button, w90 y10 gAppendToFile, Add Entry
Gui 4:Add, Button, w90 y10 gBackToMain, Main
Gui 4:Add, Button, w90 y+10 gResetFields, Reset
Gui 4:Add, Button, w90 y+10 gBackTo3, Back
Gui 4:Hide
return
;==================================GUI ELEMENTS===============================

;==================================GUI G LABELS===============================
;==========GUI 10 g-labels
SignIn:
	ActiveGui = 11
	Gui 10:Hide
	Gui 11:Show
return

SkipSignIn:
	ActiveGui = 11
	Gui 10:Hide
	Gui 11:Show
return


;==========GUI 11 g-labels
ReworkMode:
	ActiveGui = 1
	Gui 11:Hide
	Gui 1:Show
return

DebugMode:
	ActiveGui = 12
	Gui 11:Hide
	Gui 12:Show
return


;==========GUI 12 g-labels
FindDevice:
Gui 12: Submit, NoHide
	SearchInWeeklyReport(WeeklyReportList, DebugServiceTag)
return


;==========GUI 1 g-labels
AddPartNums:
	Gui 1: Submit, NoHide
	tempbool := CheckCharacterLength(ServiceTag, 7)

	if (%tempbool%)
	{
		if DPS is not integer
		{
			ErrorPrompt(0x0b)
		}
		else
		{
			FileDelete, resources\temp\ServiceTag.txt
			FileAppend, %ServiceTag%, resources\temp\ServiceTag.txt
			FileDelete, resources\temp\DPS.txt
			FileAppend, %DPS%, resources\temp\DPS.txt

			ActiveGui = 2
			CheckAllParts()
			Gui 1: Hide
			Gui 2: Show

			return
		}
	}
	else
	{
		ErrorPrompt(0x0a)
	}


;==========GUI 2 g-labels
BackTo1:
	ActiveGui = 1
	Gui 2: Hide
	Gui 1: Show
return

GUI2Submit:
	ActiveGui = 3
	Gui 2: Submit
	CheckAllParts()
	Gui 3: Show
return


;==========GUI 3 g-labels
BackTo2:
	ActiveGui = 2
	Gui 2: Show
	Gui 3: Hide
return

AddOldPPIDs:
	ActiveGui = 4
	Gui 3: Submit
	CheckAllParts()
	Gui 4: Show
return


;==================================GUI 4 G-LABELS
BackToMain:
	returnToMain()
return

BackTo3:
	ActiveGui = 3
	Gui 4: Hide
	Gui 3: Show
return


AppendToFile:
	FileID := WinExist(FileDate - Notepad)
	MsgBox, 0x4, Confirm, Are you sure? You will be kicked back to the start
		IfMsgBox, Yes
		{
			if (%FileID% != 0)
			{
				WinClose, %FileDate% - Notepad
			}
			Gui 4: Submit, NoHide
			FormatTime, Now,, Time
			FormatTime, Today,, ShortDate

			WorkingFile := FileOpen(WorkingFilePath, "a")
			WeeklyFile := FileOpen(WeeklyReport.txt, "a")
			UpdateWeeklyReport(WeeklyFile, Today, Now, ServiceTag)
			UpdateDailyReport(WorkingFile, Now, ServiceTag, DPS)
			PrintPartsList(WorkingFile)

			WorkingFile.Close()
			ResetAllFieldsInGui(true, true)
			returnToMain()
		}
		else
		{
			; do nothing
		}
return


;==================================MISC G-LABELS
ResetFields:
ResetAllFieldsInGui(false, false)
return

GuiEscape:
GuiClose:
ExitApp



;==================================HOTKEYS===================================
;**********SHOWS GUIONE INTERFACE*************
^!s::
	CurrentWindow := WinExist(FileDate - Notepad)
	if(%CurrentWindow% != 0)
	{
		WinClose, %FileDate% - Notepad
	}
	Gui %ActiveGui%: Show
return

;**********WHEN REMOVING PART, THIS DIRECTLY MOVES TO DELL_AIO_RTV*************
^!t::
	Send, DELL_AIO_RTV{Tab}
return


;**********WHEN MOVING TO DMR, THIS DIRECTLY MOVES TO DELL_AIO_DMR*************
^!m::
	Send, DELL_AIO_DMR{Tab}


;**********ADD DIVIDER MADE OF EQUAL SIGNS*************
^!d::
	SendRaw, ===============================================================================================
	Send, {Enter}
return

;**********OPEN TODAY'S WORKING DOCUMENT*************
^!o::
	CurrentWindow := WinExist(FileDate - Notepad)
	if(%CurrentWindow% != 0)
	{
		WinClose, %FileDate% - Notepad
		Run, %WorkingFilePath%, Maximize, vPID
		Sleep, 500
		WinActivate, ahk_pid %vPID%
	}
	else
	{
		Run, %WorkingFilePath%, Maximize, vPID
		WinActivate, ahk_pid %vPID%
	}
return


^!Numpad1::
	part1 := GetPartNumber(1)
	Send, %part1%
return

^!Numpad2::
	part2 := GetPartNumber(2)
	Send, %part2%
return

^!Numpad3::
	part3 := GetPartNumber(3)
	Send, %part3%
return

^!Numpad4::
	part4 := GetPartNumber(4)
	Send, %part4%
return

^!Numpad5::
	part5 := GetPartNumber(5)
	Send, %part5%
return
;==================================HOTKEYS===================================


;==================================HOTSTRINGS===================================
:*:gstag::
	s_tag := GetServiceTag()
	Send, %s_tag%
	return


:*:gdps::
	dps := GetDPS()
	Send, %dps%
	return


:://trolly::Trolly10


:*://login::
	Send, username{Tab}password
	return


:*://validation::parts replaced:{Enter}


:*://epsa::passed OS, ePSA ready


:*://final::passed ePSA, passed OS, final test ready


:*://bitlocker::passed ePSA, bitlocker in-place, OSRI approved, QR ready


:*://qr::passed ePSA, OSRI approved, QR ready
;==================================HOTSTRINGS===================================


;==================================FUNCTIONS=================================

ResetAllFieldsInGui(DoAll, ignorePrompt)
{
	If (DoAll = true)
	{
		ActiveGui = 1
		ResetAllFieldsInGui(false, true)

		ActiveGui = 2
		ResetAllFieldsInGui(false, true)

		ActiveGui = 3
		ResetAllFieldsInGui(false, true)

		ActiveGui = 4
		ResetAllFieldsInGui(false, true)
	}

	if (ignorePrompt = true)
	{
		for index, element in Partnames
		{
			ResetPartNumber(Partnames[A_Index])
		}
	}
	else
	{
		MsgBox, 0x4, Confirm, Are you sure?
		IfMsgBox, Yes
		{
			for index, element in Partnames
			{
				ResetPartNumber(Partnames[A_Index])
			}
		}
		else
		{
			;do nothing
		}
	}
}


ResetPartNumber(PartName)
{
	switch ActiveGui
	{
		Case 1:
			Part := PartName
			GuiControl, 1: Text, ServiceTag, Service Tag
			GuiControl, 1: Text, DPS, DPS
			GuiControl, 1:, %Part%, 0
		return

		Case 2:
			Part := PartName . "PartNumber"
			GuiControl, 2:, %Part%, %PartName%
		return

		Case 3:
			Part := PartName . "PPID" . "n"
			GuiControl, 3:, %Part%, %PartName%
		return

		Case 4:
			Part := PartName . "PPID" . "o"
			GuiControl, 4:, %Part%, %PartName%
		return

		Default:
			ErrorPrompt(0x04)
		return
	}
}


CheckAllParts()
{
	for index, element in Partnames
	{
		CheckPart(Partnames[A_Index], Partnames[A_Index])
	}
	return
}


CheckPart(result, PartName)
{
	switch ActiveGui
	{
		Case 1:
			;do nothing
		return

		Case 2:
			checkedPart := PartName . "PartNumber"
			if (%result% == 0)
			{
				GuiControl, 2: Disable, %checkedPart%
			}
			else
			{
				GuiControl, 2: Enable, %checkedPart%
			}
			return

		Case 3:
			checkedPart := PartName . "PPID" . "n"
			if (%result% == 0)
			{
				GuiControl, 3: Disable, %checkedPart%
			}
			else
			{
				GuiControl, 3: Enable, %checkedPart%
			}
		return

		Case 4:
			checkedPart := PartName . "PPID" . "o"
			if (%result% == 0)
			{
				GuiControl, 4: Disable, %checkedPart%
			}
			else
			{
				GuiControl, 4: Enable, %checkedPart%
			}
		return

		Default:
			ErrorPrompt(0x04)
		return
	}
}


PrintPartsList(file)
{
	validElementArray := []
	for index, element in Partnames
	{
		result := Partnames[A_Index]
		if (%result% > 0)
		{
			validElementArray.Push(Partnames[A_Index])
		}
	}

	ClearSetTempFiles(validElementArray)

	for index, element in validElementArray
	{
		tempPartNumber := validElementArray[A_Index] . "PartNumber"
		tempNewPPID := validElementArray[A_Index] . "PPID" . "n"
		tempOldPPID := validElementArray[A_Index] . "PPID" . "o"
		PrintPartEntry(file, validElementArray[A_Index], %tempPartNumber%, %tempNewPPID%, %tempOldPPID%)
	}

	file.Close()
	return
}


returnToMain()
{
	GUI %ActiveGui%: Hide
	GUI 11: Show
	ActiveGui = 11
}


;==================================FUNCTIONS=================================
SearchInWeeklyReport(ArrayIn, ValueToFind)
{
	;Location := InStr(%ArrayIn%, %ValueToFind%, false, 1, 1)			;send cursor to first found instance
	Run, resources\temp\7Days.txt, vPID
	Sleep, 500
	WinActivate, 7Days - Notepad
	Sleep, 500
	Send, ^f
	Sleep, 100
	Send,%ValueToFind%{Enter}
}
