Public Class ERDControl

    Dim TableCollection As Collection
    Dim TableControlCollection As Collection
    Dim RelationshipCollection As Collection
    Dim tablepointer As Integer

    Public Sub New()

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        TableCollection = New Collection
        TableCollection.Clear()
        TableControlCollection = New Collection
        TableControlCollection.Clear()
        RelationshipCollection = New Collection
        RelationshipCollection.Clear()
        tablepointer = 0
    End Sub

    Protected Overrides Sub Finalize()
        TableCollection.Clear()
        TableCollection = Nothing
        MyBase.Finalize()
    End Sub

    Public Sub AddTable(ByVal table As String)
        Dim tc As New TableControl()

        TableCollection.Add(table, table)
        tc.TableName = table
        TableControlCollection.Add(tc, table)
        Me.Controls.Add(tc)

        UpdateView()
    End Sub

    Public Sub InsertTable(ByVal table As String)
        AddTable(table)
    End Sub

    Public Sub RemoveTable(ByVal table As String)
        TableCollection.Remove(table)
        TableControlCollection.Remove(table)
        UpdateView()
    End Sub

    Public Sub RemoveTable(ByVal ndx As Integer)
        TableControlCollection.Remove(CStr(TableCollection(ndx)))
        TableCollection.Remove(ndx)
        UpdateView()
    End Sub

    Public Sub DeleteTable(ByVal ndx As Integer)
        RemoveTable(ndx)
    End Sub

    Public Sub DeleteTable(ByVal table As String)
        RemoveTable(table)
    End Sub

    Public Sub AddRelationship(ByVal PrimaryTable As String, ByVal ForeignTable As String)
        Dim re As New RelationshipEntity

        re.PrimaryTable = PrimaryTable
        re.ForeignTable = ForeignTable
        Me.RelationshipCollection.Add(re, PrimaryTable.Trim() + ForeignTable.Trim())
    End Sub

    Public Sub InsertRelationship(ByVal PrimaryTable As String, ByVal ForeignTable As String)
        AddRelationship(PrimaryTable, ForeignTable)
    End Sub

    Public Sub RemoveRelationship(ByVal PrimaryTable As String, ByVal ForeignTable As String)
        Dim re As RelationshipEntity

        re = CType(Me.RelationshipCollection(PrimaryTable.Trim() + ForeignTable.Trim()), RelationshipEntity)
        Me.RelationshipCollection.Remove(PrimaryTable.Trim() + ForeignTable.Trim())
        re = Nothing
    End Sub

    Public Sub DeleteRelationship(ByVal PrimaryTable As String, ByVal ForeignTable As String)
        RemoveRelationship(PrimaryTable, ForeignTable)
    End Sub

    Protected Sub UpdateView()
        For Each tbl As TableControl In TableControlCollection
            tbl.Top = tablepointer + 1
            tbl.Left = tablepointer + 1
            tablepointer = tablepointer + 50
        Next
        Refresh()
    End Sub

    Protected Overrides Sub OnPaint(ByVal pe As System.Windows.Forms.PaintEventArgs)
        Dim re As RelationshipEntity

        MyBase.OnPaint(pe)

        For Each re In Me.RelationshipCollection
            Dim PrimTC As TableControl = Nothing
            Dim ForgTC As TableControl = Nothing
            Dim ndx As Integer = 1

            While ndx <= Me.TableControlCollection.Count
                If re.PrimaryTable = CType(Me.TableControlCollection(ndx), TableControl).TableName Then
                    PrimTC = CType(Me.TableControlCollection(ndx), TableControl)
                End If
                If re.ForeignTable = CType(Me.TableControlCollection(ndx), TableControl).TableName Then
                    ForgTC = CType(Me.TableControlCollection(ndx), TableControl)
                End If
                ndx = ndx + 1
            End While

            If PrimTC Is Nothing OrElse ForgTC Is Nothing Then Exit Sub
            pe.Graphics.DrawLine(Pens.Black, PrimTC.Left, PrimTC.Top, ForgTC.Left, ForgTC.Top)
            pe.Graphics.DrawLine(Pens.Black, PrimTC.Left, PrimTC.Top, PrimTC.Left - 10, PrimTC.Top + 10)
        Next
    End Sub
End Class

Public Class RelationshipEntity
    Private PrimTable As String
    Private ForgTable As String

    Public Property PrimaryTable() As String
        Get
            Return PrimTable
        End Get
        Set(ByVal value As String)
            PrimTable = value
        End Set
    End Property

    Public Property ForeignTable() As String
        Get
            Return ForgTable
        End Get
        Set(ByVal value As String)
            ForgTable = value
        End Set
    End Property
End Class