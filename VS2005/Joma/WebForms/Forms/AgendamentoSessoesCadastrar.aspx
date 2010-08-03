<%@ Page Language="C#" MasterPageFile="~/Template/Template01.master" AutoEventWireup="true"
    CodeFile="AgendamentoSessoesCadastrar.aspx.cs" Inherits="Forms_AgendamentoSessoesCadastrar"
    Title="Smart Health Care - Agendamento" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset style="height: 100%">
        <legend align="center">Criar Agendamento</legend>
        <fieldset>
            <legend>Paciente</legend>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
                <tr>
                    <td style="height: 19px">
                        Nome:</td>
                    <td style="height: 19px">
                        <asp:Label ID="lblNome" runat="server" Font-Bold="True" Font-Size="14pt"></asp:Label></td>
                </tr>
                <tr>
                    <td width="5%">
                        RG:</td>
                    <td width="95%">
                        <asp:Label ID="lblRG" runat="server" Text="Label" Font-Bold="True" Font-Size="10pt"></asp:Label></td>
                        
                </tr>
                <tr>
                    <td style="height: 19px">
                        CPF:</td>
                    <td style="height: 19px">
                        <asp:Label ID="lblCPF" runat="server" Text="Label" Font-Bold="True" Font-Size="10pt"></asp:Label></td>
                </tr>
            </table>
        </fieldset>
        <fieldset>
            <legend>Montar Tratamento</legend>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto" bgcolor="#dcdcdc">
                <tr>
                    <td colspan="2">
                        Convenio:</td>
                    <td width="74%">
                        Numero:</td>
                </tr>
                <tr>
                    <td style="height: 24px">
                        </td>
                    <td style="height: 24px">
                        <asp:DropDownList ID="ddlConvenio" runat="server" Obrigatorio="1" AliasCampo="Nome do Convênio" Font-Bold="True">
                        </asp:DropDownList></td>
                    <td style="height: 24px">
                        <asp:TextBox ID="txtNumeroConvenio" runat="server" Font-Bold="True" Width="417px"></asp:TextBox>
                        Acerto:
                        <asp:CheckBox ID="chkAcerto" runat="server" /></td>
                </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto" bgcolor="#dcdcdc">
                <tr>
                    <td width="16%">
                        Profissional:</td>
                    <td width="16%">
                        Especialidade:</td>
                    <td width="11%">
                        Data Inicial:
                    </td>
                    <td width="11%">
                        Data Fim:</td>
                    <td width="11%">
                        Hora Inicial:
                    </td>
                    <td width="11%">
                        Hora Termino:
                    </td>
                    <td width="7%">
                        Qtd. Sess&otilde;es:</td>
                    <td width="7%">
                        Valor Unit&aacute;rio:</td>
                    <td width="6%">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td style="height: 24px">
                        <asp:DropDownList ID="ddlProfissionais" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlProfissionais_SelectedIndexChanged" Obrigatorio="1" AliasCampo="Profissional">
                        </asp:DropDownList></td>
                    <td style="height: 24px">
                        <asp:DropDownList ID="ddlEspecialidades" runat="server" Obrigatorio="1" AliasCampo="Especialidade do Profissional">
                            
                        </asp:DropDownList></td>
                    <td style="height: 24px">
                        <asp:TextBox ID="txtDataInicio" runat="server" Width="73px" MaxLength="10" Obrigatorio="1" AliasCampo="Data Inicio" onblur="javascript:valida_data(this);"
                            onkeypress="return MascaraCampo(this.form.name, this, '99/99/9999', event);"></asp:TextBox>
                            <a href="javascript:AbrePopUp('Agenda.aspx','800','600',this,event)"><img src="../Template/Img/agenda.png" alt="Consultar Agenda" border="0" align="absbottom"></a>
                            </td>
                    <td style="height: 24px" >
                        <asp:TextBox ID="txtDataFim" runat="server" Width="73px" MaxLength="10" Obrigatorio="1" AliasCampo="Data Fim" onblur="javascript:valida_data(this);"
                            onkeypress="return MascaraCampo(this.form.name, this, '99/99/9999', event);"></asp:TextBox>
                            <a href="javascript:AbrePopUp('Agenda.aspx','800','600',this,event)"><img src="../Template/Img/agenda.png" alt="Consultar Agenda" border="0" align="absbottom"></a>
                            </td>
                    <td style="height: 24px">
                        <asp:TextBox ID="txtHoraInicio" runat="server" Width="73px" MaxLength="5" Obrigatorio="1" AliasCampo="Hora Inicial da Sessão" onkeypress="return MascaraCampo(this.form.name, this, '99:99', event);"></asp:TextBox>&nbsp;</td>
                    <td style="height: 24px">
                        <asp:TextBox ID="txtHoraFim" runat="server" Width="73px" MaxLength="5" Obrigatorio="1" AliasCampo="Hora Final da Sessão" onkeypress="return MascaraCampo(this.form.name, this, '99:99', event);"></asp:TextBox></td>
                    <td style="height: 24px">
                        <asp:TextBox ID="txtQtd" runat="server" Width="34px" MaxLength="3" Obrigatorio="1" AliasCampo="Quantidade de Sessões" onkeypress="return MascaraCampo(this.form.name, this, '999', event);"></asp:TextBox></td>
                    <td style="height: 24px">
                        <asp:TextBox ID="txtValor" runat="server" Width="34px"></asp:TextBox></td>
                    <td style="height: 24px">
                        <asp:Button ID="btnInserir" runat="server" OnClick="btnInserir_Click" Text="Inserir" OnClientClick='return ValidaTexto(this.form)' /></td>
                </tr>
            </table>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                ForeColor="Black" GridLines="None" PageSize="15" Width="100%" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <RowStyle BackColor="#E3EAEB" />
                <Columns>
                    <asp:TemplateField HeaderText="Fisioterapeuta">
                        <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                        <ItemStyle Font-Size="10px" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "RefprofissionaisBE.Nome")%>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Apagar" ImageUrl="~/Template/Img/excluir.gif" />
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="DataInicio" HeaderText="Data" DataFormatString="{0:dd/MM/yyyy}">
                        <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                        <ItemStyle Font-Size="10px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="HoraInicio" HeaderText="Hora Inicio">
                        <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                        <ItemStyle Font-Size="10px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="HoraFim" HeaderText="Hora Termino">
                        <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                        <ItemStyle Font-Size="10px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Qtd" HeaderText="Qtd. Sess&#245;es">
                        <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                        <ItemStyle Font-Size="10px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Valor" HeaderText="Valor" DataFormatString="{0:C}">
                        <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                        <ItemStyle Font-Size="10px" />
                    </asp:BoundField>
                    <asp:CommandField ButtonType="Button" SelectText="Apagar" ShowSelectButton="True">
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:CommandField>
                </Columns>
                <FooterStyle BackColor="#1C5E55" Font-Bold="True" Font-Size="12px" ForeColor="White" />
                <PagerStyle BackColor="#1C5E55" Font-Bold="False" ForeColor="White" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#7C6F57" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
        </fieldset>
        <fieldset>
            <legend>Agendados</legend>&nbsp;&nbsp;<asp:GridView ID="GridView2" DataKeyNames="id"  runat="server" AutoGenerateColumns="False" CellPadding="4"
                ForeColor="Black" GridLines="None" PageSize="15" Width="100%" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowDataBound="GridView2_RowDataBound" OnRowCommand="GridView2_RowCommand">
                <RowStyle BackColor="#E3EAEB" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlStatus" runat="server"   OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                        </asp:DropDownList>&nbsp;
                            <asp:Button ID="BtnAlterarStatus" runat="server" Text="Ok" CommandName="BtnAlterarStatus" CommandArgument='<%# Eval("ID")%>' />

                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="EspecialidadeNome" HeaderText="Especialidade">
                        <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                        <ItemStyle Font-Size="10px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ProfissionaisNome" HeaderText="Profissional">
                        <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                        <ItemStyle Font-Size="10px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DataInicio" HeaderText="Data" DataFormatString="{0:dd/MM/yyyy}">
                        <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                        <ItemStyle Font-Size="10px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="HoraInicio" HeaderText="Hora Inicio">
                        <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                        <ItemStyle Font-Size="10px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="HoraFim" HeaderText="Hora Termino">
                        <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                        <ItemStyle Font-Size="10px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Qtd" HeaderText="Qtd. Sess&#245;es">
                        <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                        <ItemStyle Font-Size="10px" />
                    </asp:BoundField>
                                        <asp:BoundField DataField="ConvenioNome" HeaderText="Conv&#234;nio">
                        <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                        <ItemStyle Font-Size="10px" />
                    </asp:BoundField>
                </Columns>
                <FooterStyle BackColor="#2E5CB8" Font-Bold="True" Font-Size="12px" ForeColor="White" />
                <PagerStyle BackColor="#2E5CB8" Font-Bold="False" ForeColor="White" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#2E5CB8" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#7C6F57" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
        </fieldset>
        <br />
        <fieldset>
            <table width="100%">
                <tr>
                    <td align="center">
                        <asp:Button ID="btnGravar" runat="server" OnClick="btnGravar_Click" Text="Gravar" />
                    </td>
                </tr>
            </table>
        </fieldset>
    </fieldset>
</asp:Content>
