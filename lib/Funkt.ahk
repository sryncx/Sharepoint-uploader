DateWeekYear(){
	Global
WeekOfYear = %A_YDay%
WeekOfYear /= 7
}
UImove(){
PostMessage, 0xA1, 2,,, A
}
FlashGui(){
	Gui Flash
    Sleep 500
}
Bnt_funkt(){
    GuiControl , % HB_Button[ A_GuiControl ].Window ": Focus" , % HB_Button[ A_GuiControl ].Hwnd
    if( ! HB_Button[ A_GuiControl ].Draw_Pressed() )
        return  
}
FINF(){
    WinGet, currentWindow, ID, A
    fade("in",currentWindow)
}

FOUTF(){
    WinGet, currentWindow, ID, A
    fade("out",currentWindow)
}

fade(direction,ID) {
    if (direction = "in")
        transparency := 0
    else
        transparency := 255
    loop
    {
        if (direction = "in")
            transparency += 5
        else
            transparency -= 5
        WinSet, Transparent, %transparency%, ahk_id %ID%
        sleep 10
        if ( transparency >= 255 ) or ( transparency <= 0 )
            break
    }
}

redini(){
	global
	IniRead, LoaderBarVar, %Exicution_path%\BAR.ini, Uploader, Bar
    IniRead, LoaderTXTVar, %Exicution_path%\BAR.ini, Uploader, TXT
	load_Bar.Set(LoaderBarVar ,LoaderTXTVar)
    if (LoaderTXTVar = "LoaderBarGuiDestroy"){
        	Gui, load_BarGUI: destroy
            FileRemoveDir, C:\uploader, 1
        }
       
}