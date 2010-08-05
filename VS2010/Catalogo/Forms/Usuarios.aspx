<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="Catalogo.Usuarios"
    MasterPageFile="~/Template/Template01.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="javascript" type="text/javascript">

        var oldgridSelectedColor;

        function setMouseOverColor(element) {
            oldgridSelectedColor = element.style.backgroundColor;
            element.style.backgroundColor = '#ABD0BC';
            element.style.cursor = 'hand';
            //element.style.textDecoration='underline';
        }

        function setMouseOutColor(element) {
            element.style.backgroundColor = oldgridSelectedColor;
            //element.style.textDecoration='none';
        }
    </script>

    <fieldset style="width: 100%; height: 100%">
        <legend align="center">Usuários</legend>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None"
                    Width="100%" OnRowDataBound="GridView1_RowDataBound" 
                    onpageindexchanging="GridView1_PageIndexChanging" 
                    onrowcommand="GridView1_RowCommand" PageSize="20">
                    <RowStyle BackColor="#EFF3FB" />
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="Código">
                            <HeaderStyle HorizontalAlign="Left" ForeColor="White" />
                            <ItemStyle Font-Size="12px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Perfil" HeaderText="Perfil">
                            <HeaderStyle HorizontalAlign="Left" ForeColor="White" />
                            <ItemStyle Font-Size="12px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Nome" HeaderText="Nome">
                            <HeaderStyle HorizontalAlign="Left" ForeColor="White" />
                            <ItemStyle Font-Size="12px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Email" HeaderText="E-Mail">
                            <HeaderStyle HorizontalAlign="Left" ForeColor="White" />
                            <ItemStyle Font-Size="12px" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Editar">
                            <ItemTemplate>
                                <asp:ImageButton ID="BtnVisualizar" runat="server" ImageUrl="~/Template/IMG/alterar.gif"
                                    ToolTip="Editar Registro" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Right" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Apagar">
                            <ItemTemplate>
                                <asp:ImageButton ID="ImgBtnApagar" runat="server" ImageUrl="~/Template/IMG/excluir.gif"
                                    ToolTip="Apagar Registro" CommandName="Apagar" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Right" ForeColor="White" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#2461BF" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </fieldset>
</asp:Content>
