<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html"/> 

	<xsl:template name="shop_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Shop Manager</xsl:with-param>
			<xsl:with-param name="version">0.1</xsl:with-param>
			<xsl:with-param name="moddate">20.11.2003</xsl:with-param>
			<xsl:with-param name="author">JeS (Jens Schreiber)</xsl:with-param>
			<xsl:with-param name="url">http://www.fxmods.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--            main procedure            -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

	<xsl:template name="ai-manage-shop">
		<xsl:call-template name="ai-shop-navigator"/>
		
		<xsl:choose>
			<xsl:when test="$id='new'">
				<xsl:choose>
					<xsl:when test="$type='shop'">
						<xsl:call-template name="ai-shop-shopadd"/>
					</xsl:when>
					<xsl:when test="$type='category'">
						<xsl:call-template name="ai-shop-categoryadd"/>
					</xsl:when>
					<xsl:when test="$type='product'">
						<xsl:call-template name="ai-shop-productadd"/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$id or $shop">
				<xsl:choose>
					<xsl:when test="$type='shop'">
						<xsl:for-each select="document($shopfile)/shops/shop[id=$shop]">
							<xsl:call-template name="ai-shop-shopupdate"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="$id and $type='category'">
						<xsl:for-each select="document($shopfile)/shops/shop[id=$shop]/categories/category[id=$id]">
							<xsl:call-template name="ai-shop-categoryupdate"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="$id and $type='product'">
						<xsl:for-each select="document($shopfile)/shops/shop[id=$shop]/products/product[id=$id]">
							<xsl:call-template name="ai-shop-productupdate"/>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="ai-shop-shoplist"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="ai-shop-navigator">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr>
				<td align="center">
					<a href="?ACT=1&amp;SECT={$section}&amp;id={$id}">
						<img src="admin/media/shop.gif" border="0"/>
					</a>
				</td>
				<td align="center"><font size="3">Shop</font></td>
			</tr>
		</table>
	</xsl:template>
	
	<xsl:template name="ai-shop-shoplist">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">
			<tr>
				<td class="header" width="16">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td class="header" width="50">id</td>
				<td class="header">name</td>
			</tr>
			<xsl:for-each select="document($shopfile)/shops/shop">
				<tr bgcolor="white" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);" ondblclick="goto('?ACT=1&amp;SECT={$section}&amp;type=shop&amp;shop={$id}&amp;id={id}');">
					<td><a href="#"><img src="admin/media/{visible}.gif" width="16" height="15" border="0"/></a></td>
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2">
						<a href="?ACT=1&amp;SECT={$section}&amp;type=shop&amp;shop={id}">
							<xsl:value-of select="name"/>
						</a>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<input type="submit" value="new" onclick="document.location.href='?ACT=1&amp;SECT={$section}&amp;type=shop&amp;id=new';"/>
	</xsl:template>
	
	<xsl:template name="ai-shop-categorylist">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">
			<tr>
				<td class="header" width="16">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td class="header" width="50">id</td>
				<td class="header">name</td>
			</tr>
			<xsl:for-each select="document($shopfile)/shops/shop[id=$shop]/categories/category">
				<tr bgcolor="white" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);" ondblclick="goto('?ACT=1&amp;SECT={$section}&amp;shop={$shop}&amp;type=category&amp;id={id}');">
					<td><a href="#"><img src="admin/media/{visible}.gif" width="16" height="15" border="0"/></a></td>
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2">
						<a href="?ACT=1&amp;SECT={$section}&amp;shop={$shop}&amp;type=category&amp;id={id}">
							<xsl:value-of select="name"/>
						</a>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<input type="submit" value="new" onclick="document.location.href='?ACT=1&amp;SECT={$section}&amp;shop={$shop}&amp;type=category&amp;id=new';"/>
	</xsl:template>
	
	<xsl:template name="ai-shop-productlist">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">
			<tr>
				<td class="header" width="16">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td class="header" width="50">id</td>
				<td class="header">name</td>
			</tr>
			<xsl:for-each select="document($shopfile)/shops/shop[id=$shop]/products/product[category=$id]">
				<tr bgcolor="white" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);" ondblclick="goto('?ACT=1&amp;SECT={$section}&amp;shop={$shop}&amp;type=product&amp;id={id}');">
					<td><a href="#"><img src="admin/media/{visible}.gif" width="16" height="15" border="0"/></a></td>
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2">
						<a href="?ACT=1&amp;SECT={$section}&amp;shop={$shop}&amp;type=product&amp;id={id}">
							<xsl:value-of select="name"/>
						</a>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<input type="submit" value="new" onclick="document.location.href='?ACT=1&amp;SECT={$section}&amp;shop={$shop}&amp;type=product&amp;id=new';"/>
	</xsl:template>
	
	<xsl:template name="ai-shop-shopadd">
		<table bgcolor="white">
			<form action="?ACT=1&amp;SECT={$section}&amp;type={$type}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="shop"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="bloc" value="shops"/>
						<input type="hidden" name="node" value="shop"/>
						<input type="hidden" name="categories" value=""/>
						<input type="hidden" name="products" value=""/>

						<table class="block">
							<tr>
								<td class="xp_sel">
									Name:
								</td>
								<td>
									<input type="text" name="name" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									Description:
								</td>
								<td>
									<textarea  class="textarea" name="description" title="Description"></textarea>
									<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('description');</script></xsl:if>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									Payment:
								</td>
								<td>
									<select name="payment">
										<option value="paypal">PayPal</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									visible:
								</td>
								<td>
									<select name="visible">
										<option value="off"><xsl:value-of select="$string[61]"/></option>
										<option value="on"><xsl:attribute name="selected">selected</xsl:attribute><xsl:value-of select="$string[60]"/></option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='?ACT=1&amp;SECT={$section}&amp;type={$type}';"/>
								</td>
							</tr>
						</table>
						<br/>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>
	
	<xsl:template name="ai-shop-shopupdate">
		<table bgcolor="white">
			<form action="?ACT=1&amp;SECT={$section}&amp;type={$type}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="shop"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="shops/shop[id={$shop}]"/>

						<table class="block">
							<tr>
								<td class="xp_sel">
									Name:
								</td>
								<td>
									<input type="text" name="name" value="{name}" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									Description:
								</td>
								<td>
									<textarea  class="textarea" name="description" title="Description">
										<xsl:value-of select="description"/>
									</textarea>
									<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('description');</script></xsl:if>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									Payment:
								</td>
								<td>
									<select name="payment">
										<option value="paypal">
											<xsl:attribute name="selected">selected</xsl:attribute>
											PayPal
										</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									visible:
								</td>
								<td>
									<select name="visible">
										<option value="off">
											<xsl:if test="visible='off'">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="$string[61]"/>
										</option>
										<option value="on">
											<xsl:if test="visible='on'">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="$string[60]"/>
										</option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='?ACT=1&amp;SECT={$section}&amp;type={$type}';"/>
								</td>
							</tr>
						</table>
						<br/>
					</td>
				</tr>
			</form>
			<xsl:if test="$usertype='administrator'">
				<tr>
					<td>
						<form action="?ACT=1&amp;SECT={$section}&amp;type={$type}" method="post" onsubmit="return confirm('{$string[83]}');">
							<table class="block">
								<tr>
									<td bgcolor="white" align="right">
								    	<input type="hidden" name="file" value="shop"/>
										<input type="hidden" name="operation" value="delete"/>
										<input type="hidden" name="node" value="shop/shops[id={$shop}]"/>
										<input type="submit" value="{$string[16]}"/>
									</td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</xsl:if>
		</table>
		<xsl:call-template name="ai-shop-categorylist"/>		
	</xsl:template>
	
	<xsl:template name="ai-shop-categoryselectentry">
		<xsl:param name="selcatid"/>
		
		<xsl:variable name="categoryid">
			<xsl:value-of select="id"/>
		</xsl:variable>
		
		<option value="0">No</option>
		<xsl:choose>
			<xsl:when test="$selcatid=$categoryid">
				<option value="{$categoryid}">
					<xsl:attribute name="selected">selected</xsl:attribute>
					<xsl:value-of select="name"/>
				</option>
			</xsl:when>
			<xsl:otherwise>
				<option value="{$categoryid}">
					<xsl:value-of select="name"/>
				</option>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="ai-shop-categoryselect">
		<xsl:param name="inputname"/>
		<xsl:param name="shopid"/>
		<xsl:param name="selcatid"/>		
		
		<select name="{$inputname}">
			<xsl:for-each select="document($shopfile)/shops/shop[$shopid]/categories/category">
				<xsl:sort select="name" order="ascending"/>
				<xsl:call-template name="ai-shop-categoryselectentry">
					<xsl:with-param name="selcatid">
						<xsl:value-of select="$selcatid"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</select>
	</xsl:template>
	
	<xsl:template name="ai-shop-categoryadd">
		<table bgcolor="white">
			<form action="?ACT=1&amp;SECT={$section}&amp;shop={$shop}&amp;type=shop&amp;id={$id}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="shop"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="bloc" value="shops/shop[id={$shop}]/categories"/>
						<input type="hidden" name="node" value="category"/>

						<table class="block">
							<tr>
								<td class="xp_sel">
									Name:
								</td>
								<td>
									<input type="text" name="name" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									Description:
								</td>
								<td>
									<textarea  class="textarea" name="description" title="Description"></textarea>
									<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('description');</script></xsl:if>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									Parent:
								</td>
								<td>
									<xsl:call-template name="ai-shop-categoryselect">
										<xsl:with-param name="inputname">
											parent
										</xsl:with-param>
										<xsl:with-param name="shopid">
											<xsl:value-of select="$id"/>
										</xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									visible:
								</td>
								<td>
									<select name="visible">
										<option value="off"><xsl:value-of select="$string[61]"/></option>
										<option value="on"><xsl:attribute name="selected">selected</xsl:attribute><xsl:value-of select="$string[60]"/></option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='?ACT=1&amp;SECT={$section}&amp;shop={$shop}&amp;type={$type}';"/>
								</td>
							</tr>
						</table>
						<br/>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>
	
	<xsl:template name="ai-shop-categoryupdate">
		<table bgcolor="white">
			<form action="?ACT=1&amp;SECT={$section}&amp;shop={$shop}&amp;type=shop" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="shop"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="shops/shop[id={$shop}]/categories/category[id={$id}]"/>

						<table class="block">
							<tr>
								<td class="xp_sel">
									Name:
								</td>
								<td>
									<input type="text" name="name" value="{name}" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									Description:
								</td>
								<td>
									<textarea  class="textarea" name="description" title="Description">
										<xsl:value-of select="description"/>
									</textarea>
									<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('description');</script></xsl:if>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									Parent:
								</td>
								<td>
									<xsl:call-template name="ai-shop-categoryselect">
										<xsl:with-param name="inputname">
											parent
										</xsl:with-param>
										<xsl:with-param name="shopid">
											<xsl:value-of select="$id"/>
										</xsl:with-param>
										<xsl:with-param name="selcatid">
											<xsl:value-of select="category"/>
										</xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									visible:
								</td>
								<td>
									<select name="visible">
										<option value="off">
											<xsl:if test="visible='off'">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="$string[61]"/>
										</option>
										<option value="on">
											<xsl:if test="visible='on'">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="$string[60]"/>
										</option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='?ACT=1&amp;SECT={$section}&amp;shop={$shop}&amp;type=shop';"/>
								</td>
							</tr>
						</table>
						<br/>
					</td>
				</tr>
			</form>
			<xsl:if test="$usertype='administrator'">
				<tr>
					<td>
						<form action="?ACT=1&amp;SECT={$section}&amp;shop={$shop}&amp;type=shop" method="post" onsubmit="return confirm('{$string[83]}');">
							<table class="block">
								<tr>
									<td bgcolor="white" align="right">
								    	<input type="hidden" name="file" value="shop"/>
										<input type="hidden" name="operation" value="delete"/>
										<input type="hidden" name="node" value="shop/shops[id={$shop}]/categories/category[id=$id]"/>
										<input type="submit" value="{$string[16]}"/>
									</td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</xsl:if>
		</table>
		<xsl:call-template name="ai-shop-productlist"/>
	</xsl:template>
	
	<xsl:template name="ai-shop-productadd">
		<table bgcolor="white">
			<form action="?ACT=1&amp;SECT={$section}&amp;shop={$shop}&amp;type=category&amp;id={$id}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="shop"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="bloc" value="shops/shop[id={$shop}]/products"/>
						<input type="hidden" name="node" value="product"/>

						<table class="block">
							<tr>
								<td class="xp_sel">
									Name:
								</td>
								<td>
									<input type="text" name="name" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									Description:
								</td>
								<td>
									<textarea  class="textarea" name="description" title="Description"></textarea>
									<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('description');</script></xsl:if>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									Price:
								</td>
								<td>
									<input type="text" name="price" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									Category:
								</td>
								<td>
									<xsl:call-template name="ai-shop-categoryselect">
										<xsl:with-param name="inputname">
											category
										</xsl:with-param>
										<xsl:with-param name="shopid">
											<xsl:value-of select="$shop"/>
										</xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									visible:
								</td>
								<td>
									<select name="visible">
										<option value="off"><xsl:value-of select="$string[61]"/></option>
										<option value="on"><xsl:attribute name="selected">selected</xsl:attribute><xsl:value-of select="$string[60]"/></option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='?ACT=1&amp;SECT={$section}&amp;shop={$shop}&amp;type={$type}';"/>
								</td>
							</tr>
						</table>
						<br/>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>
	
	<xsl:template name="ai-shop-productupdate">
		<table bgcolor="white">
			<form action="?ACT=1&amp;SECT={$section}&amp;shop={$shop}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="shop"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="npde" value="shops/shop[id={$shop}]/products/product[id=$id]"/>

						<table class="block">
							<tr>
								<td class="xp_sel">
									Name:
								</td>
								<td>
									<input type="text" name="name" value="{name}" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									Description:
								</td>
								<td>
									<textarea  class="textarea" name="description" title="Description">
										<xsl:value-of select="descritpion"/>
									</textarea>
									<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('description');</script></xsl:if>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									Price:
								</td>
								<td>
									<input type="text" name="price" value="{price}" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									Category:
								</td>
								<td>
									<xsl:call-template name="ai-shop-categoryselect">
										<xsl:with-param name="inputname">
											category
										</xsl:with-param>
										<xsl:with-param name="shopid">
											<xsl:value-of select="$shop"/>
										</xsl:with-param>
										<xsl:with-param name="selcatid">
											<xsl:value-of select="category"/>
										</xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									visible:
								</td>
								<td>
									<select name="visible">
										<option value="off">
											<xsl:if test="visible='off'">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="$string[61]"/>
										</option>
										<option value="on">
											<xsl:if test="visible='on'">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="$string[60]"/>
										</option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='?ACT=1&amp;SECT={$section}&amp;shop={$shop}&amp;type={$type}';"/>
								</td>
							</tr>
						</table>
						<br/>
					</td>
				</tr>
			</form>
			<xsl:if test="$usertype='administrator'">
				<tr>
					<td>
						<form action="?ACT=1&amp;SECT={$section}&amp;shop={$shop}&amp;type=shop" method="post" onsubmit="return confirm('{$string[83]}');">
							<table class="block">
								<tr>
									<td bgcolor="white" align="right">
								    	<input type="hidden" name="file" value="shop"/>
										<input type="hidden" name="operation" value="delete"/>
										<input type="hidden" name="node" value="shop/shops[id={$shop}]/products/product[id=$id]"/>
										<input type="submit" value="{$string[16]}"/>
									</td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>
	
</xsl:stylesheet>