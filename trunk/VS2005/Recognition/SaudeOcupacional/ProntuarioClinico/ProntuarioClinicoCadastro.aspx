<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="ProntuarioClinicoCadastro.aspx.cs" Inherits="ProntuarioClinico_ProntuarioClinicoCadastro" Title="Prontuário Clínico" %>

<%@ Register Src="../UserControls/ClienteFuncionario/FuncionarioDadosBasicos.ascx"
    TagName="FuncionarioDadosBasicos" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<script type="text/javascript" language="Javascript"> 
    
    function MM_findObj(n, d) { var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) { d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);} if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n]; for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); if(!x && document.getElementById) x=document.getElementById(n); return x;};
    
    //Função que mostra e oculta a tabela
    function MostraOculta(campo,nomeCamada)
    {
        var campo1 = MM_findObj(campo.id + '_0');
        var campo2 = MM_findObj(campo.id + '_1');
        
        if(campo1.checked == false){
            document.getElementById(nomeCamada).style.visibility="visible"; 
        }else{
            document.getElementById(nomeCamada).style.visibility="hidden"; 
        }
    }    
</script>

<table cellpadding="0" cellspacing="0" border="0" width="100%">  
    <tr>
        <td width="100%">
        
        <fieldset>
        <legend align="center"> Prontuário Clínico </legend>
        <table cellpadding="0" cellspacing="0" border="0" style="padding-bottom:10px" id="ProntuarioClinico" width="100%">
		    <tr>
			    <td>
       
                        <uc1:FuncionarioDadosBasicos ID="FuncionarioDadosBasicos1" runat="server" />
      
			    </td>
		    </tr>
    		
				    <tr>
			    <td>
			    <fieldset>
				    <table cellpadding="0" cellspacing="0" border="0" width="100%"">
					    <tr>
						    <td colspan="2" >
                                <table style="width: 100%">
                                    <tr>
                                    <td style="width: 116px"><strong>Data&nbsp;Consulta:</strong></td>
                                    <td>
                                        <asp:TextBox ID="txtDataCadastro" runat="server" onblur="javascript:valida_data(this);" MaxLength="10" onKeyPress="return MascaraCampo(this.form.name, this, '99/99/9999', event);" Width="75px"></asp:TextBox></td>
                                        <td>
                                        
                                        <asp:ImageButton ImageUrl="~/Template/Img/Limpar.jpg" ImageAlign=right ToolTip="Limpar todos os campos" ID="btnLimpar" runat="server" OnClick="btnLimpar_Click" Text="Limpar Campos" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
					    </tr>
    					
				    </table>
			    </fieldset>
			    </td>
		    </tr>
    		
		    <tr>
			    <td>
			    <fieldset>
			    <legend>&nbsp;Anamnese&nbsp;</legend>
				    <table cellpadding="0" cellspacing="0" border="0" width="100%">
					    <tr>
						    <td style="height: 89px"><strong>Historico:</strong><br />
						    <asp:TextBox name="Anamnese_Historico" cols="80" rows="4" id="txtAnamnese_Historico" runat="server" TextMode="MultiLine" Width="600px"></asp:TextBox>
						    </td>
					    </tr>
					    <tr>
						    <td><strong>Antecedentes Pessoais:</strong><br />
							    <table cellpadding="0" cellspacing="0" border="0">
								    <tr>
									    <td style="width:200px;">Diabetes:</td>
									    <td style="width: 561px;">
									    <table style="width:100%;">
                                                <tr>
                                                    <td>
                                            <asp:RadioButtonList ID="rdoAnamnese_AntecedentesPessoais_Diabetes" runat="server" RepeatDirection="Horizontal"
                                                Width="83px">
                                                <asp:ListItem Value="0" Selected="True">N&#227;o</asp:ListItem>
                                                <asp:ListItem Value="1">Sim</asp:ListItem>
                                            </asp:RadioButtonList></td>
                                            </tr>
                                        </table>
                                        </td>
								    </tr>
								    <tr>
									    <td>Hipertensão Arterial:</td>
									    <td style="width: 561px">
									    <table style="width:100%;">
                                                <tr>
                                                    <td><asp:RadioButtonList ID="rdoAnamnese_AntecedentesPessoais_HipertensaoArterial" runat="server" RepeatDirection="Horizontal"
                                                Width="83px">
                                            <asp:ListItem Value="0" Selected="True">N&#227;o</asp:ListItem>
                                            <asp:ListItem Value="1">Sim</asp:ListItem>
                                        </asp:RadioButtonList></td>
                                        </tr>
                                        </table>
                                        </td>
								    </tr>
								    
								    <tr>
									    <td>Tumores/Câncer:</td>
									    <td style="width: 561px">
									    <table style="width:100%;">
                                                <tr>
                                                    <td style="width: 100px;">
									                <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_AntecedentesPessoais_Tumores_Cancer')" ID="rdoAnamnese_AntecedentesPessoais_Tumores" runat="server" RepeatDirection="Horizontal"
                                                            Width="64px">
                                                        <asp:ListItem Value="0" Selected="True">N&#227;o</asp:ListItem>
                                                        <asp:ListItem Value="1">Sim</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                   </td>
                                                   <td>
                                                       <table cellpadding="0" cellspacing="0" border="0" id="Tbl_AntecedentesPessoais_Tumores_Cancer" style="visibility=hidden">
                                                       <tr>
                                                           <td>
                                                            CID10:&nbsp;<asp:TextBox name="Anamnese_AntecedentesPessoais_Tumores_CID10" type="text" value="" maxlength="4" id="txtAnamnese_AntecedentesPessoais_Tumores_CID10" runat="server" Width="51px"></asp:TextBox>
                                                           <a href="javascript:AbrePopUp('/SaudeOcupacional/Tabelas/CID10/PopUp/CID10PopUp.aspx?Tipo=1','750','500',this,event)"><img src="\SaudeOcupacional\Template\img\pesquisa.gif" border="0" WIDTH="15" HEIGHT="13"></a>
                                                           </td>
                                                           <td nowrap >Ano:&nbsp;<asp:TextBox name="Anamnese_AntecedentesPessoais_Tumores_Ano" type="text" onKeyPress="return MascaraCampo(this.form.name, this, '9999', event);" value="" maxlength="4" id="txtAnamnese_AntecedentesPessoais_Tumores_Ano" runat="server" Width="34px"></asp:TextBox></td>
                                                           <td nowrap >Foi Tratado?</td>
                                                           <td>
							                              <asp:DropDownList ID="txtAnamnese_AntecedentesPessoais_Tumores_Tratado" runat="server">
                                                                   <asp:ListItem Value=""><-></asp:ListItem>
                                                                   <asp:ListItem Value="Sim">Sim</asp:ListItem>
                                                                   <asp:ListItem Value="Não">Não</asp:ListItem>
                                                           </asp:DropDownList>
                                                           </td>
                                                       </tr></table>
                                                      </td>
                                        </tr>
                                        </table>
                                        </td>
								    </tr>
								    
								    <tr>
									    <td>Alergias:</td>
									    <td>
                                            <table style="width:100%;">
                                                <tr>
                                                    <td style="width: 100px;">
									                    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_AntecedentesPessoais_Alergias')" ID="rdoAnamnese_AntecedentesPessoais_Alergias" runat="server" RepeatDirection="Horizontal"
                                                                Width="64px">
                                                            <asp:ListItem Value="0" Selected="True">N&#227;o</asp:ListItem>
                                                            <asp:ListItem Value="1">Sim</asp:ListItem>
                                                            
                                                        </asp:RadioButtonList>
                                                    </td>
                                                    <td nowrap >
                                                    <table cellpadding="0" cellspacing="0" border="0" id="Tbl_AntecedentesPessoais_Alergias" style="visibility=hidden">
                                                    <tr>
                                                    <td>
                                                    Quais:&nbsp;<asp:TextBox name="Anamnese_AntecedentesPessoais_Alergias_Quais" type="text" value="" maxlength="256" id="txtAnamnese_AntecedentesPessoais_Alergias_Quais" runat="server"> </asp:TextBox>
                                                    </td>
                                                    </tr>
                                                    </table>
                                                    </td>
                                                 </tr>
                                            </table>
									    </td>
								    </tr>

								    
								    <tr>
									    <td>Internações Prèvias:</td>
									    <td>
                                            <table style="width:100%;">
                                                <tr>
                                                    <td style="width: 100px">
                                                        <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_AntecedentesPessoais_Internacoes')" ID="rdoAnamnese_AntecedentesPessoais_Internacoes" runat="server" RepeatDirection="Horizontal" Width="64px">
                                                            <asp:ListItem Value="0" Selected="True">N&#227;o</asp:ListItem>
                                                            <asp:ListItem Value="1">Sim</asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                    <td nowrap >
                                                    <table cellpadding="0" cellspacing="0" border="0" id="Tbl_AntecedentesPessoais_Internacoes" style="visibility=hidden">
                                                    <tr>
                                                    <td>
                                                    Quais:&nbsp;<asp:TextBox name="Anamnese_AntecedentesPessoais_Internacoes_Quais" type="text" value=""  size="20" maxlength="256" id="txtAnamnese_AntecedentesPessoais_Internacoes_Quais" runat="server"> </asp:TextBox>
                                                    <td>
                                                    </tr>
                                                    </table>
                                                    </td>
                                                </tr>
                                            </table>                                        
									    </td>
								    </tr>
    								
								    <tr>
									    <td>Cirugias Prévias:</td>
									    <td>
									    <table style="width:100%;">
                                                <tr>
                                                    <td style="width: 100px">
									    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_AntecedentesPessoais_Cirugias')" ID="rdoAnamnese_AntecedentesPessoais_Cirugias" runat="server" RepeatDirection="Horizontal"
                                                Width="64px">
                                            <asp:ListItem Value="0" Selected="True">N&#227;o</asp:ListItem>
                                            <asp:ListItem Value="1">Sim</asp:ListItem>
                                        </asp:RadioButtonList>
                                        </td>
									    <td nowrap >
									    
									    <table cellpadding="0" cellspacing="0" border="0" id="Tbl_AntecedentesPessoais_Cirugias" style="visibility=hidden">
									    <tr>
									    <td>
									    Quais:&nbsp;<asp:TextBox name="Anamnese_AntecedentesPessoais_Cirugias_Quais" type="text" value=""  size="20" maxlength="256" id="txtAnamnese_AntecedentesPessoais_Cirugias_Quais" runat="server"> </asp:TextBox>
									    <td>
									    </tr>
									    </table>
									    </td>
									    </tr>
									    </table>                                        
									    </td>
								    </tr>
							    </table>
						    </td>
					    </tr>
					    <tr>
						    <td><strong>Antecedentes Familiares:</strong><br />
							    <table cellpadding="0" cellspacing="0" border="0">
								    <tr>
									    <td style="width:200px">Diabetes:</td>
    									
									    <td>
									    <table style="width:100%;">
                                                <tr>
                                                    <td style="width: 100px">
									    <asp:RadioButtonList ID="rdoAnamnese_AntecedentesFamiliares_Diabetes" runat="server" RepeatDirection="Horizontal"
                                                Width="64px">
                                            <asp:ListItem Value="0" Selected="True">N&#227;o</asp:ListItem>
                                                
                                            <asp:ListItem Value="1">Sim</asp:ListItem>
                                        </asp:RadioButtonList>
									    </td>
									    </tr>
									    </table></td>
								    </tr>
								    <tr>
									    <td>Hipertensão Arterial:</td>
									    <td><table style="width:100%;">
                                                <tr>
                                                    <td style="width: 100px"><asp:RadioButtonList ID="rdoAnamnese_AntecedentesFamiliares_HipertensaoArterial" runat="server" RepeatDirection="Horizontal"
                                                Width="64px">
                                            <asp:ListItem Value="0" Selected="True">N&#227;o</asp:ListItem>
                                            <asp:ListItem Value="1">Sim</asp:ListItem>
                                        </asp:RadioButtonList>
									    </td>
									    </tr></table></td>
								    </tr>
								    <tr>
									    <td>Tumores/Câncer:</td>
									    <td><table style="width:100%;">
                                                <tr>
                                                    <td style="width: 100px"><asp:RadioButtonList ID="rdoAnamnese_AntecedentesFamiliares_Tumores" runat="server" RepeatDirection="Horizontal"
                                                Width="64px">
                                            <asp:ListItem Value="0" Selected="True">N&#227;o</asp:ListItem>
                                            <asp:ListItem Value="1">Sim</asp:ListItem>
                                        </asp:RadioButtonList>
									    </td></tr></table></td>
								    </tr>
							    </table>
						    </td>
					    </tr>
					    <tr>
						    <td><strong>Antecedentes Obstétricos:</strong><br />
							    <table cellpadding="0" cellspacing="0" border="0">
								    <tr>
									    <td style="width:200px;">Gestações Prévias:</td>
									    <td><table style="width:100%;">
                                                <tr>
                                                    <td style="width: 100px"><asp:RadioButtonList onclick="MostraOculta(this,'Tbl_AntecedentesObstetricos_Gestacoes')" ID="rdoAnamnese_AntecedentesObstetricos_Gestacoes" runat="server" RepeatDirection="Horizontal"
                                                Width="64px">
                                            <asp:ListItem Value="0" Selected="True">N&#227;o</asp:ListItem>
                                            <asp:ListItem Value="1">Sim</asp:ListItem>
                                        </asp:RadioButtonList>
                                            </td><td>
                                            
                                            <table cellpadding="0" cellspacing="0" border="0" id="Tbl_AntecedentesObstetricos_Gestacoes" style="visibility=hidden">
                                            <tr>
                                            <td>
                                            Quantos:&nbsp;
                                            <asp:DropDownList ID="txtAnamnese_AntecedentesObstetricos_Gestacoes_Quantos" runat="server">
                                                <asp:ListItem Value=""><-Selecione-></asp:ListItem>
                                                <asp:ListItem>1</asp:ListItem>
                                                <asp:ListItem>2</asp:ListItem>
                                                <asp:ListItem>3</asp:ListItem>
                                                <asp:ListItem>4</asp:ListItem>
                                                <asp:ListItem Value="5 ou mais">5 ou mais</asp:ListItem>
                                            </asp:DropDownList>
                                            </td>
                                            </tr>
                                            </table>
                                            
									    </td></tr></table></td>
								    </tr>
								    <tr>
									    <td>Partos:</td>
									    <td><table style="width:100%;">
                                                <tr>
                                                    <td style="width: 100px"><asp:RadioButtonList onclick="MostraOculta(this,'Tbl_AntecedentesObstetricos_Partos')" ID="rdoAnamnese_AntecedentesObstetricos_Partos" runat="server" RepeatDirection="Horizontal"
                                                Width="64px">
                                            <asp:ListItem Value="0" Selected="True">N&#227;o</asp:ListItem>
                                            <asp:ListItem Value="1">Sim</asp:ListItem>
                                        </asp:RadioButtonList>
                                            </td>
                                            <td>
                                            
                                            <table cellpadding="0" cellspacing="0" border="0" id="Tbl_AntecedentesObstetricos_Partos" style="visibility=hidden">
                                            <tr>
                                            <td>
                                            Quantos:&nbsp;
                                            <asp:DropDownList ID="txtAnamnese_AntecedentesObstetricos_Partos_Quantos" runat="server">
                                                <asp:ListItem Value=""><-Selecione-></asp:ListItem>
                                                <asp:ListItem>1</asp:ListItem>
                                                <asp:ListItem>2</asp:ListItem>
                                                <asp:ListItem>3</asp:ListItem>
                                                <asp:ListItem>4</asp:ListItem>
                                                <asp:ListItem Value="5 ou mais">5 ou mais</asp:ListItem>
                                            </asp:DropDownList>
                                            </td>
                                            </tr>
                                            </table>
                                            
									    </td></tr></table></td>
								    </tr>
								    <tr>
									    <td>Abortos:</td>
									    <td><table style="width:100%;">
                                                <tr>
                                                    <td style="width: 100px"><asp:RadioButtonList onclick="MostraOculta(this,'Tbl_AntecedentesObstetricos_Abortos')" ID="rdoAnamnese_AntecedentesObstetricos_Abortos" runat="server" RepeatDirection="Horizontal"
                                                Width="64px">
                                            <asp:ListItem Value="0" Selected="True">N&#227;o</asp:ListItem>
                                            <asp:ListItem Value="1">Sim</asp:ListItem>
                                        </asp:RadioButtonList>
                                            </td><td>
                                            
                                            <table cellpadding="0" cellspacing="0" border="0" id="Tbl_AntecedentesObstetricos_Abortos" style="visibility=hidden">
                                            <tr>
                                            <td>
                                            Quantos:&nbsp;
                                            <asp:DropDownList ID="txtAnamnese_AntecedentesObstetricos_Abortos_Quantos" runat="server">
                                                <asp:ListItem Value=""><-Selecione-></asp:ListItem>
                                                <asp:ListItem>1</asp:ListItem>
                                                <asp:ListItem>2</asp:ListItem>
                                                <asp:ListItem>3</asp:ListItem>
                                                <asp:ListItem>4</asp:ListItem>
                                                <asp:ListItem Value="5 ou mais">5 ou mais</asp:ListItem>
                                            </asp:DropDownList>
                                            </td>
                                            </tr>
                                            </table>
                                            
									    </td></tr></table></td>
								    </tr>
								    <tr>
									    <td>Data Ult. Menstruação:</td>
									    <td>
									    <table style="width:100%;">
                                                <tr>
                                                    <td style="width: 100px"><asp:TextBox name="Anamnese_AntecedentesObstetricos_DtMenstruacao" onblur="javascript:valida_data(this);" type="text" value=""  size="15" maxlength="10" id="txtAnamnese_AntecedentesObstetricos_DtMenstruacao" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99/99/9999', event);" > </asp:TextBox>
									    </td></tr></table></td>
								    </tr>
							    </table>
						    </td>
					    </tr>
				    </table>
			    </fieldset>

			    </td>
		    </tr>
    		
		    <tr>
			    <td>
			    <fieldset>
			    <legend>&nbsp;Hábitos&nbsp;</legend>
				    <table cellpadding="0" cellspacing="0" border="0" width="100%">
					    <tr>
						    <td><strong>Fumante:</strong><br />
    						
						    <table style="width:100%;">
                            <tr>
                                <td style="width: 100px">
						            <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_Habitos_Fumante')" ID="rdoHabitos_Fumante" runat="server" RepeatDirection="Horizontal"
                                                        Width="64px">
                                        <asp:ListItem Value="0" Selected="True">N&#227;o</asp:ListItem>
                                        <asp:ListItem Value="1">Sim</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td> 
                                
                                
                                <table cellpadding="0" cellspacing="0" border="0" id="Tbl_Habitos_Fumante" style="visibility=hidden">
                                <tr>
                                <td>
                                    Quantidade: 
                                    <asp:DropDownList ID="txtHabitos_Fumante_Qtd" runat="server">
                                                <asp:ListItem Value=""><-Selecione-></asp:ListItem>
                                                <asp:ListItem>0 a 10</asp:ListItem>
                                                <asp:ListItem>11 a 20</asp:ListItem>
                                                <asp:ListItem>20 ou mais</asp:ListItem>
                                            </asp:DropDownList>                                
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    Há quantos anos: 
                                    <asp:DropDownList ID="txtHabitos_Fumante_Anos" runat="server">
                                                <asp:ListItem Value=""><-Selecione-></asp:ListItem>
                                                <asp:ListItem>0 a 5</asp:ListItem>
                                                <asp:ListItem>6 a 10</asp:ListItem>
                                                <asp:ListItem>11 a 15</asp:ListItem>
                                                <asp:ListItem>16 a 20</asp:ListItem>
                                                <asp:ListItem>20 ou mais</asp:ListItem>
                                   </asp:DropDownList>  
                                </td>
                                </tr>
                                </table> 
                                                 
                                </td>
                              </tr>
                             </table>
                            
					    </td>
				      </tr>
					    <tr>
						    <td><strong>Bebidas Alcoólicas:</strong><br /><table style="width:100%;">
                            <tr>
                                <td style="width: 100px"><asp:RadioButtonList onclick="MostraOculta(this,'Tbl_Habitos_Bebidas')" ID="rdoHabitos_Bebidas" runat="server" RepeatDirection="Horizontal"
                                                Width="64px">
                                <asp:ListItem Value="0" Selected="True">N&#227;o</asp:ListItem>
                                <asp:ListItem Value="1">Sim</asp:ListItem>
                            </asp:RadioButtonList>
                             </td>
                                <td> 
                                
                                <table cellpadding="0" cellspacing="0" border="0" id="Tbl_Habitos_Bebidas" style="visibility=hidden">
                                <tr>
                                <td>
                                Quantidade:
                                <asp:DropDownList ID="txtHabitos_Bebidas_Qtd" runat="server">
                                    <asp:ListItem Value=""><-Selecione-></asp:ListItem>
                                    <asp:ListItem>Abst&#234;mio</asp:ListItem>
                                    <asp:ListItem>Socialmente</asp:ListItem>
                                    <asp:ListItem>Diariamente</asp:ListItem>
                                </asp:DropDownList>						
						    &nbsp;&nbsp;&nbsp;&nbsp;Há quantos anos:
						    <asp:DropDownList ID="txtHabitos_Bebidas_Anos" runat="server">
						           <asp:ListItem Value=""><-Selecione-></asp:ListItem>
                                   <asp:ListItem>0 a 5</asp:ListItem>
                                   <asp:ListItem>6 a 10</asp:ListItem>
                                   <asp:ListItem>11 a 15</asp:ListItem>
                                   <asp:ListItem>16 a 20</asp:ListItem>
                                   <asp:ListItem>20 ou mais</asp:ListItem>
                                </asp:DropDownList>							
						    </td>
						    </tr>
						    </table>
						    
						    
						    </td>
                              </tr>
                             </table>
						    </td>
				      </tr>
					    <tr>
						    <td><strong>Exercícios Físicos:</strong><br /><table style="width:100%;">
                            <tr>
                                <td style="width: 100px"><asp:RadioButtonList onclick="MostraOculta(this,'Tbl_Habitos_Exercicios')" ID="rdoHabitos_Exercicios" runat="server" RepeatDirection="Horizontal"
                                                Width="64px">
                                <asp:ListItem Value="0" Selected="True">N&#227;o</asp:ListItem>
                                <asp:ListItem Value="1">Sim</asp:ListItem>
                            </asp:RadioButtonList>
                                </td>
                                <td> 
                                
                                <table cellpadding="0" cellspacing="0" border="0" id="Tbl_Habitos_Exercicios" style="visibility=hidden">
                                <tr>
                                <td>
                                Quantidade:
                                <asp:DropDownList ID="txtHabitos_Exercicios_Qtd" runat="server">
                                    <asp:ListItem Value=""><-Selecione-></asp:ListItem>
                                    <asp:ListItem>Esporadico</asp:ListItem>
                                    <asp:ListItem>2x semana</asp:ListItem>
                                    <asp:ListItem>3x ou mais</asp:ListItem>
                                </asp:DropDownList>		
                                </td>
                                </tr>
                                </table>
                                
                                				
						    </td>
                              </tr>
                             </table>
						    </td>
				      </tr>
				    </table>
			    </fieldset>
			    </td>
		    </tr>

		    <tr>
			    <td>
			    <fieldset>
			    <legend>&nbsp;Antecedentes&nbsp;</legend>
				    <table cellpadding="0" cellspacing="0" border="0" width="100%">
					    <tr>
						    <td colspan=2><strong>Já foi afastado do trabalho por algum motivo de saúde?</strong><br /></td>
						</tr>
						<tr>
			                <td style="width: 117px">
			                    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_Antecedentes_Afastamento')" ID="rdoAntecedentes_Afastamento" runat="server" RepeatDirection="Horizontal" Width="64px">
                                    <asp:ListItem Value="0" Selected="True">Não</asp:ListItem>
                                    <asp:ListItem Value="1">Sim</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
						    <td>
						        <table cellpadding="0" cellspacing="0" border="0" id="Tbl_Antecedentes_Afastamento" style="visibility=hidden">
						            <tr>
                                        <td> 
                                            Qual? <asp:TextBox name="Antecedentes_Afastamento_Qual" type="text" size="20" maxlength="256" id="txtAntecedentes_Afastamento_Qual" runat="server" />
						                </td>
						                <td>
						                    Período:
						                </td>
						                <td>
						    	            <asp:DropDownList ID="txtAntecedentes_Afastamento_Qtd_Dias" runat="server">
                                            <asp:ListItem Value=""><-Selecione-></asp:ListItem>
                                            <asp:ListItem>Menos que 15 dias</asp:ListItem>
                                            <asp:ListItem>Mais que 15 dias</asp:ListItem>
                                            </asp:DropDownList>
						                </td>
					                    <td>
						                    Foi aberto CAT?
						                </td>
						                <td>
						    	            <asp:DropDownList ID="txtAntecedentes_Afastamento_CAT" runat="server">
                                            <asp:ListItem Value=""><-></asp:ListItem>
                                            <asp:ListItem>Sim</asp:ListItem>
                                            <asp:ListItem>Não</asp:ListItem>
                                            </asp:DropDownList>
						                </td>
                                      </tr>
                                 </table>
						    </td>
					    </tr>
					    <tr>
						    <td colspan=2><strong>Já sofreu algum acidente de trabalho?</strong><br /></td>
						</tr>
						<tr>
			                <td style="width: 100px">
			                    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_Antecedentes_Acidente')" ID="rdoAntecedentes_Acidente" runat="server" RepeatDirection="Horizontal"
                                                    Width="64px">
                                    <asp:ListItem Value="0" Selected="True">N&#227;o</asp:ListItem>
                                    <asp:ListItem Value="1">Sim</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
						    <td>
						        <table cellpadding="0" cellspacing="0" border="0" id="Tbl_Antecedentes_Acidente" style="visibility=hidden">
						            <tr>
                                        <td style="width: 251px"> Qual?
						                    <asp:TextBox name="Antecedentes_Acidente_Qual" type="text" size="20" maxlength="256" id="txtAntecedentes_Acidente_Qual" runat="server" />
						                </td>
						                <td style="width: 58px">Ano:</td>
						                <td><asp:TextBox type="text"  size="20" maxlength="4" id="txtAntecedentes_Acidente_Ano" onKeyPress="return MascaraCampo(this.form.name, this, '9999', event);" runat="server" Width="34px" /></td>
                                  </tr>
                                 </table>
						    </td>
					    </tr>
					    <tr>
						    <td colspan=2>
						        <strong>No último emprego teve alguma doença relacionada diretamente ao trabalho?</strong><br />
					            (tendinite, tenossinovite, bursite, lombalgia, LER, etc)<br />
					          </td>
                         </tr>
                         <tr>
   					          <td style="width: 100px">
		                        <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_Antecedentes_Doenca')" ID="rdoAntecedentes_Doenca" runat="server" RepeatDirection="Horizontal" Width="64px">
                                <asp:ListItem Value="0" Selected="True">N&#227;o</asp:ListItem>
                                <asp:ListItem Value="1">Sim</asp:ListItem>
                                </asp:RadioButtonList>
                              </td>
                            <td>
					            <table cellpadding="0" cellspacing="0" border="0" id="Tbl_Antecedentes_Doenca" style="visibility=hidden">
					                <tr>
					                    
                                        <td style="width: 250px"> 
                                            Qual?<asp:TextBox name="Antecedentes_Doenca_Qual" type="text" size="20" maxlength="256" id="txtAntecedentes_Doenca_Qual" runat="server" />
						                </td>
						                <td style="width: 57px">Ano:</td>
						                <td><asp:TextBox type="text" size="20" maxlength="4" id="txtAntecedentes_Doenca_Ano" onKeyPress="return MascaraCampo(this.form.name, this, '9999', event);" runat="server" Width="34px" /></td>
                                    </tr>
                                </table>
						    </td>
					    </tr>
				    </table>
			    </fieldset>
			    </td>
		    </tr>

		    <tr>
			    <td>
			    <fieldset>
			    <legend>&nbsp;I.S.D.A.&nbsp;</legend>
				    <table cellpadding="0" cellspacing="0" border="0" width="100%">
					    <tr>
						    <td style="width:160px;"><strong>Sistema Nervoso:</strong></td>
						    <td style="width: 495px;">
							    <table style="width:100%;"><tr><td style="width: 230px">
							    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_ISDA_SistemaNervoso')" ID="rdoISDA_SistemaNervoso" runat="server" RepeatDirection="Horizontal"
                                                Width="220px" >
                                    <asp:ListItem Value="0" Selected="True">Sem altera&#231;&#245;es</asp:ListItem>
                                    <asp:ListItem Value="1">Altera&#231;oes</asp:ListItem>
                                </asp:RadioButtonList>
                                </td><td>
                                
                                <table cellpadding="0" cellspacing="0" border="0" id="Tbl_ISDA_SistemaNervoso" style="visibility=hidden">
                                <tr>
                                <td>
							    <asp:TextBox name="ISDA_SistemaNervoso_Consideracoes" type="text" value=""  size="20" maxlength="256" id="txtISDA_SistemaNervoso_Consideracoes" runat="server"> </asp:TextBox>
							    </td>
							    </tr>
							    </table>
							    
						    </td>
                              </tr>
                             </table>
						    </td>
					    </tr>
					    <tr>
						    <td style="width: 160px;"><strong>Visão:</strong></td>
						    <td style="width: 495px;">
							    <table style="width:100%;"><tr><td style="width: 230px">
							    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_ISDA_Visao')" ID="rdoISDA_Visao" runat="server" RepeatDirection="Horizontal"
                                                Width="220px">
                                    <asp:ListItem Value="0" Selected="True">Sem altera&#231;&#245;es</asp:ListItem>
                                    <asp:ListItem Value="1">Altera&#231;oes</asp:ListItem>
                                </asp:RadioButtonList>
                                </td><td>
                                <table cellpadding="0" cellspacing="0" border="0" id="Tbl_ISDA_Visao" style="visibility=hidden">
                                <tr>
                                <td>
							    <asp:TextBox name="ISDA_Visao_Consideracoes" type="text" value=""  size="20" maxlength="256" id="txtISDA_Visao_Consideracoes" runat="server"> </asp:TextBox>
						        </td>
						        </tr>
						        </table>
						    
						    </td>
                              </tr>
                             </table>
						    </td>
					    </tr>
					    <tr>
						    <td style="width: 160px;"><strong>Audição:</strong></td>
						    <td style="width: 495px;">
							    <table style="width:100%;"><tr><td style="width: 230px">
							    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_ISDA_Audicao')" ID="rdoISDA_Audicao" runat="server" RepeatDirection="Horizontal"
                                                Width="220px">
                                    <asp:ListItem Value="0" Selected="True">Sem altera&#231;&#245;es</asp:ListItem>
                                    <asp:ListItem Value="1">Altera&#231;oes</asp:ListItem>
                                </asp:RadioButtonList>
                                </td><td>
                                
                            <table cellpadding="0" cellspacing="0" border="0" id="Tbl_ISDA_Audicao" style="visibility=hidden">
                            <tr>
                            <td>
							    <asp:TextBox name="ISDA_Audicao_Consideracoes" type="text" value=""  size="20" maxlength="256" id="txtISDA_Audicao_Consideracoes" runat="server"> </asp:TextBox>
						    </td>
						    </tr>
						    </table>
						    
						    </td>
                              </tr>
                             </table>
						    </td>
					    </tr>
					    <tr>
						    <td style="width: 160px"><strong>Sist. Cardiovascular:</strong></td>
						    <td style="width: 495px">
							    <table style="width:100%;"><tr><td style="width: 230px">
							    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_ISDA_SistemaCardiovascular')" ID="rdoISDA_SistemaCardiovascular" runat="server" RepeatDirection="Horizontal"
                                                Width="220px">
                                    <asp:ListItem Value="0" Selected="True">Sem altera&#231;&#245;es</asp:ListItem>
                                    <asp:ListItem Value="1">Altera&#231;oes</asp:ListItem>
                                </asp:RadioButtonList>
                                </td><td>
                                
                                <table cellpadding="0" cellspacing="0" border="0" id="Tbl_ISDA_SistemaCardiovascular" style="visibility=hidden">
                                <tr>
                                <td>
                                <asp:TextBox name="ISDA_SistemaCardiovascular_Consideracoes" type="text" value=""  size="20" maxlength="256" id="txtISDA_SistemaCardiovascular_Consideracoes" runat="server"> </asp:TextBox>
						        </td>
						        </tr>
						        </table>
						    
						    </td>
                              </tr>
                             </table>
						    </td>
					    </tr>
					    <tr>
						    <td style="width: 160px"><strong>Sist. Pulmonar:</strong></td>
						    <td style="width: 495px">
							    <table style="width:100%;"><tr><td style="width: 230px">
							    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_ISDA_SistemaPulmonar')" ID="rdoISDA_SistemaPulmonar" runat="server" RepeatDirection="Horizontal"
                                                Width="220px">
                                    <asp:ListItem Value="0" Selected="True">Sem altera&#231;&#245;es</asp:ListItem>
                                    <asp:ListItem Value="1">Altera&#231;oes</asp:ListItem>
                                </asp:RadioButtonList>
                                </td><td>
                                
                                <table cellpadding="0" cellspacing="0" border="0" id="Tbl_ISDA_SistemaPulmonar" style="visibility=hidden">
                                <tr>
                                <td>
							    <asp:TextBox name="ISDA_SistemaPulmonar_Consideracoes" type="text" value=""  size="20" maxlength="256" id="txtISDA_SistemaPulmonar_Consideracoes" runat="server"> </asp:TextBox>
    							</td>
    							</tr>
    							</table>
    							
						    </td>
                              </tr>
                             </table>
						    </td>
					    </tr>
					    <tr>
						    <td style="width: 160px"><strong>Sist. Gastro-intestinal:</strong></td>
						    <td style="width: 495px">
							    <table style="width:100%;"><tr><td style="width: 230px">
							    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_ISDA_SistemaGastroIntestinal')" ID="rdoISDA_SistemaGastroIntestinal" runat="server" RepeatDirection="Horizontal"
                                                Width="220px">
                                    <asp:ListItem Value="0" Selected="True">Sem altera&#231;&#245;es</asp:ListItem>
                                    <asp:ListItem Value="1">Altera&#231;oes</asp:ListItem>
                                </asp:RadioButtonList>
                                </td><td>
                                
                                <table cellpadding="0" cellspacing="0" border="0" id="Tbl_ISDA_SistemaGastroIntestinal" style="visibility=hidden">
                                <tr>
                                <td>
                                <asp:TextBox name="ISDA_SistemaGastroIntestinal_Consideracoes" type="text" value=""  size="20" maxlength="256" id="txtISDA_SistemaGastroIntestinal_Consideracoes" runat="server"> </asp:TextBox>
                                </td>
                                </tr>
                                </table>
						    </td>
                              </tr>
                             </table>
						    </td>
					    </tr>
					    <tr>
						    <td style="width: 160px"><strong>Sist. Genito-urinário:</strong></td>
						    <td style="width: 495px">
							    <table style="width:100%;"><tr><td style="width: 230px">
							    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_ISDA_SistemaGenitoUrinario')" ID="rdoISDA_SistemaGenitoUrinario" runat="server" RepeatDirection="Horizontal"
                                                Width="220px">
                                    <asp:ListItem Value="0" Selected="True">Sem altera&#231;&#245;es</asp:ListItem>
                                    <asp:ListItem Value="1">Altera&#231;oes</asp:ListItem>
                                </asp:RadioButtonList>
                                </td><td>
                                
                                <table cellpadding="0" cellspacing="0" border="0" id="Tbl_ISDA_SistemaGenitoUrinario" style="visibility=hidden">
                                <tr>
                                <td>
                                <asp:TextBox name="ISDA_SistemaGenitoUrinario_Consideracoes" type="text" value=""  size="20" maxlength="256" id="txtISDA_SistemaGenitoUrinario_Consideracoes" runat="server"> </asp:TextBox>
                                </td>
                                </tr>
                                </table>
						    </td>
                              </tr>
                             </table>
						    </td>
					    </tr>
					    <tr>
						    <td style="width: 160px"><strong>Sist. Osteomolecular:</strong></td>
						    <td style="width: 495px">
							    <table style="width:100%;"><tr><td style="width: 230px">
							    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_ISDA_SistemaOsteomolecular')" ID="rdoISDA_SistemaOsteomolecular" runat="server" RepeatDirection="Horizontal"
                                                Width="220px">
                                    <asp:ListItem Value="0" Selected="True">Sem altera&#231;&#245;es</asp:ListItem>
                                    <asp:ListItem Value="1">Altera&#231;oes</asp:ListItem>
                                </asp:RadioButtonList>
                                    </td><td>
                                    
                                <table cellpadding="0" cellspacing="0" border="0" id="Tbl_ISDA_SistemaOsteomolecular" style="visibility=hidden">
                                <tr>
                                <td>
                                <asp:TextBox name="ISDA_SistemaOsteomolecular_Consideracoes" type="text" value=""  size="20" maxlength="256" id="txtISDA_SistemaOsteomolecular_Consideracoes" runat="server"> </asp:TextBox>
						        </td>
						        </tr>
						        </table>
						    
						    </td>
                              </tr>
                             </table>
						    </td>
					    </tr>
					    <tr>
						    <td style="width: 160px"><strong>Sist. Tegumentar:</strong></td>
						    <td style="width: 495px">
							    <table style="width:100%;"><tr><td style="width: 230px">
							    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_ISDA_SistemaTegumentar')" ID="rdoISDA_SistemaTegumentar" runat="server" RepeatDirection="Horizontal"
                                                Width="220px">
                                    <asp:ListItem Value="0" Selected="True">Sem altera&#231;&#245;es</asp:ListItem>
                                    <asp:ListItem Value="1">Altera&#231;oes</asp:ListItem>
                                </asp:RadioButtonList>
                                </td><td>
                                
                                <table cellpadding="0" cellspacing="0" border="0" id="Tbl_ISDA_SistemaTegumentar" style="visibility=hidden">
                                <tr>
                                <td>
                                <asp:TextBox name="ISDA_SistemaTegumentar_Consideracoes" type="text" value=""  size="20" maxlength="256" id="txtISDA_SistemaTegumentar_Consideracoes" runat="server"> </asp:TextBox>
						        </td>
						        </tr>
						        </table>
						    
						    </td>
                              </tr>
                             </table>
						    </td>
					    </tr>
					    <tr>
						    <td style="width: 160px"><strong>Sist. Imunológico:</strong></td>
						    <td style="width: 495px">
							    <table style="width:100%;"><tr><td style="width: 230px">
							    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_ISDA_SistemaImunologico')" ID="rdoISDA_SistemaImunologico" runat="server" RepeatDirection="Horizontal"
                                                Width="220px">
                                    <asp:ListItem Value="0" Selected="True">Sem altera&#231;&#245;es</asp:ListItem>
                                    <asp:ListItem Value="1">Altera&#231;oes</asp:ListItem>
                                </asp:RadioButtonList>
                                </td><td>
                                
                                <table cellpadding="0" cellspacing="0" border="0" id="Tbl_ISDA_SistemaImunologico" style="visibility=hidden">
                                <tr>
                                <td>
                                <asp:TextBox name="ISDA_SistemaImunologico_Consideracoes" type="text" value=""  size="20" maxlength="256" id="txtISDA_SistemaImunologico_Consideracoes" runat="server"> </asp:TextBox>
                                </td>
                                </tr>
                                </table>
						    </td>
                              </tr>
                             </table>
						    </td>
					    </tr>
				    </table>
			    </fieldset>
			    </td>
		    </tr>

		    <tr>
			    <td>
			    <fieldset>
			    <legend>&nbsp;Exame Físico&nbsp;</legend>
				    <table cellpadding="0" cellspacing="0" border="0" width="100%" id="TABLE1" runat="server">
					    <tr>
						    <td style="width:200px"><strong>Peso:</strong>&nbsp; <asp:TextBox name="ExameFisico_Peso" type="text" size="5" maxlength="6" id="txtExameFisico_Peso" runat="server" onKeyPress="return(FormataMoeda(this,',',',',event))" /><span style="padding-left:1px">Kg</span></td>
						    <td>
						    <strong>Altura:</strong>&nbsp; <asp:TextBox name="ExameFisico_Altura" type="text" size="5" maxlength="4" id="txtExameFisico_Altura" runat="server" onKeyPress="return(FormataMoeda(this,',',',',event))" /><span style="padding-left:1px">m</span>
						    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						    <strong>IMC:</strong>&nbsp; ()
						    </td>
					    </tr>
					    <tr>
						    <td style="width: 200px"><strong>Cabeça e Pescoço:</strong></td>
						    <td><table style="width:100%;"><tr><td style="width: 230px">
							    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_ExameFisico_CabecaPescoco')" ID="rdoExameFisico_CabecaPescoco" runat="server" RepeatDirection="Horizontal"
                                                Width="220px">
                                    <asp:ListItem Value="0" Selected="True">Sem altera&#231;&#245;es</asp:ListItem>
                                    <asp:ListItem Value="1">Altera&#231;oes</asp:ListItem>
                                </asp:RadioButtonList>
                                </td><td>
                                
                                <table cellpadding="0" cellspacing="0" border="0" id="Tbl_ExameFisico_CabecaPescoco" style="visibility=hidden">
                                <tr>
                                <td>
							    <asp:TextBox name="ExameFisico_CabecaPescoco_Consideracoes" type="text" value=""  size="20" maxlength="256" id="txtExameFisico_CabecaPescoco_Consideracoes" runat="server"> </asp:TextBox>
						        </td>
						        </tr>
						        </table>
						    
						    </td>
                              </tr>
                             </table>
						    </td>
					    </tr>
					    <tr>
						    <td colspan=2><strong>Visão:</strong> <asp:TextBox ID="txtExameFisico_Visao" runat="server"></asp:TextBox>
                                </td>
                              
					    </tr>
					    <tr>
						    <td style="width: 200px"><strong>Cardiovascular:</strong></td>
						    <td>
						    <table style="width:100%;"><tr><td style="width: 230px">
							    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_ExameFisico_Cardiovascular')" ID="rdoExameFisico_Cardiovascular" runat="server" RepeatDirection="Horizontal"
                                                Width="220px">
                                    <asp:ListItem Value="0" Selected="True">Sem altera&#231;&#245;es</asp:ListItem>
                                    <asp:ListItem Value="1">Altera&#231;oes</asp:ListItem>
                                </asp:RadioButtonList>
                                </td><td>
                                
                                <table cellpadding="0" cellspacing="0" border="0" id="Tbl_ExameFisico_Cardiovascular" style="visibility=hidden">
                                <tr>
                                <td>
							    <asp:TextBox name="ExameFisico_Cardiovascular_Consideracoes" type="text" value=""  size="20" maxlength="256" id="txtExameFisico_Cardiovascular_Consideracoes" runat="server"> </asp:TextBox>
						        </td>
						        </tr>
						        </table>
						    
						    </td>
                              </tr>
                             </table>
						    </td>
					    </tr>
					    <tr>
						    <td style="width: 200px"><strong>PA:</strong>&nbsp; <asp:TextBox name="ExameFisico_PA" type="text" size="10" maxlength="5" id="txtExameFisico_PA" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99x99', event);" /><span style="padding-left:1px">mm Hg</span></td>
						    <td><strong>Pulso:</strong>&nbsp; <asp:TextBox name="ExameFisico_Pulso" type="text" size="10" maxlength="50" id="txtExameFisico_Pulso" runat="server" /><span style="padding-left:1px">bpm</span></td>
					    </tr>
					    <tr>
						    <td style="width: 200px"><strong>Respiratório:</strong></td>
						    <td>
						    <table style="width:100%;"><tr><td style="width: 230px">
							    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_ExameFisico_Respiratorio')" ID="rdoExameFisico_Respiratorio" runat="server" RepeatDirection="Horizontal"
                                                Width="220px">
                                    <asp:ListItem Value="0" Selected="True">Sem altera&#231;&#245;es</asp:ListItem>
                                    <asp:ListItem Value="1">Altera&#231;oes</asp:ListItem>
                                </asp:RadioButtonList>
                                </td><td>
                                
                                <table cellpadding="0" cellspacing="0" border="0" id="Tbl_ExameFisico_Respiratorio" style="visibility=hidden">
                                <tr>
                                <td>
							    <asp:TextBox name="ExameFisico_Respiratorio_Consideracoes" type="text" value=""  size="20" maxlength="256" id="txtExameFisico_Respiratorio_Consideracoes" runat="server"> </asp:TextBox>
						        </td>
						        </tr>
						        </table>
						    
						    </td>
                              </tr>
                             </table>
						    </td>
					    </tr>
					    <tr>
						    <td style="width: 200px"><strong>Abdômen:</strong></td>
						    <td>
						    <table style="width:100%;"><tr><td style="width: 230px">
							    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_ExameFisico_Abdomen')" ID="rdoExameFisico_Abdomen" runat="server" RepeatDirection="Horizontal"
                                                Width="220px">
                                    <asp:ListItem Value="0" Selected="True">Sem altera&#231;&#245;es</asp:ListItem>
                                    <asp:ListItem Value="1">Altera&#231;oes</asp:ListItem>
                                </asp:RadioButtonList>
                                </td><td>
                                <table cellpadding="0" cellspacing="0" border="0" id="Tbl_ExameFisico_Abdomen" style="visibility=hidden">
                                <tr>
                                <td>
							    <asp:TextBox name="ExameFisico_Abdomen_Consideracoes" type="text" value=""  size="20" maxlength="256" id="txtExameFisico_Abdomen_Consideracoes" runat="server"> </asp:TextBox>
						        </td>
						        </tr>
						        </table>
						    
						    </td>
                              </tr>
                             </table>
						    </td>
					    </tr>
					    <tr>
						    <td style="width: 200px"><strong>Membros Superiores:</strong></td>
						    <td>
						    <table style="width:100%;"><tr><td style="width: 230px">
							    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_ExameFisico_MembrosSuperiores')" ID="rdoExameFisico_MembrosSuperiores" runat="server" RepeatDirection="Horizontal"
                                                Width="220px">
                                    <asp:ListItem Value="0" Selected="True">Sem altera&#231;&#245;es</asp:ListItem>
                                    <asp:ListItem Value="1">Altera&#231;oes</asp:ListItem>
                                </asp:RadioButtonList>
                                </td><td>
                                
                                <table cellpadding="0" cellspacing="0" border="0" id="Tbl_ExameFisico_MembrosSuperiores" style="visibility=hidden">
                                <tr>
                                <td>
							    <asp:TextBox name="ExameFisico_MembrosSuperiores_Consideracoes" type="text" value=""  size="20" maxlength="256" id="txtExameFisico_MembrosSuperiores_Consideracoes" runat="server"> </asp:TextBox>
						        </td>
						        </tr>
						        </table>
						    
						    </td>
                              </tr>
                             </table>
						    </td>
					    </tr>
					    <tr>
						    <td style="width: 200px;"><strong>Membros Inferiores:</strong></td>
						    <td>
						    <table style="width:100%;"><tr><td style="width: 230px">
							    <asp:RadioButtonList onclick="MostraOculta(this,'Tbl_ExameFisico_MembrosInferiores')" ID="rdoExameFisico_MembrosInferiores" runat="server" RepeatDirection="Horizontal"
                                                Width="220px">
                                    <asp:ListItem Value="0" Selected="True">Sem altera&#231;&#245;es</asp:ListItem>
                                    <asp:ListItem Value="1">Altera&#231;oes</asp:ListItem>
                                </asp:RadioButtonList>
                                </td><td>
                                
                                <table cellpadding="0" cellspacing="0" border="0" id="Tbl_ExameFisico_MembrosInferiores" style="visibility=hidden">
                                <tr>
                                <td>
							    <asp:TextBox name="ExameFisico_MembrosInferiores_Consideracoes" type="text" value=""  size="20" maxlength="256" id="txtExameFisico_MembrosInferiores_Consideracoes" runat="server"> </asp:TextBox>
						        </td>
						        </tr>
						        </table>
						    
						    </td>
                              </tr>
                             </table>
						    </td>
					    </tr>
				    </table>
			    </fieldset>
                </td>
		    </tr>

		    <tr>
			    <td>
			    <fieldset>
			    <legend>&nbsp;Exames complementares&nbsp;</legend>
				    <table cellpadding="0" cellspacing="0" border="0" width="100%">
					    <tr>
						    <td><strong>Encaminhamento(s):</strong></td>
						    <td>&nbsp;</td>
					    </tr>
					    <tr>
						    <td colspan="2"><strong>Observações:</strong><br />
                                &nbsp;<asp:TextBox ID="txtExamesComplementares_Observacoes" runat="server" Columns="80"
                                    Rows="4" TextMode="MultiLine" Width="600px"></asp:TextBox></td>
					    </tr>
					    <tr>
					      <td colspan="2" ><strong>Conclusão:</strong>&nbsp; <asp:RadioButtonList ID="RadioButtonList35" runat="server" RepeatDirection="Horizontal"
                                                Width="64px">
                              <asp:ListItem Value="Apto">Apto</asp:ListItem>
                              <asp:ListItem Value="Inapto">Inapto</asp:ListItem>
                              <asp:ListItem>Pendente</asp:ListItem>
                          </asp:RadioButtonList></td>
					    </tr>
					    <tr>
						    <td ><strong>Diagnóticos:</strong></td>
						    <td >&nbsp;</td>
					    </tr>
					    <tr>
						    <td>
						    <strong>CID Principal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>&nbsp; <asp:TextBox name="ExamesComplementares_CID" type="text" size="30" maxlength="4" id="txtCID10_Primario" runat="server" Width="51px" />
						    <a href="javascript:AbrePopUp('../Tabelas/CID10/PopUp/CID10PopUp.aspx?Tipo=2','750','500',this,event)"><img src="\SaudeOcupacional\Template\img\pesquisa.gif" border="0" WIDTH="15" HEIGHT="13"></a>
						    <br>
						    <strong>CID Secundário:&nbsp;</strong>&nbsp; <asp:TextBox name="txtCID10_Secundario_1" type="text" size="30" maxlength="4" id="txtCID10_Secundario_1" runat="server" Width="51px" />
						    <a href="javascript:AbrePopUp('../Tabelas/CID10/PopUp/CID10PopUp.aspx?Tipo=3','750','500',this,event)"><img src="\SaudeOcupacional\Template\img\pesquisa.gif" border="0" WIDTH="15" HEIGHT="13"></a>
						    <br>
						    <strong>CID Secundário:&nbsp;</strong>&nbsp; <asp:TextBox name="txtCID10_Secundario_2" type="text" size="30" maxlength="4" id="txtCID10_Secundario_2" runat="server" Width="50px" />
						    <a href="javascript:AbrePopUp('../Tabelas/CID10/PopUp/CID10PopUp.aspx?Tipo=4','750','500',this,event)"><img src="\SaudeOcupacional\Template\img\pesquisa.gif" border="0" WIDTH="15" HEIGHT="13"></a>
						    
						   </td>
					    </tr>
					    <tr>
						    <td colspan="2"><strong>Médico Examinador:</strong>&nbsp;  <asp:TextBox name="ExamesComplementares_MedicoResponsavel" type="text" size="30" maxlength="30" id="Text37" runat="server" /></td>
					    </tr>
				    </table>
			    </fieldset>                
              </td>
		    </tr>
		    <tr><td align=center><asp:Button ID="BtnSalvar" runat="server" OnClick="BtnSalvar_Click" Text="Salvar" /></td></tr>
