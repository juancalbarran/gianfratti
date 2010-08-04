<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FuncionarioDadosBasicos.ascx.cs" Inherits="UserControls_ClienteFuncionario_FuncionarioDadosBasicos" %>



<fieldset>
<legend>Dados Pessoais</legend>
<table class="texto" cellpadding="0" cellspacing="0" border="0" width="100%" >
    				
					    <tr>
						    <td colspan="2"><strong>Nome:</strong>&nbsp;<asp:Label ID="lblNome" runat="server" Text=''></asp:Label>
						    <td colspan="1"><strong>RG:</strong>&nbsp;<asp:Label ID="lblRG" runat="server" Text=''></asp:Label></td>
						    <td colspan="1"><strong>CPF:</strong>&nbsp;<asp:Label ID="lblCPF" runat="server" Text=''></asp:Label></td>						                   
					    </tr>
					    <tr>
						    <td><strong>Sexo:</strong>&nbsp;<asp:Label ID="lblSexo" runat="server" Text=''></asp:Label></td>
						    <td><strong>Data Nascimento:</strong>&nbsp;<asp:Label ID="lblDtNascimento" runat="server" Text=''></asp:Label></td>
						    <td><strong>Estado Civil:</strong>&nbsp;<asp:Label ID="lblEstadoCivil" runat="server" Text=''></asp:Label></td>
						    <td></td>
					    </tr>
					    <tr>
						    <td colspan="4" ><strong>Endereço Residencial:</strong>&nbsp;<asp:Label ID="lblEndResidencia" runat="server" Text=''></asp:Label></td>
					    </tr>
					    <tr>
						    <td><strong>Nº.:</strong>&nbsp;<asp:Label ID="lblNumero" runat="server" Text=''></asp:Label></td>
						    <td><strong>Complemento:</strong>&nbsp;<asp:Label ID="lblComplemento" runat="server" Text=''></asp:Label></td>
						    <td><strong>CEP:</strong>&nbsp;<asp:Label ID="lblCEP" runat="server" Text=''></asp:Label></td>
						    <td><strong>Bairro:</strong>&nbsp;<asp:Label ID="lblBairro" runat="server" Text=''></asp:Label></td>
					    </tr>
					    <tr>
						    <td ><strong>Fone:</strong>&nbsp;(<asp:Label ID="lblDDDtel" runat="server" Text=''></asp:Label>) <asp:Label ID="TelefoneLabel" runat="server" Text='<%# Bind("Telefone") %>'></asp:Label></td>
						    <td ><strong>Cidade:</strong>&nbsp;<asp:Label ID="lblCidade" runat="server" Text=''></asp:Label></td>
						    <td ><strong>UF:</strong>&nbsp;<asp:Label ID="lblUF" runat="server" Text=''></asp:Label></td>
						    <td ></td>
					    </tr>
				    </table>
				    </fieldset>
				 
				    <fieldset> 
				    <legend>Dados Profissionais</legend>
<table class="texto" cellpadding="0" cellspacing="0" border="0" width="100%" >
    				
					    <tr>
						    <td colspan="2" style="height: 19px"><strong>Cliente:</strong>&nbsp;<asp:Label ID="lblCliente" runat="server"></asp:Label><td
                                    colspan="1" style="height: 19px">
                                </td>
                        </tr>
    <tr>
        <td colspan="2" style="height: 19px">
            <b>CNAE:</b>
            <asp:Label ID="lblCNAE" runat="server"></asp:Label>
            -
            <asp:Label ID="lblDenominacao" runat="server"></asp:Label></td>
        <td colspan="1" style="height: 19px">
            <b>Risco:</b>
            <asp:Label ID="lblRisco" runat="server"></asp:Label></td>
    </tr>
					    <tr>
						    <td style="height: 19px; width: 379px;"><strong>Departamento:</strong>&nbsp;
                <asp:Label ID="LblDepartamento" runat="server"></asp:Label></td>
						    <td style="height: 19px"><strong>Setor:</strong>&nbsp;
                <asp:Label ID="LblSetor" runat="server"></asp:Label></td>
                            <td style="height: 19px">
                                <strong>CBO:</strong>&nbsp;
                                <asp:Label ID="lblCBO" runat="server"></asp:Label></td>
					    </tr>
					    <tr>
						    <td colspan="2" ><strong>Descrição das Atividades Exercidas :</strong>&nbsp;<asp:Label ID="lblDescricaoAtividades" runat="server" Text=''></asp:Label></td>
                            <td colspan="1">
                            </td>
					    </tr>
				    </table>
				    </fieldset>
				