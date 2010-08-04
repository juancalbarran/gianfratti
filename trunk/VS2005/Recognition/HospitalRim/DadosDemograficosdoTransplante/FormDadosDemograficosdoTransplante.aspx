<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="FormDadosDemograficosdoTransplante.aspx.cs" Inherits="DadosDemograficosdoTransplante_FormDadosDemograficosdoTransplante" Title="SmartCare - Hospital do Rim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<fieldset>
      <legend align="center">Dados Demográficos do Transplante</legend>
	  <fieldset>
        <legend>Dados Paciente</legend>
  <table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="30%">Nome do Paciente </td>
            <td width="25%">Registro Geral </td>
            <td width="15%">Quarto/Leito</td>
            <td width="25%">Data</td>
          </tr>
          <tr>
            <td>
                <input id="Text9" style="width: 275px" type="text" /></td>
            <td>
                <input id="Text11" style="width: 220px" type="text" /></td>
            <td>
                <input id="Text13" style="width: 128px" type="text" /></td>
            <td>
                <input id="Text15" type="text" /></td>
          </tr>
        </table>
        <table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="30%">N&ordm; Atendimento </td>
            <td width="25%">Cor</td>
            <td width="15%">Idade</td>
            <td width="25%">Sexo</td>
          </tr>
          <tr>
            <td>
                <input id="Text10" style="width: 275px" type="text" /></td>
            <td>
                <input id="Text12" style="width: 220px" type="text" /></td>
            <td>
                <input id="Text14" style="width: 128px" type="text" /></td>
            <td>
                <input id="Text16" type="text" /></td>
          </tr>
        </table>
</fieldset>      

	  <fieldset>
	    <legend>Etiologia da IRC</legend>
	    <table class="texto"  width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="8%">
                CID10:</td>
            <td width="8%"><input name="textfield" type="text" style="width: 40px" /></td>
            <td width="84%"><input name="textfield" type="text" style="width: 458px" /></td>
          </tr>
	    </table>
      </fieldset>
	  <fieldset>  
	    <legend>Tipo Sanguineo</legend>
	    <table class="texto"   width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td style="width: 6%">
            <input  name="TipoSanguineo" type="radio" value="radiobutton" id="radiobutton" />
            <label class="texto"  for="radiobutton">O</label>            </td>
            <td style="width: 7%"><input name="TipoSanguineo" type="radio" value="radiobutton" id="radio45" /><label class="texto"  for="radio45">A</label></td>
            <td style="width: 6%"><input name="TipoSanguineo" type="radio" value="radiobutton" id="radio46" /><label class="texto"  for="radio46">B</label></td>
            <td width="84%"><input name="TipoSanguineo" type="radio" value="radiobutton" id="radio47" /><label class="texto"  for="radio47">AB</label></td>
          </tr>
        </table>
	  </fieldset>
	  <fieldset>
	    <legend>Diálise</legend>
	      <table class="texto"  width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td colspan="3">Tempo de Dialise</td>
		      <td colspan="2"><asp:TextBox ID="TextBox1" runat="server" Width="311px"></asp:TextBox></td>
            </tr>
            <tr>
              <td style="width: 8%">
		      <input name="Dialise" type="radio" value="radiobutton" id="radio1" />
              <label class="texto"  for="radiobutton">HD</label>		      </td>
              <td style="width: 11%"><input name="Dialise" type="radio" value="radiobutton" id="radio48" />
                <label class="texto"  for="radio48">CAPD</label></td>
              <td colspan="3"><input name="Dialise" type="radio" value="radiobutton" id="radio49" /><label class="texto"  for="radio49">DPI</label></td>
            </tr>
            <tr>
              <td colspan="3">Local de Di&aacute;lise</td>
              <td colspan="2"><asp:TextBox ID="TextBox2" runat="server" Width="311px"></asp:TextBox></td>
            </tr>
          </table>
    </fieldset>
        <fieldset>
        <legend>Transfusões</legend>
        <table class="texto"  width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="5%">
		    <input name="Transfusoes" type="radio" value="radiobutton" id="radio2" />
            <label class="texto"  for="radiobutton">0</label>		    </td>
            <td style="width: 8%"><input name="Transfusoes" type="radio" value="radiobutton" id="radio41" />
              <label class="texto"  for="radio41">1-5</label></td>
            <td style="width: 9%"><label class="texto"  for="radio41">
              <input name="Transfusoes" type="radio" value="radiobutton" id="radio42" />
5-10</label></td>
            <td style="width: 10%"><label class="texto"  for="radio42">
              <input name="Transfusoes" type="radio" value="radiobutton" id="radio43" />
