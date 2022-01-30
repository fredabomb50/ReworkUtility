;==================================SETTINGS
#NoEnv   ; Recommended for performance and compatibility with future AutoHotkey releases.
SetWorkingDir %A_ScriptDir%
SendMode Input
CoordMode, Mouse, Screen
SetTitleMatchMode, 2
DetectHiddenWindows, On


;==================================INCLUDES
#Include err.ahk
#Include functions.ahk


;==================================GLOBALS
global WorkingFile := CreateDirectoryTree()
global Partnames := []
global WeeklyReportList := []
global checkedPart = ""
global WeeklyReportPath := "resources\temp\WeeklyReport.txt"
FormatTime, FileDate, %A_Now%, MM-dd-yyyy
global WorkingFilePath := "records\" . A_YYYY . "\" . A_MMMM . "\" . FileDate  . ".txt"

;initializes to false, given the context that the app only needs to be ran once a day
global fileCreated = false

;int for checking currently active GUI --- LOOKING TO REPLACE THIS WITH HWND
global ActiveGui = 1

;will want to create arrays of gui controls to reset and read from in loops
