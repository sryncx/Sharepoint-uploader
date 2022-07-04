#include %A_ScriptDir%\lib
#Include bnt.ahk
#Include Funkt.ahk
#Include Gui.ahk
#Include LoaderBar.ahk
#Include Prog.ahk
#Include Var.ahk
;~ ########################################################
;~ Auto-Execute
;~ ########################################################
#SingleInstance, Force ; Allow only one running instance of script
#Persistent ; Keep the script permanently running until terminated
#NoEnv ; Avoid checking empty variables for environment variables
#ErrorStdOut ; Deisables all Error msg´s
;~ #Warn ; Enable warnings to assist with detecting common errors
;~ #NoTrayIcon ; Disable the tray icon of the script
SetWorkingDir, % A_ScriptDir ; Set the working directory of the script
SetBatchLines, -1 ; The speed at which the lines of the script are executed
SendMode, Input ; The method for sending keystrokes and mouse clicks
DetectHiddenWindows, On ; The visibility of hidden windows by the script
SetWinDelay, -1 ; The delay to occur after modifying a window
SetControlDelay, -1 ; The delay to occur after modifying a control
;~ ########################################################
;~ Load Funktions
;~ ########################################################
DateWeekYear()
UploaderGui()
ButtonGui()
FINF()
;~ ########################################################
;~ Timers
;~ ########################################################
SetTimer, HB_Button_Hover, 50
SetTimer, FlashGui
SetTimer, redini, 500
return