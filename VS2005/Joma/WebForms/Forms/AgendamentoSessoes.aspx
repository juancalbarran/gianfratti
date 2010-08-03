<%@ Page Language="C#" MasterPageFile="~/Template/Template01.master" AutoEventWireup="true" CodeFile="AgendamentoSessoes.aspx.cs" Inherits="Forms_AgendamentoSessoes" Title="Smart Health Care - Agendamento" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="javascript" type="text/javascript">

var oldgridSelectedColor;

function setMouseOverColor(element)
{
    oldgridSelectedColor = element.style.backgroundColor;
    element.style.backgroundColor='#ABD0BC';
    element.style.cursor='hand';
    //element.style.textDecoration='underline';
}

function setMouseOutColor(element)
{
    element.style.backgroundColor=oldgridSelectedColor;
    //element.style.textDecoration='none';
}
    </script>

    <fieldset style="height: 100%">
        <legend align="center">Agendamentos</legend>
        <fieldset>
            <legend>Filtro</legend>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
                <tr>
                    <td width="21%">
                        <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
                            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                            <WeekendDayStyle BackColor="#CCCCFF" />
                            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                            <OtherMonthDayStyle ForeColor="#999999" />
                            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                            <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                            <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                        </asp:Calendar>
                    </td>
                    <td width="79%" valign="top">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
                            <tr>
                                <td>
                                    Paciente:</td>
                                <td>&nbsp;
                                    </td>
                                <td>&nbsp;
                                    </td>
                                <td>
                                    RG:</td>
                                <td>
                                    CPF:</td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <asp:TextBox ID="txtNome" runat="server" Width="418px"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtRG" runat="server" MaxLength="20"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtCPF" runat="server" MaxLength="14" onkeypress="return MascaraCampo(this.form.name, this, '999.999.999-99', event);"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td width="15%">
                                    Convênio:</td>
                                <td width="21%">
                                    Número:</td>
                          <td width="21%">
                                    Data Inicial:</td>
                  <td width="19%">
                                    Data Fim:</td>
                              <td width="24%">                              Status:</td>
                          </tr>
                            <tr>
                                <td>
                                    <asp:DropDownList ID="ddlConvenio" runat="server" AliasCampo="Nome do Convênio" Obrigatorio="1">
                                    </asp:DropDownList></td>
                                <td>
                                    <asp:TextBox ID="txtNumeroConvenio" runat="server" AliasCampo="Número do Convênio" Obrigatorio="1"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtDataInicio" runat="server" AliasCampo="Data Inicio" MaxLength="10" Obrigatorio="1" onblur="javascript:valida_data(this);" onkeypress="return MascaraCampo(this.form.name, this, '99/99/9999', event);" Width="73px"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtDataFim" runat="server" AliasCampo="Data Fim" MaxLength="10" Obrigatorio="1" onblur="javascript:valida_data(this);" onkeypress="return MascaraCampo(this.form.name, this, '99/99/9999', event);" Width="73px"></asp:TextBox></td>
                                <td><asp:DropDownList ID="ddlStatusAgendamento" runat="server" AliasCampo="Nome do Convênio" Obrigatorio="1">
                                </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td>
                                    Profissional:</td>
                                <td>&nbsp;
                                    </td>
                                <td>
                                    Especialidade:</td>
                                <td>&nbsp;
                                    </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 19px">
                                    <asp:DropDownList ID="ddlProfissionais" runat="server" AliasCampo="Profissional" AutoPostBack="True" Obrigatorio="1" OnSelectedIndexChanged="ddlProfissionais_SelectedIndexChanged">
                                    </asp:DropDownList></td>
                                <td colspan="2" style="height: 19px">
                                    <asp:DropDownList ID="ddlEspecialidades" runat="server" AliasCampo="Especialidade do Profissional" Obrigatorio="1">
                                    </asp:DropDownList></td>
                                <td style="height: 19px">
                                    <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" /></td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </fieldset>
        <br />
        <fieldset>
            <table style="width: 100%" border="0" cellpadding="0" cellspacing="1" class="texto">
                <tr>
                    <td style="width: 100%;">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
                            <tr>
                                <td width="5%" align="center">
                                    <img src="../Template/Img/Flg_Azul.gif" /></td>
                                <td width="10%">
                                    <b>Agendado</b></td>
                                <td width="5%">
                                    <img src="../Template/Img/Flg_verde.gif" /></td>
                                <td width="10%">
                                    <b>Confirmado</b></td>
                                <td width="5%">
                                    <img src="../Template/Img/Flg_amerelo_Escuro.gif" /></td>
                                <td width="10%">
                                    <b>Reagendado</b></td>
                                <td width="5%" align="center">
                                    <img src="../Template/Img/Flg_vermelho.gif" /></td>
                                <td width="10%">
                                    <b>Cancelado</b></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </fieldset>
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" ForeColor="Black" GridLines="None" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand" OnRowCreated="GridView1_RowCreated" PageSize="50" ShowFooter="True" Width="100%" OnRowDataBound="GridView1_RowDataBound">
            <RowStyle BackColor="#E3EAEB" />
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Image ID="ImgStatus" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Paciente">
                    <ItemTemplate>
                        <%# DataBinder.Eval(Container.DataItem, "PacienteNome")%>
                    </ItemTemplate>
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Bold="True" Font-Size="10px" />
                    <FooterTemplate>
                        Total Registros:
                        <%# TotalRegistros %>
                    </FooterTemplate>
                    <FooterStyle Font-Bold="True" Font-Size="9px" ForeColor="White" HorizontalAlign="Left" />
                </asp:TemplateField>
                <asp:BoundField DataField="RG" HeaderText="RG">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="EspecialidadeNome" HeaderText="Especialidade">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="ProfissionaisNome" HeaderText="Profissional">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="DataInicio" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Data">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="HoraInicio" HeaderText="Hora Inicio">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="HoraFim" HeaderText="Hora Fim">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="Qtd" HeaderText="Qtd">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="ConvenioNome" HeaderText="Conv&#234;nio">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Alterar Status">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlStatus" runat="server" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                        </asp:DropDownList>&nbsp;
                        <asp:Button ID="BtnAlterarStatus" runat="server" CommandArgument='<%# Eval("ID")%>' CommandName="BtnAlterarStatus" Text="Ok" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#1C5E55" Font-Bold="True" Font-Size="12px" ForeColor="White" />
            <PagerStyle BackColor="#1C5E55" Font-Bold="False" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#7C6F57" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
    </fieldset>
</asp:Content>
