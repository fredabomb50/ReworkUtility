;==================================FILE READING
GetServiceTag()
{
	FileRead, s_tag, resources\temp\ServiceTag.txt
	TrayTip , %s_tag% Copied!, ..., 1, 0x1
	return %s_tag%
}


GetDPS()
{
	FileRead, dps, resources\temp\DPS.txt
	TrayTip , %dps% Copied!, ..., 1, 0x1
	return %dps%
}


GetPartNumber(index)
{
	filePath := "resources\temp\ReferenceParts\Part" . index . ".txt"
	FileRead, partNum, %filePath%
	TrayTip , %partNum% Copied!, ..., 1, 0x1
	return %partNum%
}




;==================================FILE WRITING
CheckFileToWrite(file, text)
{
	if (%file% != 0)
	{
		file.Write(%text%)
		file.Close()
	}
	else
	{
		ErrorPrompt(0x03)
	}
}


CreateDirectoryTree()
{
	;if InStr(FileExist("C:\My Folder"), "D")      <<<<use this function to avoid unnecessary directory creation attempts
	FormatTime, FileDate, %A_Now%, MM-dd-yyyy
	WorkingFilePath := "records\" . A_YYYY . "\" . A_MMMM . "\" . FileDate  . ".txt"
	RecordsPath := "records\" . A_YYYY . "\" . A_MMMM . "\"
	FileCreateDir, %RecordsPath%
	todaysFile := FileOpen(WorkingFilePath, "a")

	FileCreateDir, resources\
	FileCreateDir, resources\temp
	FileCreateDir, resources\temp\ReferenceParts\
	dpsFile := FileOpen("resources\temp\DPS.txt", "a")
	serviceTagFile := FileOpen("resources\temp\ServiceTag.txt", "a")
	weeklyFile := FileOpen("resources\temp\WeeklyReport.txt", "a")


	weeklyFile.Close()
	serviceTagFile.Close()
	dpsFile.Close()


	return todaysFile
}


ClearSetTempFiles(PartArray)
{
	;removes everything in the reference parts directory, including itself
	FileRemoveDir, resources\temp\ReferenceParts\, 1

	;re-adds directory
	FileCreateDir, resources\temp\ReferenceParts


	for index, element in PartArray
	{
		file := FileOpen("resources\temp\ReferenceParts\Part" . A_Index . ".txt", "w")
		if !IsObject(file)
		{
			MsgBox, unable to create temp part file
		}
		else
		{
			variableValue := PartArray[A_Index] . "PartNumber"
			file.Write(%variableValue%)
		}
	}

	file.Close()
	return
}



PrintPartEntry(file, name, number, newPPID, oldPPID)
{
	entry = %name%		%number%		%newPPID%		%oldPPID%`n
	file.Write(entry)
	return 0
}


UpdateWeeklyReport(file, date, time, tag)
{
	entry = ===============================================================================================`n%date%	%time%`n%tag%`n`n

	file.Write(entry)
	file.Close()
	return 0
}


UpdateDailyReport(file, time, Tag, Dps)
{
	entryHeader = ===============================================================================================`n%time%`n%Tag%`n%Dps%`n`n

	file.Write(entryHeader)
	return 0
}



;==================================STRINGS
CheckCharacterLength(string, NeededLength)
{
	stringpasses = false


	if (StrLen(string) != NeededLength)
	{
		stringpasses = false
	}
	else
	{
		stringpasses = true
	}


	return stringpasses
}


;==================================TIME AND DATES
CalculateTimeDifference()
{
	tooAged = false
	FormatTime, TimeStamp, %A_Now%, yyyyMMdd
	FileGetTime, FileCreation, resources\temp\7Days.txt, C
	FormatTime, FileCreationDate, %FileAge%, yyyyMMdd
	EnvSub, TimeStamp, %FileCreationDate%, Days
	TimeStamp++

	if (TimeStamp <= 7)
	{
		tooAged = false
	}
	else
	{
		tooAged = true
	}


	return tooAged
}



;==================================DEV
InProgressPrompt()
{
	ErrorPrompt(0x00)
}