</table>

        <td><div style="width:2px"></div></td>
        
        <td style="width:160px; border:0px solid #000000; padding:0px 5px 5px 5px;" valign="top" id="Historico">
            
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="DeleteProntuarioClinico" SelectMethod="SelectProntuarioClinicoByID" TypeName="ProntuarioClinicoDAL">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="Int32" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="idFuncionario" QueryStringField="idFuncionario" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <fieldset>
            <legend> Histórico </legend>
            <table width="100%" height="898" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td valign=top >           
                    
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow"
                        BorderColor="Tan" BorderWidth="1px" CellPadding="2"
                        DataSourceID="ObjectDataSource1" ShowHeader="False" GridLines="None" Width="100%" CssClass="texto" ForeColor="Black" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" DataKeyNames="ID">
                        <FooterStyle BackColor="Tan" />
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
                            <asp:BoundField DataField="dtCadastro" />
                            <asp:CommandField ShowSelectButton="True" ButtonType="Image" SelectImageUrl="~/Template/Img/alterar.gif" />
                        </Columns>
                        <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                        <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="Tan" Font-Bold="True" />
                        <AlternatingRowStyle BackColor="PaleGoldenrod" />
                    </asp:GridView>
                    
                    </td>
                </tr>
            </table>
            </fieldset>
        </td>
        
 	   </tr>	
