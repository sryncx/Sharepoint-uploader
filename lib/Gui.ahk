;~ ########################################################
;~ GUI Settings
;~ ########################################################

UploaderGui(){
	Global
	
    Gui, +LastFound -Resize -Caption -Border +AlwaysOnTop -DPIScale +HwndGuiHwnd
    Gui, Margin, 10, 10
    Gui, Color, ffffff
    WinSet, Transparent, 0

Gui font, s22, Arial
Gui Add, Picture, x0 y0 h40 w460 gUImove, %A_WorkingDir%\images\titlebar.png
Gui Add, Picture, x0 y40, %A_WorkingDir%\images\bg.png
Gui Add, Picture, x50 y60 h35, %A_WorkingDir%\images\Jahr.png
Gui Add, Picture, x50 y120 h35, %A_WorkingDir%\images\Woche.png
Gui Add, Picture, x50 y180 h35, %A_WorkingDir%\images\Monat.png

Gui Add, Edit,x270 y60 w180 h35 +Center vJahr,
Gui Add, Edit,x270 y120 w180 h35 +Center vWoche,
Gui Add, Edit,x270 y180 w180 h35 +Center vMonat,

Gui Add, Picture, w400 h10 x50 y50, %A_WorkingDir%\images\rahmen.png
Gui Add, Picture, w400 h10 x50 y110, %A_WorkingDir%\images\rahmen.png
Gui Add, Picture, w400 h10 x50 y170, %A_WorkingDir%\images\rahmen.png

Gui Add, Picture, w400 h10 x50 y95, %A_WorkingDir%\images\rahmen.png
Gui Add, Picture, w400 h10 x50 y155, %A_WorkingDir%\images\rahmen.png
Gui Add, Picture, w400 h10 x50 y215, %A_WorkingDir%\images\rahmen.png

Gui Add, Picture, w10 h55 x40 y50, %A_WorkingDir%\images\rahmen.png
Gui Add, Picture, w10 h55 x40 y110, %A_WorkingDir%\images\rahmen.png
Gui Add, Picture, w10 h55 x40 y170, %A_WorkingDir%\images\rahmen.png

Gui Add, Picture, w10 h55 x450 y50, %A_WorkingDir%\images\rahmen.png
Gui Add, Picture, w10 h55 x450 y110, %A_WorkingDir%\images\rahmen.png
Gui Add, Picture, w10 h55 x450 y170, %A_WorkingDir%\images\rahmen.png

Gui, Show, w500 h340

GuiControl,, Jahr, %A_Year%
GuiControl,, Woche, %WeekOfYear%
GuiControl,, Monat, %A_MMMM%
}
;~ ########################################################
;~ Button-GUI Settings
;~ ########################################################
ButtonGui(){
	Global
HB_Button.Push( New HB_Flat_Rounded_Button_Type_1( x:=50   , y:=240 , w:=100 , h:=35 , Button_Color := "865ABB" , Button_Background_Color := "333333" , Text := "Elemte-Upload" , Font := "Arial" , Font_Size := 10 " Bold" , Font_Color_Top := "ddddddd" , Font_Color_Bottom := "111111" , Window := "1" , Label := "B1" , Default_Button := 2 , Roundness:=3 ) )

HB_Button.Push( New HB_Flat_Rounded_Button_Type_1( x+=w+50 , y:=240 , w:=100 , h:=35 , Button_Color := "865ABB" , Button_Background_Color := "333333" , Text := "Statistik-Upload" , Font := "Arial" , Font_Size := 10 " Bold" , Font_Color_Top := "ddddddd" , Font_Color_Bottom := "111111" , Window := "1" , Label := "B2" , Default_Button := 2 , Roundness:=3 ) )

HB_Button.Push( New HB_Flat_Rounded_Button_Type_1( x+=w+50 , y:=240 , w:=100 , h:=35 , Button_Color := "865ABB" , Button_Background_Color := "333333" , Text := "Modell-Upload" , Font := "Arial" , Font_Size := 10 " Bold" , Font_Color_Top := "ddddddd" , Font_Color_Bottom := "111111" , Window := "1" , Label := "B3" , Default_Button := 2 , Roundness:=3 ) )

HB_Button.Push( New HB_Flat_Rounded_Button_Type_1( x:=460  , y:=0 , w:=40 , h:=40 , Button_Color := "865ABB" , Button_Background_Color := "333333" , Text := "X" , Font := "Arial" , Font_Size := 25 " Bold" , Font_Color_Top := "cccccc" , Font_Color_Bottom := "111111" , Window := "1" , Label := "B4" , Default_Button := 1 , Roundness:=5 ) )	
}
;~ ########################################################
;~ LoaderBar-GUI Settings
;~ ########################################################
LoaderBarGuiBorder(){
	
	Global BorderTopBarGUI
	Global BorderBottomBarGUI
	Global BorderLeftBarGUI
	Global BorderRightBarGUI
	
	Gui, load_BarGUI:Add, Picture, vBorderTopBarGUI, %A_WorkingDir%\images\border-top-normal.png
	Gui, load_BarGUI:Add, Picture, vBorderBottomBarGUI, %A_WorkingDir%\images\border-outer-normal.png
	Gui, load_BarGUI:Add, Picture, vBorderLeftBarGUI, %A_WorkingDir%\images\border-outer-normal.png
	Gui, load_BarGUI:Add, Picture, vBorderRightBarGUI, %A_WorkingDir%\images\border-outer-normal.png

	GuiControl, load_BarGUI: MoveDraw, BorderTopBarGUI, % "x" 1 " y" 0 " w" 496 " h" 3
	GuiControl, load_BarGUI: MoveDraw, BorderBottomBarGUI, % "x" 0 " y" 50 " w" 496 " h" 3
	GuiControl, load_BarGUI: MoveDraw, BorderLeftBarGUI, % "x" 0 " y" 0 " w" 3 " h" 53
	GuiControl, load_BarGUI: MoveDraw, BorderRightBarGUI, % "x" 496 " y" 0 " w" 3 " h" 53

}
LoaderBarGUIPos(){
	Global
Gui,+LastFound
	WinGetPos,Uploader_X,Uploader_Y,Uploader_W,Uploader_H
	LoaderBarX := Uploader_X + Uploader_W - 500
	LoaderBarY := Uploader_Y + Uploader_H - 1
}
LoaderBarGui(){
	global
	Gui, load_BarGUI:-Border -Caption +ToolWindow +AlwaysOnTop -DPIScale +hwndLoader_bar_Uploader
	Gui, load_BarGUI:Color, 0x4D4D4D, 0xFFFFFF	
	load_Bar := new LoaderBar("load_BarGUI",3,3,494,30,1,"EFEFEF")
	wW:=load_Bar.Width + 2*load_Bar.X
	wH:=load_Bar.Height + 2*load_Bar.Y
LoaderBarGuiBorder()
	Gui, load_BarGUI:Show, x%LoaderBarX% y%LoaderBarY% w%wW% h%wH%
}