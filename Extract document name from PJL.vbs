' Script to extract job name from PJL

Option Explicit

Dim objFSO, objTSIn
Dim lChar, i, strLine

Dim searchLength


Dim strPJLStartSequence
strPJLStartSequence = Chr(27) & "%-12345X"

' Create a temporary file with the new mapping

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objTSIn = objFSO.OpenTextFile(PrintFilePath, 1, false, 0)

searchLength = 0


Do While objTSIn.AtEndOfStream = False And searchLength < 1000
	For i = 1 To Len(strPJLStartSequence)
		searchLength = searchLength + 1
		If objTSIn.Read(1) <> Mid(strPJLStartSequence, i, 1) Then
			Exit For
		End If

		'Have we read the whole PJL exit language sequence?
		If i = Len(strPJLStartSequence) Then
			ParsePJL(objTSIn)
		End If
	Next
Loop

objTSIn.Close

Sub ParsePJL(stream)
	Do While objTSIn.AtEndOfStream = False
		strLine = stream.ReadLine()
		If InStr(1, strLine, "@PJL", 1) > 0 Then
			If InStr(1, strLine, "ENTER", 1) > 0 And InStr(1, strLine, "LANGUAGE", 1) Then
				Exit Do
			End If

			If InStr(1, strLine, "JOBNAME") > 0 Then
				DocumentName = Mid(strLine, 18)
			End If
		End If
	Loop 
End Sub 

DocumentName = Replace(DocumentName, """", "")
