#SingleInstance
#Include ..\..\Unknown\Unknown.ahk
#Include ..\ProgressDialog.ahk

progress := new ProgressDialog ; create a new instance
progress.SetTitle("This is a demo script") ; set the title
progress.SetLine(1, "This script shows you the power of COM.") ; set line text
progress.SetLine(2, "To do so, it uses the IProgressDialog COM interface.")
progress.SetLine(3, "This is even possible with AHK basic, without native COM support!")
progress.SetCancelMsg("You canceled the dialog. Please wait.")

if (!progress.StartProgressDialog()) ; show the dialog
	ExitApp

Loop 100
{
	progress.SetProgress(A_Index) ; update progress
	sleep 500
	if (progress.HasUserCanceled()) ; if user canceled:
	{
		sleep 2000 ; let him read cancel msg
		break
	}
}

progress.SetLine(2, "The script finished now and will exit in a few seconds...")
progress.SetLine(3, "Bye Bye!")
sleep 3000
progress.StopProgressDialog() ; close the dialog