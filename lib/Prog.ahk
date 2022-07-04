B1(){
	Global
Bnt_funkt()
	Gui, Submit, NoHide
		LoaderBarGUIPos()
		LoaderBarGui()

		load_Bar.Set(25 ,"Updating Year Value")
	IniWrite, %Jahr%, %A_WorkingDir%\bib\Uploader.ini, Uploader_Elemente, Year
		load_Bar.Set(50 ,"Updating Week Value")
	IniWrite, %Woche%, %A_WorkingDir%\bib\Uploader.ini, Uploader_Elemente, Week
		load_Bar.Set(80 ,"Copy Files")
	FileCopyDir, %A_WorkingDir%\bib, %Exicution_path%
		load_Bar.Set(90 ,"Run Upload")
		sleep, 1000
	RunWait, C:\uploader\elemente.ps1, ;,hide
}
B2(){
	Global
Bnt_funkt()
	Gui, Submit, NoHide
		LoaderBarGUIPos()
		LoaderBarGui()

		load_Bar.Set(5 ,"Updating Year Value")
	IniWrite, %Jahr%, %A_WorkingDir%\bib\uploader.ini, Uploader_Statistik, Year
		load_Bar.Set(10 ,"Updating Month Value")
	IniWrite, %Monat%, %A_WorkingDir%\bib\uploader.ini, Uploader_Statistik, Month
		load_Bar.Set(80 ,"Copy Files")
	FileCopyDir, %A_WorkingDir%\bib, %Exicution_path%
		load_Bar.Set(90 ,"Run Upload")
		sleep, 1000
	RunWait, C:\uploader\statistik.ps1, ;,hide
}
B3(){
	Global
Bnt_funkt()
	Gui, Submit, NoHide
		LoaderBarGUIPos()
		LoaderBarGui()

		load_Bar.Set(5 ,"Updating Year Value")
	IniWrite, %Jahr%, %A_WorkingDir%\bib\uploader.ini, Uploader_Modell, Year
		load_Bar.Set(10 ,"Updating Month Value")
	IniWrite, %Monat%, %A_WorkingDir%\bib\uploader.ini, Uploader_Modell, Month
		load_Bar.Set(80 ,"Copy Files")
	FileCopyDir, %A_WorkingDir%\bib, %Exicution_path%
		load_Bar.Set(90 ,"Run Upload")
		sleep, 1000
	RunWait, C:\uploader\modell.ps1, ;,hide
}
B4(){
	Global
Bnt_funkt()
FOUTF()
FileRemoveDir, C:\uploader, 1
	close:
	GuiEscape:
	Exitapp
}