</table>

<script type="text/javascript" language="Javascript">
//JavaScript abaixo é sempre executado.
//Como sempre é trazido o ultimo registro do funcionario ja carregado na tela então o javascript mostra os campos que
//iniciam escondidos

//Antecedentes Pessoais
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoAnamnese_AntecedentesPessoais_Tumores.id + '_1').checked == true){
document.getElementById('Tbl_AntecedentesPessoais_Tumores_Cancer').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoAnamnese_AntecedentesPessoais_Alergias.id + '_1').checked == true){
document.getElementById('Tbl_AntecedentesPessoais_Alergias').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoAnamnese_AntecedentesPessoais_Internacoes.id + '_1').checked == true){
document.getElementById('Tbl_AntecedentesPessoais_Internacoes').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoAnamnese_AntecedentesPessoais_Cirugias.id + '_1').checked == true){
document.getElementById('Tbl_AntecedentesPessoais_Cirugias').style.visibility="visible"; 
}
//Antecedentes Obstétricos
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoAnamnese_AntecedentesObstetricos_Gestacoes.id + '_1').checked == true){
document.getElementById('Tbl_AntecedentesObstetricos_Gestacoes').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoAnamnese_AntecedentesObstetricos_Partos.id + '_1').checked == true){
document.getElementById('Tbl_AntecedentesObstetricos_Partos').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoAnamnese_AntecedentesObstetricos_Abortos.id + '_1').checked == true){
document.getElementById('Tbl_AntecedentesObstetricos_Abortos').style.visibility="visible"; 
}
//Hábitos
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoHabitos_Fumante.id + '_1').checked == true){
document.getElementById('Tbl_Habitos_Fumante').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoHabitos_Bebidas.id + '_1').checked == true){
document.getElementById('Tbl_Habitos_Bebidas').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoHabitos_Exercicios.id + '_1').checked == true){
document.getElementById('Tbl_Habitos_Exercicios').style.visibility="visible"; 
}
//Antecedentes
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoAntecedentes_Afastamento.id + '_1').checked == true){
document.getElementById('Tbl_Antecedentes_Afastamento').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoAntecedentes_Acidente.id + '_1').checked == true){
document.getElementById('Tbl_Antecedentes_Acidente').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoAntecedentes_Doenca.id + '_1').checked == true){
document.getElementById('Tbl_Antecedentes_Doenca').style.visibility="visible"; 
}
//I.S.D.A
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoISDA_SistemaNervoso.id + '_1').checked == true){
document.getElementById('Tbl_ISDA_SistemaNervoso').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoISDA_Visao.id + '_1').checked == true){
document.getElementById('Tbl_ISDA_Visao').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoISDA_Audicao.id + '_1').checked == true){
document.getElementById('Tbl_ISDA_Audicao').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoISDA_SistemaCardiovascular.id + '_1').checked == true){
document.getElementById('Tbl_ISDA_SistemaCardiovascular').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoISDA_SistemaPulmonar.id + '_1').checked == true){
document.getElementById('Tbl_ISDA_SistemaPulmonar').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoISDA_SistemaGastroIntestinal.id + '_1').checked == true){
document.getElementById('Tbl_ISDA_SistemaGastroIntestinal').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoISDA_SistemaGenitoUrinario.id + '_1').checked == true){
document.getElementById('Tbl_ISDA_SistemaGenitoUrinario').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoISDA_SistemaOsteomolecular.id + '_1').checked == true){
document.getElementById('Tbl_ISDA_SistemaOsteomolecular').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoISDA_SistemaTegumentar.id + '_1').checked == true){
document.getElementById('Tbl_ISDA_SistemaTegumentar').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoISDA_SistemaImunologico.id + '_1').checked == true){
document.getElementById('Tbl_ISDA_SistemaImunologico').style.visibility="visible"; 
}
//Exame Físico
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoExameFisico_CabecaPescoco.id + '_1').checked == true){
document.getElementById('Tbl_ExameFisico_CabecaPescoco').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoExameFisico_Cardiovascular.id + '_1').checked == true){
document.getElementById('Tbl_ExameFisico_Cardiovascular').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoExameFisico_Respiratorio.id + '_1').checked == true){
document.getElementById('Tbl_ExameFisico_Respiratorio').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoExameFisico_Abdomen.id + '_1').checked == true){
document.getElementById('Tbl_ExameFisico_Abdomen').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoExameFisico_MembrosSuperiores.id + '_1').checked == true){
document.getElementById('Tbl_ExameFisico_MembrosSuperiores').style.visibility="visible"; 
}
if(MM_findObj(ctl00_ContentPlaceHolder1_rdoExameFisico_MembrosInferiores.id + '_1').checked == true){
document.getElementById('Tbl_ExameFisico_MembrosInferiores').style.visibility="visible"; 
}
</script>
 </asp:Content>		   
		   
	   
	   
		   
        
	   
   	

