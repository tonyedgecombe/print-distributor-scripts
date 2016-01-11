'Abort if text not found

Option Explicit

Dim PrinterName, SearchText
Dim objFSO, objTSIn, strLine

' Set the search text here
SearchText = "ABCD"

Set objFSO = CreateObject ( "Scripting.FileSystemObject")
Set objTSIn = objFSO.openTextFile(PrintFilePath,  1, false, 0)

Do While objTSIn.AtEndOfStream = False
	strLine = objTSIn.Readline

	If InStr(strLine, SearchText) > 0 Then
		AbortJob = True
		LogMessage "Aborting document because text " & searchText & " found."
		Exit Do
	End If
Loop

objTSIn.Close
