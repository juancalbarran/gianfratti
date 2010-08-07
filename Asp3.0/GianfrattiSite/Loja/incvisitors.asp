<%
Sub LogNewUser
            Dim strUserList
            Dim intUserStart, intUserEnd
            Dim strUser
            Dim strDate

            strUserList = Application("UserList")

        If Instr(1, strUserList, Session.SessionID) > 0 Then
            Application.Lock
            intUserStart = Instr(1, strUserList, Session.SessionID)
            intUserEnd = Instr(intUserStart, strUserList, "|")
            strUser = Mid(strUserList, intUserStart, intUserEnd - intUserStart)
            strUserList = Replace(strUserList, strUser, Session.SessionID & ":" & Now())
            Application("UserList") = strUserList
            Application.UnLock
        Else
            Application.Lock
            Application("ActiveUsers") = CInt(Application("ActiveUsers")) + 1
            Application("UserList") = Application("UserList") & Session.SessionID & ":" & Now() & "|"
            Application.UnLock
        End If
End Sub


'Cleans up the user count so that the script can read the user details from it...

Sub ActiveUserCleanup
Dim ix
Dim intUsers
Dim strUserList
Dim aActiveUsers
Dim intActiveUserCleanupTime
Dim intActiveUserTimeout

intActiveUserCleanupTime = 1 'In minutes, how often should the UserList be cleaned up.
intActiveUserTimeout = 20 'In minutes, how long before a User is considered Inactive and is deleted from UserList

If Application("UserList") = "" Then Exit Sub

If DateDiff("n", Application("ActiveUsersLastCleanup"), Now()) > intActiveUserCleanupTime Then

    Application.Lock
    Application("ActiveUsersLastCleanup") = Now()
    Application.Unlock

    intUsers = 0
    strUserList = Application("UserList")
    strUserList = Left(strUserList, Len(strUserList) - 1)

    aActiveUsers = Split(strUserList, "|")

For ix = 0 To UBound(aActiveUsers)
    If DateDiff("n", Mid(aActiveUsers(ix), Instr(1, aActiveUsers(ix), ":") + 1, Len(aActiveUsers(ix))), Now()) > intActiveUserTimeout Then
        aActiveUsers(ix) = "XXXX"
    Else
        intUsers = intUsers + 1
    End If 
Next

strUserList = Join(aActiveUsers, "|") & "|"
strUserList = Replace(strUserList, "XXXX|", "")

    Application.Lock
    Application("UserList") = strUserList
    Application("ActiveUsers") = intUsers
    Application.UnLock

End If

End Sub


' Shows the amount of users surfing the site

Call LogNewUser()
Call ActiveUserCleanup()

Response.Write Application("ActiveUsers")

%> 
