<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProntuarioClínicoVisualizar.aspx.cs" Inherits="ProntuarioClinico_ProntuarioClínicoVisualizar" %>

<%@ Register Src="../UserControls/ClienteFuncionario/FuncionarioDadosBasicos.ascx"
    TagName="FuncionarioDadosBasicos" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />
</head>
<body>
        <uc1:FuncionarioDadosBasicos ID="FuncionarioDadosBasicos1" runat="server" />
        <fieldset>
        <legend>Data Consulta</legend>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td style="width: 116px"><asp:Label ID="lblDataCadastro" runat="server" Text="Label"></asp:Label></td>
                </tr>
            </table>
            </fieldset>
        <fieldset>
            <legend>Anamese</legend>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        <strong>Histórico</strong></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblAnamnese_Historico" runat="server" Text="Label"></asp:Label><br />
                        <br />
                        <br />
                    </td>
                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td><strong>Antecedentes Pessoais</strong></td>
                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td style="width:145px; height: 16px;">Diabetes:</td>
                    <td style="width: 70px; height: 16px;">
                        <asp:Label ID="lblAnamnese_AntecedentesPessoais_Diabetes" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width:145px;">Hipertensão Arterial:</td>
                    <td style="width: 70px">
                        <asp:Label ID="lblAnamnese_AntecedentesPessoais_HipertensaoArterial" runat="server"
                            Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width:145px;">
                        Tumores/Câncer:</td>
                    <td style="width: 70px">
                        <asp:Label ID="lblAnamnese_AntecedentesPessoais_Tumores" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 60px">
                        CID10:</td>
                    <td style="width: 125px">
                        <asp:Label ID="lblAnamnese_AntecedentesPessoais_Tumores_CID10" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 35px">
                        Ano:</td>
                    <td style="width: 55px">
                        <asp:Label ID="lblAnamnese_AntecedentesPessoais_Tumores_Ano" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 85px">
                        Foi Tratado?</td>
                    <td>
                        <asp:Label ID="lblAnamnese_AntecedentesPessoais_Tumores_Tratado" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width:145px;">
                        Alergias:</td>
                    <td style="width: 70px">
                        <asp:Label ID="lblAnamnese_AntecedentesPessoais_Alergias" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 60px">
                        Quais:</td>
                    <td colspan="3">
                        <asp:Label ID="lblAnamnese_AntecedentesPessoais_Alergias_Quais" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width:145px;">Internações Prévias:</td>
                    <td style="width: 70px">
                        <asp:Label ID="lblAnamnese_AntecedentesPessoais_Internacoes" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 60px">
                        Quais:</td>
                    <td colspan="3">
                        <asp:Label ID="lblAnamnese_AntecedentesPessoais_Internacoes_Quais" runat="server"
                            Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width:145px;">Cirugias Prévias:</td>
                    <td style="width: 70px">
                        <asp:Label ID="lblAnamnese_AntecedentesPessoais_Cirugias" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 60px">
                        Quais:</td>
                    <td colspan="3">
                        <asp:Label ID="lblAnamnese_AntecedentesPessoais_Cirugias_Quais" runat="server" Text="Label"></asp:Label></td>
                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td><strong>Antecedentes Familiares</strong></td>
                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td style="width: 145px">
                        Diabetes:</td>
                    <td>
                        <asp:Label ID="lblAnamnese_AntecedentesFamiliares_Diabetes" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 145px">
                        Hipertensão Arterial:</td>
                    <td>
                        <asp:Label ID="lblAnamnese_AntecedentesFamiliares_HipertensaoArterial" runat="server"
                            Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 145px; height: 13px;">
                        Tumores/Câncer:</td>
                    <td style="height: 13px">
                        <asp:Label ID="lblAnamnese_AntecedentesFamiliares_Tumores" runat="server" Text="Label"></asp:Label></td>
                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td><strong>Antecedentes Obstétricos</strong></td>
                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td style="width: 145px">
                        Gestações Prévias:</td>
                    <td style="width: 70px">
                        <asp:Label ID="lblAnamnese_AntecedentesObstetricos_Gestacoes" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 60px">
                        Quantos:</td>
                    <td>
                        <asp:Label ID="lblAnamnese_AntecedentesObstetricos_Gestacoes_Quantos" runat="server"
                            Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 145px; height: 26px;">
                        Partos:</td>
                    <td style="width: 70px; height: 26px;">
                        <asp:Label ID="lblAnamnese_AntecedentesObstetricos_Partos" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 60px; height: 26px;">
                        Quantos:</td>
                    <td style="height: 26px">
                        <asp:Label ID="lblAnamnese_AntecedentesObstetricos_Partos_Quantos" runat="server"
                            Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 145px">
                        Abortos:</td>
                    <td style="width: 70px">
                        <asp:Label ID="lblAnamnese_AntecedentesObstetricos_Abortos" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 60px">
                        Quantos:</td>
                    <td>
                        <asp:Label ID="lblAnamnese_AntecedentesObstetricos_Abortos_Quantos" runat="server"
                            Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 145px">
                        Data Ult. Menstruação:</td>
                    <td style="width: 70px">
                        <asp:Label ID="lblAnamnese_AntecedentesObstetricos_DtMenstruacao" runat="server"
                            Text="Label"></asp:Label></td>
                    <td style="width: 60px">
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </fieldset>
        <fieldset>
            <legend>Hábitos</legend>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td style="width: 140px">
                        Fumante:</td>
                </tr>
                <tr>
                    <td style="width: 140px">
                        <asp:Label ID="lblHabitos_Fumante" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 80px">
                        Quantidade:</td>
                    <td style="width: 125px">
                        <asp:Label ID="lblHabitos_Fumante_Qtd" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 120px">
                        Há quantos Anos:</td>
                    <td>
                        <asp:Label ID="lblHabitos_Fumante_Anos" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 140px">
                        Bebidas Alcoólicas:</td>
                </tr>
                <tr>
                    <td style="width: 140px">
                        <asp:Label ID="lblHabitos_Bebidas" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 80px">
                        Quantidade:</td>
                    <td style="width: 125px">
                        <asp:Label ID="lblHabitos_Bebidas_Qtd" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 120px">
                        Há quantos Anos:</td>
                    <td>
                        <asp:Label ID="lblHabitos_Bebidas_Anos" runat="server" Text="Label"></asp:Label></td>
                    
                </tr>
                <tr>
                    <td style="width: 140px">
                        Exercícios Físicos:</td>
                </tr>
                <tr>
                    <td style="width: 140px">
                        <asp:Label ID="lblHabitos_Exercicios" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 80px">
                        Quantidade:</td>
                    <td style="width: 125px">
                        <asp:Label ID="lblHabitos_Exercicios_Qtd" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 120px">
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </fieldset>
        <fieldset>
            <legend>Antecedentes</legend>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>Já foi afastado do trabalho por algum motivo de saúde?</td>
                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td style="width: 80px">
                        <asp:Label ID="lblAntecedentes_Afastamento" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 50px">Qual:</td>
                    <td style="width: 60px">
                        <asp:Label ID="lblAntecedentes_Afastamento_Qual" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 60px">
                        Período:</td>
                    <td style="width: 80px">
                        <asp:Label ID="lblAntecedentes_Afastamento_Qtd_Dias" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 120px">
                        Foi aberto CAT?</td>
                    <td>
                        <asp:Label ID="lblAntecedentes_Afastamento_CAT" runat="server" Text="Label"></asp:Label></td>
                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        Já sofreu algum acidente de trabalho?</td>
                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td style="width: 80px">
                        <asp:Label ID="lblAntecedentes_Acidente" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 50px">Qual:</td>
                    <td style="width: 60px">
                        <asp:Label ID="lblAntecedentes_Acidente_Qual" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 60px">
                        Ano:</td>
                    <td>
                        <asp:Label ID="lblAntecedentes_Acidente_Ano" runat="server" Text="Label"></asp:Label></td>
                    
                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>No último emprego teve alguma doença relacionada diretamente ao trabalho?</td>
                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td style="width: 80px">
                        <asp:Label ID="lblAntecedentes_Doenca" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 50px">Qual:</td>
                    <td style="width: 60px">
                        <asp:Label ID="lblAntecedentes_Doenca_Qual" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 60px">
                        Ano:</td>
                    <td>
                        <asp:Label ID="lblAntecedentes_Doenca_Ano" runat="server" Text="Label"></asp:Label></td>
                </tr>
            </table>
        </fieldset>
        <fieldset>
            <legend>I.S.D.A.</legend>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td style="width: 160px">Sistema Nervoso:</td>
                    <td style="width: 160px">
                        <asp:Label ID="lblISDA_SistemaNervoso" runat="server" Text="Label"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblISDA_SistemaNervoso_Consideracoes" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 160px">Visão:</td>
                    <td style="width: 160px">
                        <asp:Label ID="lblISDA_Visao" runat="server" Text="Label"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblISDA_Visao_Consideracoes" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 160px">Audição:</td>
                    <td style="width: 160px">
                        <asp:Label ID="lblISDA_Audicao" runat="server" Text="Label"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblISDA_Audicao_Consideracoes" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 160px">Sist. Cardiovascular:</td>
                    <td style="width: 160px">
                        <asp:Label ID="lblISDA_SistemaCardiovascular" runat="server" Text="Label"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblISDA_SistemaCardiovascular_Consideracoes" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 160px">
                        Sist. Pulmonar:</td>
                    <td style="width: 160px">
                        <asp:Label ID="lblISDA_SistemaPulmonar" runat="server" Text="Label"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblISDA_SistemaPulmonar_Consideracoes" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 160px">
                        Sist. Gastro-intestinal:</td>
                    <td style="width: 160px">
                        <asp:Label ID="lblISDA_SistemaGastroIntestinal" runat="server" Text="Label"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblISDA_SistemaGastroIntestinal_Consideracoes" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 160px; height: 29px;">
                        Sist. Genito-urinário:</td>
                    <td style="width: 160px; height: 29px;">
                        <asp:Label ID="lblISDA_SistemaGenitoUrinario" runat="server" Text="Label"></asp:Label></td>
                    <td style="height: 29px">
                        <asp:Label ID="lblISDA_SistemaGenitoUrinario_Consideracoes" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 160px">
                        Sist. Osteomolecular:</td>
                    <td style="width: 160px">
                        <asp:Label ID="lblISDA_SistemaOsteomolecular" runat="server" Text="Label"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblISDA_SistemaOsteomolecular_Consideracoes" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 160px">
                        Sist. Tegumentar:</td>
                    <td style="width: 160px">
                        <asp:Label ID="lblISDA_SistemaTegumentar" runat="server" Text="Label"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblISDA_SistemaTegumentar_Consideracoes" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 160px">
                        Sist. Imunológico:</td>
                    <td style="width: 160px">
                        <asp:Label ID="lblISDA_SistemaImunologico" runat="server" Text="Label"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblISDA_SistemaImunologico_Consideracoes" runat="server" Text="Label"></asp:Label></td>
                </tr>
            </table>
        </fieldset>
        <fieldset>
            <legend>Exame Físico</legend>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td style="width: 40px">
                        Peso:</td>
                    <td style="width: 44px">
                        <asp:Label ID="lblExameFisico_Peso" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 44px">
                        Altura:</td>
                    <td style="width: 75px">
                        <asp:Label ID="lblExameFisico_Altura" runat="server" Text="Label"></asp:Label></td>
                    <td style="width: 40px">
                        IMC:</td>
                    <td>
                        &nbsp;</td>

                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td style="width: 128px">
                        Cabeça e Pescoço:</td>
                    <td style="width: 75px">
                        <asp:Label ID="lblExameFisico_CabecaPescoco" runat="server" Text="Label"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblExameFisico_CabecaPescoco_Consideracoes" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 128px">
                        Visão:</td>
                    <td colspan="2">
                        <asp:Label ID="lblExameFisico_Visao" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 128px">
                        Cardiovascular:</td>
                    <td style="width: 75px">
                        <asp:Label ID="lblExameFisico_Cardiovascular" runat="server" Text="Label"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblExameFisico_Cardiovascular_Consideracoes" runat="server" Text="Label"></asp:Label></td>
                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td style="width: 128px">
                        PA:</td>
                    <td style="width: 75px">
                        <asp:Label ID="lblExameFisico_PA" runat="server" Text="Label"></asp:Label>&nbsp;</td>
                    <td style="width: 40px">
                        Pulso:</td>
                    <td>
                        <asp:Label ID="lblExameFisico_Pulso" runat="server" Text="Label"></asp:Label></td>
                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td style="width: 128px">
                        Respiratório:</td>
                    <td style="width: 75px">
                        <asp:Label ID="lblExameFisico_Respiratorio" runat="server" Text="Label"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblExameFisico_Respiratorio_Consideracoes" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 128px">
                        Abdomen:</td>
                    <td style="width: 75px">
                        <asp:Label ID="lblExameFisico_Abdomen" runat="server" Text="Label"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblExameFisico_Abdomen_Consideracoes" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 128px; height: 16px;">
                        Membros Superiores:</td>
                    <td style="width: 75px; height: 16px;">
                        <asp:Label ID="lblExameFisico_MembrosSuperiores" runat="server" Text="Label"></asp:Label></td>
                    <td style="height: 16px">
                        <asp:Label ID="lblExameFisico_MembrosSuperiores_Consideracoes" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 128px">
                        Membros Inferiores:</td>
                    <td style="width: 75px">
                        <asp:Label ID="lblExameFisico_MembrosInferiores" runat="server" Text="Label"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblExameFisico_MembrosInferiores_Consideracoes" runat="server" Text="Label"></asp:Label></td>
                </tr>
            </table>
        </fieldset>
        <fieldset>
            <legend>Exames Complementares</legend>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td><strong>Encaminhamento(s)</strong></td>
                </tr>
                <tr>
                    <td>Observações</td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblExamesComplementares_Observacoes" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                    <td>Conclusão</td>
                </tr>
                <tr>
                    <td style="height: 13px"></td>
                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td colspan="2">
                        <strong>
                        Diagnósticos</strong></td>

                </tr>
                <tr>
                    <td style="width: 150px">
                        CID Principal:</td>
                        <td>
                        </td>
                </tr>
                <tr>
                    <td style="width: 150px">
                        CID Secundário:</td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px">
                        CID Secundário:</td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px">
                        Médico Responsavél:</td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px"></td>
                    <td></td>
                </tr>
            </table>
        </fieldset>
        
</body>
</html>
