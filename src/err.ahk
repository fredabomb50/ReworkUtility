logFile := FileOpen(Log.txt, "w")
logFile.Close()


ErrorPrompt(HexValue)
{
	switch HexValue
	{
		Case 0x00:
			MsgBox, , FUNCTION - %HexValue%, Not yet implemented!
		return

		Case 0x01:
			MsgBox, , CRITICAL ERROR - %HexValue%, Unable to open today's file.
		return

		Case 0x02:
			MsgBox, , CRITICAL ERROR - %HexValue%, Part list mismatch, using back up.
		return

		Case 0x03:
			MsgBox, , CRITICAL ERROR - %HexValue%, Unable to open Weekly file.
		return

		Case 0x04:
			MsgBox, , UNHANDLED VALUE - %HexValue%, GUI # does not exist
		return

		Case 0x05:
			MsgBox, , TEST - %HexValue%, Unable to open today's file.
		return

		Case 0x06:
			MsgBox, , CRITICAL ERROR - %HexValue%, Unable to create Directory Tree
		return

		Case 0x0a:
			MsgBox, ,INPUT ERROR - %HexValue%, Invalid Service Tag Format
		return

		Case 0x0b:
			MsgBox, ,INPUT ERROR - %HexValue%, Invalid DPS Format
		return

		Case 0x0c:
			MsgBox, ,AGED FILE - %HexValue%, 7 day report aged. Will be backed up.
		return
	}
	return 0
}

PrintToLog(file, result, entry)
{
	if (result)
	{
		log = SUCCESS..........%entry%`n
	}
	else
	{
		log = FAILURE..........%entry%`n
	}

	file.Write(log)
	file.Close()
	return 0
}