11-20</label></td>
            <td width="8%"><label class="texto"  for="radiobutton">
              <input name="Transfusoes" type="radio" value="radiobutton" id="radio44" />
&gt;20</label></td>
            <td width="68%"><label class="texto"  for="radio44"></label></td>
          </tr>
          <tr>
            <td colspan="3">&Uacute;ltima Transfus&atilde;o </td>
            <td colspan="3"><input name="textfield" type="text" style="width: 297px" /></td>
          </tr>
        </table>
      </fieldset>  
	  <fieldset>
	    <legend>Gestações</legend>
        <table class="texto"  width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td style="width: 13%">N.&ordm; de Gesta&ccedil;&otilde;es </td>
            <td style="width: 11%"><input name="textfield" type="text" style="width: 104px" /></td>
            <td style="width: 10%">N.&ordm; de Abortos </td>
            <td width="53%"><input name="textfield" type="text" style="width: 110px" /></td>
          </tr>
        </table>		
	  </fieldset>
      <fieldset>
	    <legend>Exame Sanguineo </legend>
        <table class="texto"  width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="11%">Hepatite B </td>
            <td width="10%"><input name="Hepatite B2" type="radio" value="radiobutton" id="radio" />
            <label class="texto"  for="radio">Positivo</label></td>
            <td width="12%"><input name="Hepatite B2" type="radio" value="radiobutton" id="radio5" />
            <label class="texto"  for="radio5">Negativo</label></td>
            <td width="58%"><input name="Hepatite B2" type="radio" value="radiobutton" id="Radio51" />
                <label class="texto"  for="radio5">
                    Não Realizado</label></td>
          </tr>
          <tr>
            <td>Hepatite C </td>
          <td><input name="Hepatite C2" type="radio" value="radiobutton" id="radio3" />
          <label class="texto"  for="radio2">Positivo</label></td>
          <td><input name="Hepatite C2" type="radio" value="radiobutton" id="radio6" />
          <label class="texto"  for="radio6">Negativo</label></td>
          <td><input name="Hepatite C2" type="radio" value="radiobutton" id="Radio52" />
              <label class="texto"  for="radio5">
                  Não Realizado</label>&nbsp;</td>
         </tr>
        <tr>
          <td>HIV</td>
          <td><input name="HIV2" type="radio" value="radiobutton" id="radio4" />
          <label class="texto"  for="radio3">Positivo</label></td>
          <td><input name="HIV2" type="radio" value="radiobutton" id="radio7" />
          <label class="texto"  for="radio7">Negativo</label></td>
          <td><input name="HIV2" type="radio" value="radiobutton" id="Radio53" />
              <label class="texto"  for="radio5">
                  Não Realizado</label></td>
        </tr>
        <tr>
          <td>CMV</td>
          <td><input name="CMV2" type="radio" value="radiobutton" id="radio8" />
          <label class="texto"  for="radio4">Positivo</label></td>
          <td><input name="CMV2" type="radio" value="radiobutton" id="radio9" />
          <label class="texto"  for="radio8">Negativo</label></td>
          <td><input name="CMV2" type="radio" value="radiobutton" id="Radio54" />
              <label class="texto"  for="radio5">
                  Não Realizado</label></td>
        </tr>
      </table>
    </fieldset>
    <fieldset>
      <legend>Raça</legend>
      <table class="texto"  width="100%" border="0" cellpadding="0" cellspacing="0">
	    <tr>
          <td width="12%"><input name="Raca" type="radio" value="radiobutton" id="radio10" />
          <label class="texto"  for="radio9">Branca</label></td>	  
          <td width="11%"><input name="Raca" type="radio" value="radiobutton" id="radio11" />
          <label class="texto"  for="radio10">Mulato</label></td>	  
          <td width="11%"><input name="Raca" type="radio" value="radiobutton" id="radio12" />
          <label class="texto"  for="radio11">Preto</label></td>	  
          <td width="66%"><input name="Raca" type="radio" value="radiobutton" id="radio13" />
          <label class="texto"  for="radio12">Outros</label></td>	  
        </tr>
      </table>
    </fieldset>
    <fieldset>
      <legend>Crossmatch</legend>
      <table class="texto"  width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td style="width: 10%"><input name="Crossmatch" type="radio" value="radiobutton" id="radio14" />
          <label class="texto"  for="radio14">Positivo</label></td>
          <td style="width: 14%"><input name="Crossmatch" type="radio" value="radiobutton" id="radio15" />
          <label class="texto"  for="radio13">Negativo</label></td>
          <td><input name="Crossmatch" type="radio" value="radiobutton" id="Radio59" />
              <label class="texto"  for="radio5">
                  Não Realizado</label></td>
        </tr>
        <tr>
          <td style="width: 10%">Painel</td>
          <td style="width: 14%"><input name="textfield" type="text" style="width: 112px" /></td>
        </tr>
      </table>
    </fieldset>
	<fieldset>
	  <legend>Dados TX</legend>
	  <table class="texto"  width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="8%">TX</td>
          <td width="11%"><input name="TX" type="radio" value="radiobutton" id="radio16" />
          <label class="texto"  for="radio15">1&ordm;</label></td>
          <td width="17%"><input name="TX" type="radio" value="radiobutton" id="radio17" />
          <label class="texto"  for="radio16">2&ordm;</label></td>
          <td width="12%"><input name="TX" type="radio" value="radiobutton" id="radio18" />
          <label class="texto"  for="radio17">3&ordm;</label></td>
          <td width="14%">&nbsp;</td>
          <td width="38%">&nbsp;</td>
        </tr>
        <tr>
          <td>HLA</td>
          <td><input name="HLA" type="radio" value="radiobutton" id="radio19" />
          <label class="texto"  for="radio18">I</label></td>
          <td><input name="HLA" type="radio" value="radiobutton" id="radio20" />
          <label class="texto"  for="radio19">II</label></td>
          <td><input name="HLA" type="radio" value="radiobutton" id="radio21" />
          <label class="texto"  for="radio20">III</label></td>
          <td><input name="HLA" type="radio" value="radiobutton" id="radio22" />
          <label class="texto"  for="radio21">CAD</label></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>NTA</td>
          <td><input name="NTA" type="radio" value="radiobutton" id="radio23" />
          <label class="texto"  for="radio22">Sim</label></td>
          <td><input name="NTA" type="radio" value="radiobutton" id="radio24" />
          <label class="texto"  for="radio23">N&atilde;o</label></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>Dura&ccedil;&atilde;o</td>
          <td colspan="2"><input name="textfield" type="text" size="35%" /></td>
        </tr>
      </table>
    </fieldset>
    <fieldset>
      <legend>HLA Doador</legend>
        <table class="texto"  width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td colspan="3" >Doador:</td>
            <td colspan="4" >Cadaver:</td>
            <td style="width: 80px">Vivo:</td>
          </tr>
          <tr>
            <td colspan="3"><input name="textfield7" type="text" size="30" /></td>
            <td colspan="4"><input name="textfield3" type="text" size="30" /></td>
            <td colspan="3"><input name="textfield5" type="text" style="width: 188px" /></td>
          </tr>
          <tr>
            <td colspan="3">Equipe:</td>
            <td colspan="4">Local:</td>
            <td style="width: 80px">Tempo:</td>
            <td>Idade:</td>
            <td></td>
          </tr>
          <tr>
            <td colspan="3" style="height: 25px"><input name="textfield2" type="text" size="30" /></td>
            <td colspan="4" style="height: 25px"><input name="textfield4" type="text" size="30" /></td>
            <td style="width: 80px; height: 25px"><input name="textfield6" type="text" style="width: 69px" /></td>
            <td width="427" style="height: 25px"><input name="textfield62" type="text" style="width: 107px" /></td>
            <td style="height: 25px"></td>
          </tr>
          <tr>
            <td width="111">Tipo Sanguineo: </td>
            <td width="55"><input name="HLADoadorTipoSanguineo" type="radio" value="radiobutton" id="radio25" />
            <label class="texto"  for="radio24">O</label></td>
            <td width="51"><input name="HLADoadorTipoSanguineo" type="radio" value="radiobutton" id="radio26" />
              <label class="texto"  for="radio25">A</label></td>
            <td width="59"><label class="texto"  for="radio25">
            <input name="HLADoadorTipoSanguineo" type="radio" value="radiobutton" id="radio27" />
