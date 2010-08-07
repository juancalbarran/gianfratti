<?php /* Smarty version 2.3.1, created on 2008-05-01 13:30:51
         compiled from uebimiau/login.htm */ ?>
<?php $this->_load_plugins(array(
array('modifier', 'escape', 'uebimiau/login.htm', 6, false),)); ?><?php $this->_config_load($this->_tpl_vars['umLanguageFile'], "Login", 'local'); ?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <title>
      Uebimiau Webmail - <?php echo $this->_run_mod_handler('escape', true, $this->_config[0]['vars']['lgn_title'], "html"); ?>

    </title>
    <meta http-equiv="Content-Type" content="text/html; charset=<?php echo $this->_config[0]['vars']['default_char_set']; ?>
">
    <link rel="stylesheet" href="themes/uebimiau/webmail.css" type="text/css">
  </head>
  <!--
  Skinned by Arnaud BEAUVOIR - http://forum.beauvoir.net - contact@beauvoir.net
  Thank you to let the copyright in place on the login page and in all sources of pages.
  This skin is the work of an author, thank you to respect it and not to remove the
  copyright, or worse, to put your name at the place.
  -->
  <?php echo $this->_tpl_vars['umJS']; ?>

  <body>
    <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" align="center">
      <tr>
        <td valign="middle" align="center">
          <table width="750" border="0" cellspacing="0" cellpadding="0" align="center">
            <tr>
              <td><img src="themes/uebimiau/images/bandeau-h.gif" border="0"></td>
            </tr>
            <tr>
              <td><img src="themes/uebimiau/images/logo.gif" border="0"></td>
            </tr>
            <tr>
              <td><img src="themes/uebimiau/images/bandeau-h.gif" border="0"></td>
            </tr>
            <tr>
              <td background="themes/uebimiau/images/ligne-fond.gif">
                <table width="350" border="0" cellspacing="1" cellpadding="1" align="center">
                  <form name="form1" action="process.php" method=post>
                    <tr>
                      <td align="center" colspan="2">
                        <br>.: 
                        <b><?php echo $this->_config[0]['vars']['lgn_welcome_msg']; ?>
</b>
                        :.
                        <br>
                      </td>
                    </tr>
                    <tr>
                      <td>&nbsp;
                        
                      </td>
                    </tr>
                    <?php if ($this->_tpl_vars['umServerType'] != "ONE-FOR-EACH"): ?>
                    <tr>
                      <td align="left" width="40%">
                        <b><?php echo $this->_config[0]['vars']['lng_user_email']; ?>
</b>
                        :
                      </td>
                      <td>
                        <input type="text" name="f_email" value="<?php echo $this->_tpl_vars['umEmail']; ?>
" class="normal" style="width: 140px; border: 1 solid #7F9DB9;">
                      </td>
                    </tr>
                    <?php else: ?>
                    <tr>
                      <td align="left" width="40%">
                        <b><?php echo $this->_config[0]['vars']['lng_user_name']; ?>
</b>
                        :
                      </td>
                      <td>
                        <input type="text" name="f_user" value="<?php echo $this->_tpl_vars['umUser']; ?>
" class="normal" style="width: 80px; border: 1 solid #7F9DB9">
                        <?php if ($this->_tpl_vars['umAvailableServers'] != 0): ?> 
                        <b><?php echo $this->_tpl_vars['umServer']; ?>
</b>
                        <?php endif; ?>
                      </td>
                    </tr>
                    <?php endif; ?>
                    <tr>
                      <td align="left" width="40%">
                        <b><?php echo $this->_config[0]['vars']['lng_user_pwd']; ?>
</b>
                        :
                      </td>
                      <td>
                        <input type="password" name="f_pass" class="normal" style="width: 80px; border: 1 solid #7F9DB9">
                      </td>
                    </tr>
                    <?php if ($this->_tpl_vars['umAllowSelectLanguage']): ?>
                    <tr>
                      <td align="left" width="40%">
                        <b><?php echo $this->_config[0]['vars']['lng_language']; ?>
</b>
                        :
                      </td>
                      <td>
                        <?php echo $this->_tpl_vars['umLanguages']; ?>

                      </td>
                    </tr>
                    <?php endif; ?>
                    <?php if ($this->_tpl_vars['umAllowSelectTheme']): ?>
                    <tr>
                      <td align="left">
                        <b><?php echo $this->_config[0]['vars']['lng_theme']; ?>
</b>
                        :
                      </td>
                      <td>
                        <?php echo $this->_tpl_vars['umThemes']; ?>

                      </td>
                    </tr>
                    <?php endif; ?>
                    <tr>
                      <td>&nbsp;
                        
                      </td>
                    </tr>
                    <tr>
                      <td class="left">
                      </td>
                      <td>
                        <input type="submit" name="submit" value="<?php echo $this->_config[0]['vars']['lng_login_btn']; ?>
" class="button">
                      </td>
                    </tr>
                    <tr>
                      <td>&nbsp;
                        
                      </td>
                    </tr>
                  </form>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <map name="Uebimiau">
                  <area shape="rect" coords="318,5,371,18" href="http://www.uebimiau.org" target="_blank">
                  <area shape="rect" coords="442,5,552,16" href="http://forum.beauvoir.net" target="_blank">
                </map>
                <img src="themes/uebimiau/images/bandeau-b.gif" border="0" width="750" height="25" alt="Webmail powered by Uebimiau - Skinned by Forum.beauvoir.net" usemap="#Uebimiau">
              </td>
              <tr>
          </table>
        </td>
      </tr>
    </table>
  </body>
</html>