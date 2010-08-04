<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true"
    CodeFile="CadastroDeRiscos.aspx.cs" Inherits="Riscos_CadastroDeRiscos" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset>
        <legend align="center">Cadastro de Riscos</legend>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
            <tr>
                <td colspan="8">
                    Risco:</td>
            </tr>
            <tr>
                <td colspan="8">
                    <label>
                        <select name="select">
                            <option>&lt;-- Selecione Agente Fisico ou Qu&iacute;mico --&gt;</option>
                            <option>Ru&iacute;do</option>
                            <option>Radia&ccedil;&otilde;es Ionizantes</option>
                            <option>Vibra&ccedil;&otilde;es</option>
                            <option>Calor</option>
                            <option>Frio</option>
                            <option>Radia&ccedil;&otilde;es n&atilde;o Ionizantes</option>
                            <option>Produtos de Limpeza</option>
                            <option>V&iacute;rus</option>
                            <option>Bac&eacute;rias</option>
                            <option>Registro de Dados</option>
                        </select>
                    </label>
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
            <tr>
                <td width="16%">
                    Local:</td>
                <td width="1%">
                    &nbsp;</td>
                <td width="16%">
                    Causa:</td>
                <td width="1%">
                    &nbsp;</td>
                <td width="60%">
                    Fonte:</td>
            </tr>
            <tr>
                <td>
                    <label>
                        <input type="text" name="textfield" />
                    </label>
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    <input type="text" name="textfield2" /></td>
                <td>
                    &nbsp;</td>
                <td>
                    <input type="text" name="textfield3" /></td>
            </tr>
            <tr>
                <td colspan="5">
                    &nbsp;</td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
            <tr>
                <td colspan="8">
                    Efeito</td>
            </tr>
            <tr>
                <td width="2%">
                    1&ordm;</td>
                <td width="16%">
                    <input type="text" name="textfield4" /></td>
                <td width="2%">
                    2&ordm;</td>
                <td width="15%">
                    <input type="text" name="textfield42" /></td>
                <td width="3%">
                    3&ordm;</td>
                <td width="16%">
                    <input type="text" name="textfield43" /></td>
                <td width="2%">
                    4&ordm;</td>
                <td width="44%">
                    <input type="text" name="textfield44" /></td>
            </tr>
            <tr>
                <td colspan="8">
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="8">
                    Cat. Risco:</td>
            </tr>
            <tr>
                <td colspan="8">
                    <label>
                        <select name="select2">
                            <option>&lt;-- Selecione o tipo de Cat. Risco --&gt;</option>
                            <option>I</option>
                            <option>II</option>
                            <option>III</option>
                            <option>IV</option>
                            <option>V</option>
                        </select>
                    </label>
                </td>
            </tr>
            <tr>
                <td colspan="8">
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="8">
                    Proposta Medidas de Controle</td>
            </tr>
            <tr>
                <td>
                    <label>
                        1&ordm;</label></td>
                <td colspan="7">
                    <input type="text" name="textfield5" /></td>
            </tr>
            <tr>
                <td>
                    2&ordm;</td>
                <td colspan="7">
                    <input type="text" name="textfield52" /></td>
            </tr>
            <tr>
                <td>
                    3&ordm;</td>
                <td colspan="7">
                    <input type="text" name="textfield53" /></td>
            </tr>
            <tr>
                <td>
                    4&ordm;</td>
                <td colspan="7">
                    <input type="text" name="textfield54" /></td>
            </tr>
            <tr>
                <td>
                    5&ordm;</td>
                <td colspan="7">
                    <input type="text" name="textfield55" /></td>
            </tr>
            <tr>
                <td colspan="8">
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="8">
                    A&ccedil;&atilde;o:</td>
            </tr>
            <tr>
                <td>
                    <label>
                        1&ordm;</label></td>
                <td colspan="7">
                    <input type="text" name="textfield5" width="600" /></td>
            </tr>
            <tr>
                <td>
                    2&ordm;</td>
                <td colspan="7">
                    <input type="text" name="textfield56" width="600" /></td>
            </tr>
            <tr>
                <td>
                    3&ordm;</td>
                <td colspan="7">
                    <input type="text" name="textfield57" width="600" /></td>
            </tr>
            <tr>
                <td>
                    4&ordm;</td>
                <td colspan="7">
                    <input type="text" name="textfield58" width="600" /></td>
            </tr>
            <tr>
                <td>
                    5&ordm;</td>
                <td colspan="7">
                    <input type="text" name="textfield59" width="600" /></td>
            </tr>
            <tr>
                <td colspan="8">
                    &nbsp;</td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
            <tr>
                <td width="25%">
                    Profissional:</td>
                <td width="2%">
                    &nbsp;</td>
                <td width="73%">
                    Engenheiro do Trabalho:</td>
            </tr>
            <tr>
                <td>
                    <label>
                        <select name="select3" style="width: 205px">
                            <option>&lt;-- Selecione o Profissional --&gt;</option>
                        </select>
                    </label>
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    <select name="select4">
                        <option>&lt;-- Selecione o Engenheiro de Trabalho --&gt;</option>
                    </select>
                </td>
            </tr>
        </table>
    </fieldset>
</asp:Content>
