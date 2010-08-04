<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="PrescricaoMedica.aspx.cs" Inherits="PrescricaoMedica_PrescricaoMedica" Title="SmartCare - Hospital do Rim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<fieldset>
		<legend align="center">Prescrição Médica</legend>
        <fieldset>
            <legend>Dados Paciente</legend>
            <table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="30%">
                        Nome do Paciente </td>
                    <td width="25%">
                        Registro Geral </td>
                    <td width="15%">
                        Quarto/Leito</td>
                    <td width="25%">
                        Data</td>
                </tr>
                <tr>
                    <td>
                        <input id="Text61" style="width: 275px" type="text" /></td>
                    <td>
                        <input id="Text62" style="width: 220px" type="text" /></td>
                    <td>
                        <input id="Text63" style="width: 128px" type="text" /></td>
                    <td>
                        <input id="Text64" type="text" /></td>
                </tr>
            </table>
            <table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="30%">
                        N&ordm; Atendimento </td>
                    <td width="25%">
                        Cor</td>
                    <td width="15%">
                        Idade</td>
                    <td width="25%">
                        Sexo</td>
                </tr>
                <tr>
                    <td>
                        <input id="Text65" style="width: 275px" type="text" /></td>
                    <td>
                        <input id="Text66" style="width: 220px" type="text" /></td>
                    <td>
                        <input id="Text67" style="width: 128px" type="text" /></td>
                    <td>
                        <input id="Text68" type="text" /></td>
                </tr>
            </table>
        </fieldset>      
		<fieldset>
    		<legend>Prescrição</legend>
	    	<table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
		        <tr>
		            <td style="width: 465px">
		                Prescri&ccedil;&atilde;o</td>
		            <td style="width: 44px">
		                Dose</td>
	    	        <td width="10%">
	    	            Via Adm.</td>
		            <td style="width: 135px">
                        Intervalo</td>
		            <td style="width: 74px">
		                Data</td>
		            <td style="width: 54px">
		                Hora</td>
		            <td width="15">
    			        Observações</td>
		        </tr>
		        <tr>
		            <td style="width: 465px">
		                <input id="Text1" type="text" style="width: 460px" /></td>
		            <td style="width: 44px;"><input id="Text8" style="width: 40px" type="text" /></td>
	    	        <td>
	    	            <input id="Text15" style="width: 95px" type="text" /></td>
		            <td width: 135px;">
		                <input id="Text22" style="width: 130px" type="text" /></td>
		            <td style="width: 74px;">
		                <input id="Text29" style="width: 69px" type="text" /></td>
		            <td style="width: 54px;"><input id="Text50" style="width: 49px" type="text" /></td>
		            <td>
		                <input id="Text51" style="width: 128px" type="text" /></td>
		        </tr>
		        <tr>
		            <td style="width: 465px;"><input id="Text2" type="text" style="width: 460px" /></td>
		            <td style="width: 44px;">
		                <input id="Text9" style="width: 40px" type="text" /></td>
	    	        <td>
	    	            <input id="Text16" style="width: 95px" type="text" /></td>
		            <td style="width: 135px;">
    			        <input id="Text23" type="text" style="width: 130px" /></td>
		            <td style="width: 74px;"><input id="Text30" style="width: 69px" type="text" /></td>
		            <td style="width: 54px;"><input id="Text69" style="width: 49px" type="text" /></td>
		            <td>
		                <input id="Text52" style="width: 128px" type="text" /></td>
		        </tr>
		        <tr>
		            <td style="width: 465px"><input id="Text3" type="text" style="width: 460px" /></td>
		            <td style="width: 44px"><input id="Text10" style="width: 40px" type="text" /></td>
	    	        <td>
	    	            <input id="Text17" style="width: 95px" type="text" /></td>
		            <td style="width: 135px">
		                <input id="Text24" type="text" style="width: 130px" /></td>
		            <td style="width: 74px"><input id="Text79" style="width: 69px" type="text" /></td>
		            <td style="width: 54px"><input id="Text70" style="width: 49px" type="text" /></td>
		            <td>
		                <input id="Text53" style="width: 128px" type="text" /></td>
		        </tr>
	  	        <tr>
		            <td style="width: 465px"><input id="Text4" type="text" style="width: 460px" /></td>
		            <td style="width: 44px"><input id="Text11" style="width: 40px" type="text" /></td>
		            <td>
		                <input id="Text18" style="width: 95px" type="text" /></td>
	    	        <td style="width: 135px">
	    	            <input id="Text25" type="text" style="width: 130px" /></td>
		            <td style="width: 74px"><input id="Text31" style="width: 69px" type="text" /></td>
		            <td style="width: 54px"><input id="Text71" style="width: 49px" type="text" /></td>
		            <td>
		                <input id="Text54" style="width: 128px" type="text" /></td>
		        </tr>
		        <tr>
		            <td style="width: 465px"><input id="Text5" type="text" style="width: 460px" /></td>
		            <td style="width: 44px"><input id="Text12" style="width: 40px" type="text" /></td>
		            <td>
		                <input id="Text19" style="width: 95px" type="text" /></td>
	    	        <td style="width: 135px">
	    	            <input id="Text26" type="text" style="width: 130px" /></td>
		            <td style="width: 74px"><input id="Text32" style="width: 69px" type="text" /></td>
		            <td style="width: 54px"><input id="Text72" style="width: 49px" type="text" /></td>
		            <td>
		                <input id="Text55" style="width: 128px" type="text" /></td>
		        </tr>
		        <tr>
		            <td style="width: 465px"><input id="Text6" type="text" style="width: 460px" /></td>
		            <td style="width: 44px"><input id="Text13" style="width: 40px" type="text" /></td>
		            <td>
		                <input id="Text20" style="width: 95px" type="text" /></td>
	    	        <td style="width: 135px">
	    	            <input id="Text27" type="text" style="width: 130px" /></td>
		            <td style="width: 74px"><input id="Text33" style="width: 69px" type="text" /></td>
		            <td style="width: 54px"><input id="Text73" style="width: 49px" type="text" /></td>
		            <td>
		                <input id="Text56" style="width: 128px" type="text" /></td>
		        </tr>
		        <tr>
		            <td style="width: 465px"><input id="Text7" type="text" style="width: 460px" /></td>
		            <td style="width: 44px"><input id="Text14" style="width: 40px" type="text" /></td>
		            <td>
		                <input id="Text21" style="width: 95px" type="text" /></td>
	    	        <td style="width: 135px">
	    	            <input id="Text28" type="text" style="width: 130px" /></td>
		            <td style="width: 74px"><input id="Text34" style="width: 69px" type="text" /></td>
		            <td style="width: 54px"><input id="Text74" style="width: 49px" type="text" /></td>
		            <td>
		                <input id="Text57" style="width: 128px" type="text" /></td>
		        </tr>
		        <tr>  
		            <td style="width: 465px"><input id="Text36" type="text" style="width: 460px" /></td>
	                <td style="width: 44px"><input id="Text37" style="width: 40px" type="text" /></td>
	                <td>
    			        <input id="Text38" style="width: 95px" type="text" /></td>
    	            <td style="width: 135px">
    	                <input id="Text39" type="text" style="width: 130px" /></td>
	                <td style="width: 74px"><input id="Text35" style="width: 69px" type="text" /></td>
	                <td style="width: 54px"><input id="Text75" style="width: 49px" type="text" /></td>
	                <td>
		                <input id="Text58" style="width: 128px" type="text" /></td>
		        </tr>
		        <tr>
		            <td style="width: 465px"><input id="Text41" type="text" style="width: 460px" /></td>
		            <td style="width: 44px"><input id="Text42" style="width: 40px" type="text" /></td>
		            <td>
		                <input id="Text43" style="width: 95px" type="text" /></td>
	    	        <td style="width: 135px">
	    	            <input id="Text44" type="text" style="width: 130px" /></td>
		            <td style="width: 74px"><input id="Text40" style="width: 69px" type="text" /></td>
		            <td style="width: 54px"><input id="Text76" style="width: 49px" type="text" /></td>
		            <td>
		                <input id="Text59" style="width: 128px" type="text" /></td>
		        </tr>
		        <tr>
		            <td style="width: 465px"><input id="Text46" type="text" style="width: 460px" /></td>
		            <td style="width: 44px"><input id="Text47" style="width: 40px" type="text" /></td>
		            <td>
		                <input id="Text48" style="width: 95px" type="text" /></td>
	    	        <td style="width: 135px">
	    	            <input id="Text49" type="text" style="width: 130px" /></td>
		            <td style="width: 74px"><input id="Text45" style="width: 69px" type="text" /></td>
		            <td style="width: 54px"><input id="Text77" style="width: 49px" type="text" /></td>
		            <td>
		                <input id="Text60" style="width: 128px" type="text" /></td>
		        </tr>		
	        </table>
	    </fieldset>
        <fieldset>
	        <legend>Observações</legend>
	        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
		        <tr>
			        <td>
			            <textarea cols="1" id="Textarea2" style="width: 100%; height: 75px"></textarea></td>
		        </tr>
            </table>
        </fieldset>
        <fieldset>
            <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="center">
                        <asp:Button ID="Button1" runat="server" Text="Salvar" OnClick="Button1_Click" /></td>
                </tr>
            </table>
        </fieldset>
    </fieldset>
</asp:Content>

