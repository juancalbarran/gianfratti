<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Documentos.aspx.cs" Inherits="PortalMTL.Forms.Documentos"
    MasterPageFile="~/Template/Template01.master"  %>

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
        <legend align="center">Vista de Processos</legend>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <fieldset>
                    <legend>Busca</legend>
                    <table width="100%">
                        <tr>
                            <td width="10%" class="texto">
                                N. Processo:
                            </td>
                            <td width="10%">
                                <asp:TextBox ID="txtNumProcesso" runat="server"></asp:TextBox>
                            </td>
                            <td width="5%">
                                <asp:Button ID="BtnBuscar" runat="server" Text="Ok" OnClick="BtnBuscar_Click" />
                            </td>
                            <td width="75%">
                                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                    <ProgressTemplate>
                                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Template/IMG/aguarde.gif" />
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <table width="100%">
                    <tr>
                        <td>
                        </td>
                    </tr>
                </table>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                    Width="100%" ForeColor="Black" GridLines="None" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging"
                    ShowFooter="True" OnRowCreated="GridView1_RowCreated" PageSize="30" 
                    onrowcommand="GridView1_RowCommand">
                    <RowStyle BackColor="#E3EAEB" />
                    <Columns>
                        <asp:BoundField DataField="Empresa" HeaderText="Empresa" Visible="False" />
                        <asp:BoundField DataField="NumProcesso" HeaderText="Processo">
                            <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left"
                                Width="20%" />
                            <ItemStyle Font-Size="10px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Data" HeaderText="Data da Vista">
                            <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left"
                                Width="65%" />
                            <ItemStyle Font-Size="10px" />
                        </asp:BoundField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="ImgBtnPdf" runat="server" CommandArgument='<%# Eval("ArquivoPDF")%>'
                                    ImageUrl="~/Template/Img/pdf.gif" CommandName="Visualizar" ToolTip="Vista do Processo"
                                    ImageAlign="Left" />
                            </ItemTemplate>
                            <FooterTemplate>
<%--                                Total Registros:
                                <%# TotalRegistros %>--%>
                            </FooterTemplate>
                            <FooterStyle Font-Bold="True" Font-Size="9px" ForeColor="White" 
                                HorizontalAlign="Left" />
                            <HeaderStyle Font-Size="12px" ForeColor="White" HorizontalAlign="Left" 
                                Width="5px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="BtnDownload" runat="server" CommandArgument='<%# Eval("NumEmpresa")+ ":" + Eval("NumProcesso") + ":" + Eval("Data") + ":" + Eval("ArquivoPDF")%>' CommandName="Download"
                                    ImageUrl="~/Template/IMG/download.png" />
                            </ItemTemplate>
                            <HeaderStyle Width="5px" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="ImgBtnApagar" runat="server" CommandArgument='<%# Eval("NumEmpresa")+ ":" + Eval("NumProcesso") + ":" + Eval("Data")%>' 
                                    CommandName="Apagar" ImageUrl="~/Template/IMG/excluir.gif" />
                            </ItemTemplate>
                            <HeaderStyle Width="5px" />
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#1C5E55" ForeColor="White" Font-Bold="True" Font-Size="12px" />
                    <PagerStyle BackColor="#1C5E55" ForeColor="White" HorizontalAlign="Center" Font-Bold="False" />
                    <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#7C6F57" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </fieldset>
</asp:Content>