B</label></td>
            <td width="61"><input name="HLADoadorTipoSanguineo" type="radio" value="radiobutton" id="radio28" />
              <label class="texto"  for="radio27">AB</label></td>
            <td width="16"><label class="texto"  for="radio26"></label></td>
            <td width="98"><label class="texto"  for="radio27"></label></td>
            <td style="width: 80px"><label class="texto"  for="radio27"></label></td>
            <td colspan="2"><label class="texto"  for="radio27"></label></td>
          </tr>
          <tr>
            <td>Hepatite B : </td>
            <td colspan="2"><input name="HLADoadorHepatiteB" type="radio" value="radiobutton" id="radio29" />
            <label class="texto"  for="radio28">Positivo</label></td>
            <td colspan="2"><input name="HLADoadorHepatiteB" type="radio" value="radiobutton" id="radio32" />
            <label class="texto"  for="radio32">Negativo</label></td>
            <td colspan="3"><input name="HLADoadorHepatiteB" type="radio" value="radiobutton" id="Radio58" />
                <label class="texto"  for="radio5">
                    Não Realizado</label></td>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td>Hepatite C: </td>
            <td colspan="2"><input name="HLADoadorHepatiteC" type="radio" value="radiobutton" id="radio30" />
            <label class="texto"  for="radio29">Positivo</label></td>
            <td colspan="2"><input name="HLADoadorHepatiteC" type="radio" value="radiobutton" id="radio33" />
            <label class="texto"  for="radio33">Negativo</label></td>
            <td colspan="3"><input name="HLADoadorHepatiteC" type="radio" value="radiobutton" id="Radio57" />
                <label class="texto"  for="radio5">
                    Não Realizado</label>&nbsp;</td>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td>HIV:</td>
            <td colspan="2"><input name="HLADoadorHIV" type="radio" value="radiobutton" id="radio31" />
            <label class="texto"  for="radio30">Positivo</label></td>
            <td colspan="2"><input name="HLADoadorHIV" type="radio" value="radiobutton" id="radio34" />
            <label class="texto"  for="radio34">Negativo</label></td>
            <td colspan="3"><input name="HLADoadorHIV" type="radio" value="radiobutton" id="Radio56" />
                <label class="texto"  for="radio5">
                    Não Realizado</label></td>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td height="24">CMV:</td>
            <td colspan="2"><input name="HLADoadorCMV" type="radio" value="radiobutton" id="radio35" />
            <label class="texto"  for="radio31">Positivo</label></td>
            <td colspan="2"><input name="HLADoadorCMV" type="radio" value="radiobutton" id="radio36" />
            <label class="texto"  for="radio35">Negativo</label></td>
            <td colspan="3"><input name="HLADoadorCMV" type="radio" value="radiobutton" id="Radio55" />
                <label class="texto"  for="radio5">
                    Não Realizado</label></td>
            <td colspan="2">&nbsp;</td>
          </tr>
        </table>	
    </fieldset>
	  <fieldset>
	    <legend>HLA Receptor</legend>
        <table class="texto"  width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="14%">TIF:</td>
            <td colspan="2"><input name="textfield2" type="text" size="20%" /></td>
            <td width="10%">
                Horas:</td>
            <td width="57%" colspan="2"><input name="textfield2" type="text" size="20%" /></td>
          </tr>
          <tr>
            <td>TAV:</td>
            <td colspan="2"><input name="textfield" type="text" size="20%" /></td>
            <td>
                Minutos:</td>
            <td colspan="2"><input name="textfield22" type="text" size="20%" /></td>
          </tr>
          <tr>
            <td>A. Ureteral:</td>
            <td colspan="3"><input name="textfield" type="text" size="20%" /></td>
          </tr>
          <tr>
            <td><input name="HLAReceptor" type="radio" value="radiobutton" id="radio37" />
            <label class="texto"  for="radio36">Gregoir</label></td>
            <td width="11%"><input name="HLAReceptor" type="radio" value="radiobutton" id="radio38" />
            <label class="texto"  for="radio37">Politano</label></td>
            <td width="11%"><input name="HLAReceptor" type="radio" value="radiobutton" id="radio39" />
              <label class="texto"  for="radio38">Gilvernet</label></td>
            <td><label class="texto"  for="radio38">
              <input name="HLAReceptor" type="radio" value="radiobutton" id="radio40" />Outros
              </label>
            </td>
            <td colspan="2"><label class="texto"  for="radio39">
              <input name="HLAReceptor" type="radio" value="radiobutton" id="radio50" />Duplo J
              </label>
              <label class="texto"  for="radio40"></label><label class="texto"  for="radio40"></label></td>
          </tr>
          <tr>
            <td>Nome do Cirurgi&atilde;o:</td>
            <td colspan="4"><input name="textfield" type="text" size="50%" /></td>
          </tr>
        </table>
	  </fieldset>
	      <fieldset>
      <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center"><asp:Button ID="Button1" runat="server" Text="Salvar" OnClick="Button1_Click" /></td>
        </tr>
      </table>
    </fieldset>
    </fieldset>
</asp:Content>

