# MySQL-Front Dump 2.4
#
# Host: localhost   Database: virtuastore
#--------------------------------------------------------
# Server version 3.23.55-max

USE virtuastore;


#
# Table structure for table 'acesso'
#

DROP TABLE IF EXISTS acesso;
CREATE TABLE `acesso` (
  `IDACESSO` int(10) unsigned NOT NULL auto_increment,
  `LOGIN` varchar(50) default NULL,
  `SENHA` varchar(50) default NULL,
  `QTDACESSO` int(11) default NULL,
  `ULTACESSO` varchar(50) default NULL,
  `EMAIL` varchar(50) default NULL,
  PRIMARY KEY  (`IDACESSO`)
) TYPE=MyISAM;



#
# Dumping data for table 'acesso'
#
INSERT INTO acesso (IDACESSO, LOGIN, SENHA, QTDACESSO, ULTACESSO, EMAIL) VALUES("2", "YWRtaW5pc3RyYWRvcg==", "MTIzNDU2", "5", "5/2/2004 21:00:22", "ZWxpemV1QG9uZGEuY29tLmJy");
INSERT INTO acesso (IDACESSO, LOGIN, SENHA, QTDACESSO, ULTACESSO, EMAIL) VALUES("3", "YWRtaW4=", "MTIzNDU2", "25", "8/3/2004 12:47:00", "ZWxpemV1QG9uZGEuY29tLmJy");
INSERT INTO acesso (IDACESSO, LOGIN, SENHA, QTDACESSO, ULTACESSO, EMAIL) VALUES("4", "ZWxpemV1YQ==", "MTIzNDU2Nzg=", "2", "1/3/2004 12:42:09", "ZWxpemV1QGNyaXN0YW9zaXRlLmNvbS5icg==");


#
# Table structure for table 'admin'
#

DROP TABLE IF EXISTS admin;
CREATE TABLE `admin` (
  `host` varchar(50) default NULL,
  `ip` varchar(50) default NULL,
  `data` varchar(50) default NULL,
  `hora` varchar(50) default NULL
) TYPE=MyISAM;



#
# Dumping data for table 'admin'
#
INSERT INTO admin (host, ip, data, hora) VALUES("192.168.0.2", "192.168.0.2", "12/11/2003", "19:07:03");
INSERT INTO admin (host, ip, data, hora) VALUES("192.168.0.2", "192.168.0.2", "13/11/2003", "12:25:47");
INSERT INTO admin (host, ip, data, hora) VALUES("192.168.0.2", "192.168.0.2", "17/11/2003", "09:30:45");
INSERT INTO admin (host, ip, data, hora) VALUES("192.168.42.223", "192.168.42.223", "16/12/2003", "13:11:47");
INSERT INTO admin (host, ip, data, hora) VALUES("192.168.42.223", "192.168.42.223", "16/12/2003", "13:36:01");
INSERT INTO admin (host, ip, data, hora) VALUES("192.168.42.223", "192.168.42.223", "16/12/2003", "14:41:21");
INSERT INTO admin (host, ip, data, hora) VALUES("192.168.42.223", "192.168.42.223", "16/12/2003", "15:30:03");
INSERT INTO admin (host, ip, data, hora) VALUES("192.168.42.223", "192.168.42.223", "29/12/2003", "15:26:55");
INSERT INTO admin (host, ip, data, hora) VALUES("192.168.42.223", "192.168.42.223", "29/12/2003", "16:03:10");


#
# Table structure for table 'boleto'
#

DROP TABLE IF EXISTS boleto;
CREATE TABLE `boleto` (
  `nosso` varchar(8) default NULL
) TYPE=MyISAM;



#
# Dumping data for table 'boleto'
#
INSERT INTO boleto (nosso) VALUES("30");


#
# Table structure for table 'browsers'
#

DROP TABLE IF EXISTS browsers;
CREATE TABLE `browsers` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `browser` varchar(50) default NULL,
  `acessos` int(11) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;



#
# Dumping data for table 'browsers'
#
INSERT INTO browsers (id, browser, acessos) VALUES("1", "MS Internet Explorer", "2177");
INSERT INTO browsers (id, browser, acessos) VALUES("2", "Netscape", "0");


#
# Table structure for table 'categoria'
#

DROP TABLE IF EXISTS categoria;
CREATE TABLE `categoria` (
  `idcategoria` int(10) unsigned NOT NULL auto_increment,
  `idsessao` int(11) default NULL,
  `data` varchar(50) default NULL,
  `nome` varchar(50) default NULL,
  `descr` varchar(255) default NULL,
  `ver` varchar(50) default NULL,
  PRIMARY KEY  (`idcategoria`)
) TYPE=MyISAM;



#
# Dumping data for table 'categoria'
#
INSERT INTO categoria (idcategoria, idsessao, data, nome, descr, ver) VALUES("3", "3", "12/07/2002", "Arcade", "-", "s");
INSERT INTO categoria (idcategoria, idsessao, data, nome, descr, ver) VALUES("5", "5", "12/07/2002", "Placas de Video", "-", "s");
INSERT INTO categoria (idcategoria, idsessao, data, nome, descr, ver) VALUES("6", "6", "12/07/2002", "Soluções", "-", "s");
INSERT INTO categoria (idcategoria, idsessao, data, nome, descr, ver) VALUES("8", "8", "12/07/2002", "LG", "-", "s");
INSERT INTO categoria (idcategoria, idsessao, data, nome, descr, ver) VALUES("10", "10", "12/07/2002", "Toshiba", "-", "s");
INSERT INTO categoria (idcategoria, idsessao, data, nome, descr, ver) VALUES("11", "11", "12/07/2002", "outros", "-", "n");
INSERT INTO categoria (idcategoria, idsessao, data, nome, descr, ver) VALUES("12", "9", "12/07/2002", "Sony", "-", "s");
INSERT INTO categoria (idcategoria, idsessao, data, nome, descr, ver) VALUES("13", "8", "15/01/2004", "Motorola", "-", "s");


#
# Table structure for table 'clientes'
#

DROP TABLE IF EXISTS clientes;
CREATE TABLE `clientes` (
  `clienteid` int(10) unsigned NOT NULL auto_increment,
  `datacad` varchar(50) default NULL,
  `nome` varchar(50) default NULL,
  `email` varchar(50) default NULL,
  `senha` varchar(50) default NULL,
  `cpf` varchar(50) default NULL,
  `rg` varchar(50) default NULL,
  `nascimento` varchar(50) default NULL,
  `endereco` varchar(100) default NULL,
  `bairro` varchar(50) default NULL,
  `cidade` varchar(50) default NULL,
  `cep` varchar(50) default NULL,
  `pais` varchar(50) default NULL,
  `tel` varchar(50) default NULL,
  `status` varchar(50) default NULL,
  `estado` varchar(50) default NULL,
  `contato` varchar(50) default NULL,
  PRIMARY KEY  (`clienteid`)
) TYPE=MyISAM;



#
# Dumping data for table 'clientes'
#
INSERT INTO clientes (clienteid, datacad, nome, email, senha, cpf, rg, nascimento, endereco, bairro, cidade, cep, pais, tel, status, estado, contato) VALUES("12", "1/1/2003", "T3ThdmlvIERpYXM=", "b3RhdmlvQHZpcnR1YXN0b3JlLmNvbS5icg==", "MTIzNDU2", "MDA2NDA1ODUwNjA=", "MDAwMDAwMDA=", "MTkvMDIvMTk4NA==", "UnVhIFRlc3RlLCA0NTU=", "Q2VudHJv", "Q2Fub2Fz", "OTIxMTAwMDA=", "QnJhc2ls", "NTE0NzU3NTQ1", "Ativo", "UlM=", "");
INSERT INTO clientes (clienteid, datacad, nome, email, senha, cpf, rg, nascimento, endereco, bairro, cidade, cep, pais, tel, status, estado, contato) VALUES("13", "16/1/2004", "RWxpemV1IEFsY2FudGFyYQ==", "ZWxpemV1QG9uZGEuY29tLmJy", "b3Nlb21w", "ODc0NDU3MDA5MDA=", "NjA5MjM5ODE=", "MDMvMDMvMTk3NA==", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "ODAxMjMwMDA=", "QnJhc2ls", "NDEzNDUzNDgw", "Ativo", "UFI=", "");


#
# Table structure for table 'compras'
#

DROP TABLE IF EXISTS compras;
CREATE TABLE `compras` (
  `pedido` int(10) unsigned NOT NULL auto_increment,
  `idcompra` int(11) default NULL,
  `datacompra` varchar(50) default NULL,
  `clienteid` varchar(50) default NULL,
  `frete` varchar(50) default NULL,
  `totalcompra` varchar(50) default NULL,
  `dataentrega` varchar(50) default NULL,
  `endentrega` varchar(255) default NULL,
  `bairroentrega` varchar(50) default NULL,
  `cidadeentrega` varchar(50) default NULL,
  `estadoentrega` varchar(50) default NULL,
  `cepentrega` varchar(50) default NULL,
  `paisentrega` varchar(50) default NULL,
  `telentrega` varchar(50) default NULL,
  `pagamentovia` varchar(50) default NULL,
  `status` varchar(50) default NULL,
  `presente` varchar(50) default NULL,
  `msgpresente` varchar(255) default NULL,
  `numero` varchar(50) default NULL,
  `codigo_seguranca` varchar(10) default NULL,
  `vencimento` varchar(50) default NULL,
  `titular` varchar(50) default NULL,
  PRIMARY KEY  (`pedido`)
) TYPE=MyISAM;



#
# Dumping data for table 'compras'
#
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("277", "24", "16/01/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "NDUsMjk=", "MS43NDksMDA=", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAzMzAxODA=", "Brasil", "NDEzNDUzNDgw", "7", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("282", "29", "13/01/2004", "b3RhdmlvQHZpcnR1YXN0b3JlLmNvbS5icg==", "NzYsNzg=", "My40OTgsMDA=", "", "UnVhIFRlc3RlLCA0NTU=", "Q2VudHJv", "Q2Fub2Fz", "RS", "MDEyNjU1MDA=", "Brasil", "NTE0NzU3NTQ1", "6", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("333", "30", "26/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("334", "31", "27/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("335", "32", "27/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("336", "33", "27/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("337", "34", "27/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("338", "35", "27/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("339", "36", "28/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("340", "37", "28/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("341", "38", "28/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("342", "39", "28/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("343", "40", "28/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("344", "41", "28/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("345", "42", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("346", "43", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("347", "44", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("348", "45", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("349", "46", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("350", "47", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("351", "48", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("352", "49", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("353", "50", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("354", "51", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("355", "52", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("356", "53", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("357", "54", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("358", "55", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("359", "56", "29/01/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MzIsMzA=", "Mi4wMDAsMDA=", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAzMzAxODA=", "Brasil", "NDEzNDUzNDgw", "7", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("360", "57", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("361", "58", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("362", "59", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("363", "60", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("364", "61", "29/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("365", "62", "30/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("366", "63", "30/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("367", "64", "30/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("368", "65", "30/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("369", "66", "30/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("370", "67", "30/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("371", "68", "30/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("372", "69", "30/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("373", "70", "30/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("374", "71", "30/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("375", "72", "30/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("376", "73", "30/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("377", "74", "31/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("378", "75", "31/1/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("379", "76", "2/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("380", "77", "2/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("381", "78", "2/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("382", "79", "2/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("383", "80", "2/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("384", "81", "2/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("385", "82", "2/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("386", "83", "2/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("387", "84", "2/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("388", "85", "2/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("389", "86", "2/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("390", "87", "3/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("391", "88", "3/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("392", "89", "3/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("393", "90", "3/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("394", "91", "3/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("395", "92", "3/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("396", "93", "3/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("397", "94", "3/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("398", "95", "3/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("399", "96", "3/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("400", "97", "3/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("401", "98", "4/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("402", "99", "4/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("403", "100", "4/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("404", "101", "4/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("405", "102", "4/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("406", "103", "4/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("407", "104", "5/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("408", "105", "5/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("409", "106", "5/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("410", "107", "5/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("411", "108", "5/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("412", "109", "5/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("413", "110", "5/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("414", "111", "5/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("415", "112", "5/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("416", "113", "5/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("417", "114", "5/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("418", "115", "5/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("419", "116", "5/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("420", "117", "6/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("421", "118", "6/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("422", "119", "6/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("423", "120", "6/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("424", "121", "6/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("425", "122", "6/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("426", "123", "7/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("427", "124", "7/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("428", "125", "7/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("429", "126", "7/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("430", "127", "7/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("431", "128", "7/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("432", "129", "7/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("433", "130", "7/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("434", "131", "7/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("435", "132", "7/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("436", "133", "7/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("437", "134", "7/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("438", "135", "7/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("439", "136", "7/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("440", "137", "8/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("441", "138", "8/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("442", "139", "8/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("443", "140", "8/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("444", "141", "8/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("445", "142", "8/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("446", "143", "9/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("447", "144", "9/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("448", "145", "9/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("449", "146", "9/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("450", "147", "9/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("451", "148", "9/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("452", "149", "9/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("453", "150", "9/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("454", "151", "9/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("455", "152", "9/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("456", "153", "10/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("457", "154", "10/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("458", "155", "10/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("459", "156", "10/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("460", "157", "10/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("461", "158", "10/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("462", "159", "10/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("463", "160", "10/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("464", "161", "10/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("465", "162", "10/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("466", "163", "10/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("467", "164", "10/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("468", "165", "11/02/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MTksODA=", "MzAwLDAw", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "MDEwMjAwMzA=", "Brasil", "NDEzNDUzNDgw", "7", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("469", "166", "11/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("470", "167", "11/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("471", "168", "11/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("472", "169", "11/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("473", "170", "11/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("474", "171", "11/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("475", "172", "11/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("476", "173", "11/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("477", "174", "11/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("478", "175", "11/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("479", "176", "11/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("480", "177", "12/02/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MzYsODA=", "Mi4wMDAsMDA=", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "MDEwMjAwMzA=", "Brasil", "NDEzNDUzNDgw", "7", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("481", "178", "12/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("482", "179", "12/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("483", "180", "12/02/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MzYsODA=", "Mi4wMDAsMDA=", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "MDEwMjAwMzA=", "Brasil", "NDEzNDUzNDgw", "7", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("484", "181", "12/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("485", "182", "12/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("486", "183", "12/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("487", "184", "12/02/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MzIsMzA=", "Mi4wMDAsMDA=", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "", "Compra em Aberto", "Não", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("488", "185", "12/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("489", "186", "12/02/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MzEsODA=", "MS45NTAsMDA=", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "6", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("490", "187", "12/02/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "NjIsNzk=", "NC42OTksMDA=", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "5", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("491", "188", "12/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("492", "189", "12/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("493", "190", "12/02/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MTUsODc=", "MzU3LDAw", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "5", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("494", "191", "12/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("495", "192", "12/02/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MjAsODk=", "ODU5LDAw", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "5", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("496", "193", "12/02/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MTUsODc=", "MzU3LDAw", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "5", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("497", "194", "12/02/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MTUsODc=", "MzU3LDAw", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "5", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("498", "195", "12/02/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MjMsMDE=", "MS4wNzEsMDA=", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "5", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("499", "196", "12/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("500", "197", "12/02/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MTA4LDIw", "OS4yNDgsMDA=", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "5", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("501", "198", "12/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("502", "199", "12/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("503", "200", "12/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("504", "201", "12/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("505", "202", "12/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("506", "203", "12/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("507", "204", "13/02/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MjQxLDQw", "MjIuMTExLDAw", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "5", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("508", "205", "13/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("509", "206", "13/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("510", "207", "13/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("511", "208", "13/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("512", "209", "13/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("513", "210", "13/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("514", "211", "13/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("515", "212", "13/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("516", "213", "13/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("517", "214", "13/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("518", "215", "13/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("519", "216", "14/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("520", "217", "14/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("521", "218", "14/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("522", "219", "14/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("523", "220", "14/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("524", "221", "15/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("525", "222", "16/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("526", "223", "16/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("527", "224", "16/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("528", "225", "16/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("529", "226", "16/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("530", "227", "16/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("531", "228", "16/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("532", "229", "16/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("533", "230", "16/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("534", "231", "17/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("535", "232", "17/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("536", "233", "17/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("537", "234", "17/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("538", "235", "17/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("539", "236", "17/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("540", "237", "17/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("541", "238", "17/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("542", "239", "17/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("543", "240", "17/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("544", "241", "17/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("545", "242", "17/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("546", "243", "17/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("547", "244", "18/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("548", "245", "18/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("549", "246", "18/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("550", "247", "18/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("551", "248", "18/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("552", "249", "19/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("553", "250", "19/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("554", "251", "19/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("555", "252", "19/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("556", "253", "19/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("557", "254", "20/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("558", "255", "20/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("559", "256", "20/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("560", "257", "20/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("561", "258", "20/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("562", "259", "20/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("563", "260", "20/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("564", "261", "21/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("565", "262", "25/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("566", "263", "25/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("567", "264", "25/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("568", "265", "25/02/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MzAsNzk=", "MS43NDksMDA=", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "5", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("569", "266", "25/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("570", "267", "25/02/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MzAsNzk=", "MS43NDksMDA=", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "5", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("571", "268", "25/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("572", "269", "25/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("573", "270", "25/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("574", "271", "25/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("575", "272", "25/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("576", "273", "26/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("577", "274", "26/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("578", "275", "26/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("579", "276", "26/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("580", "277", "26/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("581", "278", "26/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("582", "279", "26/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("583", "280", "26/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("584", "281", "26/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("585", "282", "27/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("586", "283", "27/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("587", "284", "27/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("588", "285", "27/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("589", "286", "27/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("590", "287", "28/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("591", "288", "28/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("592", "289", "28/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("593", "290", "28/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("594", "291", "28/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("595", "292", "28/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("596", "293", "28/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("597", "294", "28/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("598", "295", "28/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("599", "296", "28/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("600", "297", "29/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("601", "298", "29/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("602", "299", "29/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("603", "300", "29/2/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("604", "301", "1/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("605", "302", "1/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("606", "303", "1/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("607", "304", "1/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("608", "305", "1/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("609", "306", "1/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("610", "307", "1/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("611", "308", "1/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("612", "309", "1/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("613", "310", "1/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("614", "311", "1/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("615", "312", "1/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("616", "313", "1/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("617", "314", "1/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("618", "315", "1/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("619", "316", "1/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("620", "317", "2/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("621", "318", "2/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("622", "319", "2/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("623", "320", "2/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("624", "321", "2/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("625", "322", "2/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("626", "323", "2/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("627", "324", "2/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("628", "325", "2/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("629", "326", "3/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("630", "327", "3/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("631", "328", "3/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("632", "329", "3/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("633", "330", "3/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("634", "331", "3/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("635", "332", "3/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("636", "333", "3/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("637", "334", "3/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("638", "335", "3/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("639", "336", "3/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("640", "337", "4/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("641", "338", "4/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("642", "339", "4/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("643", "340", "4/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("644", "341", "4/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("645", "342", "4/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("646", "343", "4/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("647", "344", "4/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("648", "345", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("649", "346", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("650", "347", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("651", "348", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("652", "349", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("653", "350", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("654", "351", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("655", "352", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("656", "353", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("657", "354", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("658", "355", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("659", "356", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("660", "357", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("661", "358", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("662", "359", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("663", "360", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("664", "361", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("665", "362", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("666", "363", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("667", "364", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("668", "365", "5/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("669", "366", "06/03/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MzAsNzk=", "MS43NDksMDA=", "", "UiBKb3NlIERpZWRzaXRzY2ggNDE=", "RmF6ZW5kaW5oYQ==", "Y3VyaXRpYmE=", "BA", "ODAxMjMwMDA=", "Brasil", "MzQ1MzQ4MA==", "5", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("670", "367", "6/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("671", "368", "06/03/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MTUsMzA=", "MzAwLDAw", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDEx", "Q3Jpc3RvIFJlaQ==", "c2FvIGpva2U=", "RN", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "5", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("672", "369", "06/03/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MzAsNzk=", "MS43NDksMDA=", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "0", "0", "Não", "", "", "", "MDQvMjAwNQ==", "ZWxpemV5IGZhZmFzZmRzZA==");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("673", "370", "06/03/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "NTgsNzk=", "NC4zOTksMDA=", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "0", "0", "Não", "", "", "", "MDIvMjAwNw==", "ZWxpemV5IGZhZmFzZmRzZA==");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("674", "371", "06/03/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MzIsMzA=", "Mi4wMDAsMDA=", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAzMzAxODA=", "Brasil", "NDEzNDUzNDgw", "0", "0", "Não", "", "", "MTIzNA==", "MDMvMjAwOQ==", "ZWxpemV5IGZhZmFzZmRzZA==");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("675", "372", "6/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("676", "373", "6/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("677", "374", "6/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("678", "375", "6/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("679", "376", "6/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("680", "377", "8/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("681", "378", "08/03/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MzAsNzk=", "MS43NDksMDA=", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "5", "0", "Sim", "Parabéns!", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("682", "379", "8/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("683", "380", "8/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("684", "381", "8/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("685", "382", "8/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("686", "383", "8/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("687", "384", "8/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("688", "385", "8/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("689", "386", "08/03/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MTAsMDA=", "MS43NDksMDA=", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "7", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("690", "387", "08/03/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MTAsMDA=", "ODU5LDAw", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "5", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("691", "388", "08/03/2004", "ZWxpemV1QG9uZGEuY29tLmJy", "MTAsMDA=", "ODU5LDAw", "", "UHJlZi4gQW5nZWxvIExvcGVzLCAxNDAgLSBBcHRvIDA5", "Q3Jpc3RvIFJlaQ==", "Y3VyaXRpYmE=", "PR", "ODAxMjMwMDA=", "Brasil", "NDEzNDUzNDgw", "4", "0", "Não", "", "", "", "Lw==", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("692", "389", "8/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("693", "390", "8/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("694", "391", "8/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("695", "392", "8/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("696", "393", "8/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("697", "394", "8/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("698", "395", "8/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("699", "396", "8/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("700", "397", "9/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("701", "398", "9/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("702", "399", "9/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("703", "400", "9/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("704", "401", "9/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("705", "402", "9/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("706", "403", "9/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("707", "404", "9/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("708", "405", "9/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("709", "406", "9/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("710", "407", "9/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");
INSERT INTO compras (pedido, idcompra, datacompra, clienteid, frete, totalcompra, dataentrega, endentrega, bairroentrega, cidadeentrega, estadoentrega, cepentrega, paisentrega, telentrega, pagamentovia, status, presente, msgpresente, numero, codigo_seguranca, vencimento, titular) VALUES("711", "408", "11/3/2004", "", "", "", "", "", "", "", "", "", "", "", "", "Compra em Aberto", "", "", "", "", "", "");


#
# Table structure for table 'email'
#

DROP TABLE IF EXISTS email;
CREATE TABLE `email` (
  `email` varchar(50) default NULL
) TYPE=MyISAM;



#
# Dumping data for table 'email'
#


#
# Table structure for table 'estoque'
#

DROP TABLE IF EXISTS estoque;
CREATE TABLE `estoque` (
  `IDESTOQUE` int(10) unsigned NOT NULL auto_increment,
  `IDPRODUTO` int(11) default NULL,
  `QTDMAXIMA` int(11) default NULL,
  `ESTOQUE` int(11) default NULL,
  PRIMARY KEY  (`IDESTOQUE`)
) TYPE=MyISAM;



#
# Dumping data for table 'estoque'
#
INSERT INTO estoque (IDESTOQUE, IDPRODUTO, QTDMAXIMA, ESTOQUE) VALUES("1", "56", "5", "4");
INSERT INTO estoque (IDESTOQUE, IDPRODUTO, QTDMAXIMA, ESTOQUE) VALUES("2", "57", "2", "9");
INSERT INTO estoque (IDESTOQUE, IDPRODUTO, QTDMAXIMA, ESTOQUE) VALUES("3", "58", "1", "3");
INSERT INTO estoque (IDESTOQUE, IDPRODUTO, QTDMAXIMA, ESTOQUE) VALUES("4", "59", "2", "15");
INSERT INTO estoque (IDESTOQUE, IDPRODUTO, QTDMAXIMA, ESTOQUE) VALUES("5", "62", "1", "10");
INSERT INTO estoque (IDESTOQUE, IDPRODUTO, QTDMAXIMA, ESTOQUE) VALUES("6", "63", "1", "8");
INSERT INTO estoque (IDESTOQUE, IDPRODUTO, QTDMAXIMA, ESTOQUE) VALUES("7", "64", "1", "7");
INSERT INTO estoque (IDESTOQUE, IDPRODUTO, QTDMAXIMA, ESTOQUE) VALUES("8", "66", "1", "7");
INSERT INTO estoque (IDESTOQUE, IDPRODUTO, QTDMAXIMA, ESTOQUE) VALUES("9", "65", "2", "17");


#
# Table structure for table 'horas'
#

DROP TABLE IF EXISTS horas;
CREATE TABLE `horas` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `hora` varchar(50) default NULL,
  `acessos` int(11) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;



#
# Dumping data for table 'horas'
#
INSERT INTO horas (id, hora, acessos) VALUES("1", "01", "0");
INSERT INTO horas (id, hora, acessos) VALUES("2", "02", "0");
INSERT INTO horas (id, hora, acessos) VALUES("3", "03", "0");
INSERT INTO horas (id, hora, acessos) VALUES("4", "04", "0");
INSERT INTO horas (id, hora, acessos) VALUES("5", "05", "0");
INSERT INTO horas (id, hora, acessos) VALUES("6", "06", "0");
INSERT INTO horas (id, hora, acessos) VALUES("7", "07", "0");
INSERT INTO horas (id, hora, acessos) VALUES("8", "08", "0");
INSERT INTO horas (id, hora, acessos) VALUES("9", "09", "0");
INSERT INTO horas (id, hora, acessos) VALUES("10", "10", "89");
INSERT INTO horas (id, hora, acessos) VALUES("11", "11", "108");
INSERT INTO horas (id, hora, acessos) VALUES("12", "12", "173");
INSERT INTO horas (id, hora, acessos) VALUES("13", "13", "149");
INSERT INTO horas (id, hora, acessos) VALUES("14", "14", "38");
INSERT INTO horas (id, hora, acessos) VALUES("15", "15", "81");
INSERT INTO horas (id, hora, acessos) VALUES("16", "16", "100");
INSERT INTO horas (id, hora, acessos) VALUES("17", "17", "80");
INSERT INTO horas (id, hora, acessos) VALUES("18", "18", "82");
INSERT INTO horas (id, hora, acessos) VALUES("19", "19", "88");
INSERT INTO horas (id, hora, acessos) VALUES("20", "20", "127");
INSERT INTO horas (id, hora, acessos) VALUES("21", "21", "52");
INSERT INTO horas (id, hora, acessos) VALUES("22", "22", "62");
INSERT INTO horas (id, hora, acessos) VALUES("23", "23", "121");
INSERT INTO horas (id, hora, acessos) VALUES("24", "24", "0");


#
# Table structure for table 'hosts'
#

DROP TABLE IF EXISTS hosts;
CREATE TABLE `hosts` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `host` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;



#
# Dumping data for table 'hosts'
#
INSERT INTO hosts (id, host) VALUES("570", "127.0.0.1");
INSERT INTO hosts (id, host) VALUES("2746", "127.0.0.1");


#
# Table structure for table 'meses'
#

DROP TABLE IF EXISTS meses;
CREATE TABLE `meses` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `mes` varchar(50) default NULL,
  `acessos` int(11) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;



#
# Dumping data for table 'meses'
#
INSERT INTO meses (id, mes, acessos) VALUES("1", "1", "723");
INSERT INTO meses (id, mes, acessos) VALUES("2", "2", "960");
INSERT INTO meses (id, mes, acessos) VALUES("3", "3", "494");
INSERT INTO meses (id, mes, acessos) VALUES("4", "4", "0");
INSERT INTO meses (id, mes, acessos) VALUES("5", "5", "0");
INSERT INTO meses (id, mes, acessos) VALUES("6", "6", "0");
INSERT INTO meses (id, mes, acessos) VALUES("7", "7", "0");
INSERT INTO meses (id, mes, acessos) VALUES("8", "8", "0");
INSERT INTO meses (id, mes, acessos) VALUES("9", "9", "0");
INSERT INTO meses (id, mes, acessos) VALUES("10", "10", "0");
INSERT INTO meses (id, mes, acessos) VALUES("11", "11", "0");
INSERT INTO meses (id, mes, acessos) VALUES("12", "12", "0");


#
# Table structure for table 'newsletter'
#

DROP TABLE IF EXISTS newsletter;
CREATE TABLE `newsletter` (
  `datacad` varchar(50) default NULL,
  `email` varchar(50) default NULL
) TYPE=MyISAM;



#
# Dumping data for table 'newsletter'
#
INSERT INTO newsletter (datacad, email) VALUES("08/01/2004", "x@x.com.br");


#
# Table structure for table 'pedidos'
#

DROP TABLE IF EXISTS pedidos;
CREATE TABLE `pedidos` (
  `idcompra` varchar(50) default NULL,
  `idprod` varchar(50) default NULL,
  `quantidade` varchar(50) default NULL
) TYPE=MyISAM;



#
# Dumping data for table 'pedidos'
#
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("1", "58", "3");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("12", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("15", "56", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("22", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("29", "57", "2");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("24", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("60", "56", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("65", "56", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("65", "64", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("65", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("79", "56", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("56", "58", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("62", "56", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("62", "64", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("64", "64", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("68", "56", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("71", "59", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("73", "56", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("115", "56", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("123", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("143", "56", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("143", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("143", "59", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("143", "58", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("143", "62", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("143", "63", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("163", "56", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("163", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("165", "59", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("169", "56", "90");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("169", "57", "16");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("177", "58", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("180", "58", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("182", "58", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("183", "58", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("184", "58", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("185", "59", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("186", "63", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("187", "59", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("187", "66", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("190", "56", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("192", "64", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("193", "56", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("194", "56", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("195", "56", "3");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("197", "65", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("197", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("204", "56", "2");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("204", "66", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("204", "65", "2");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("204", "58", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("236", "56", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("265", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("267", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("287", "66", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("288", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("292", "64", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("296", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("299", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("299", "58", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("299", "59", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("299", "62", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("299", "63", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("303", "66", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("312", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("334", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("334", "65", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("334", "58", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("366", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("368", "59", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("369", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("370", "66", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("371", "58", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("372", "59", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("378", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("380", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("386", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("387", "64", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("388", "64", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("389", "62", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("406", "65", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("406", "64", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("406", "57", "1");
INSERT INTO pedidos (idcompra, idprod, quantidade) VALUES("407", "66", "1");


#
# Table structure for table 'produtos'
#

DROP TABLE IF EXISTS produtos;
CREATE TABLE `produtos` (
  `idprod` int(10) unsigned NOT NULL auto_increment,
  `nome` text,
  `fabricante` varchar(50) default NULL,
  `detalhe` text,
  `preco` varchar(50) default NULL,
  `precovelho` varchar(50) default NULL,
  `parcela` varchar(50) default NULL,
  `juro` varchar(50) default NULL,
  `aomes` varchar(50) default NULL,
  `estoque` varchar(50) default NULL,
  `idsessao` varchar(50) default NULL,
  `data` varchar(50) default NULL,
  `peso` varchar(50) default NULL,
  `imgra` varchar(50) default NULL,
  `impeq` varchar(50) default NULL,
  `status` varchar(50) default NULL,
  `contador` int(11) default NULL,
  `vendas` int(11) default NULL,
  `destaque` varchar(50) default NULL,
  PRIMARY KEY  (`idprod`)
) TYPE=MyISAM;



#
# Dumping data for table 'produtos'
#
INSERT INTO produtos (idprod, nome, fabricante, detalhe, preco, precovelho, parcela, juro, aomes, estoque, idsessao, data, peso, imgra, impeq, status, contador, vendas, destaque) VALUES("56", "Impressora Jato de Tinta DJ 3420", "HP", "A impressora jato de tinta em cores HP Deskjet 342. Considerada uma das mais econômicas do mercado e recomendado pela Revista Info", "357", "480", "v", "0", "mes", "n", "11", "12/12/2002", "0,25", "g_imp_dj3420.jpg", "p_imp_dj3420.gif", "nao", "57", "0", "s");
INSERT INTO produtos (idprod, nome, fabricante, detalhe, preco, precovelho, parcela, juro, aomes, estoque, idsessao, data, peso, imgra, impeq, status, contador, vendas, destaque) VALUES("57", "iPAQ Pocket PC H3760", "Compaq", "Mantenha-se conectado ao que é mais importante para os seus negócios.", "1749", "1749", "v", "0", "mes", "s", "6", "12/12/2002", "2", "g_ipaq.jpg", "p_ipaq.gif", "nao", "51", "0", "s");
INSERT INTO produtos (idprod, nome, fabricante, detalhe, preco, precovelho, parcela, juro, aomes, estoque, idsessao, data, peso, imgra, impeq, status, contador, vendas, destaque) VALUES("58", "Microcomputador Presario 7EL193 Pentium III 933 MHz", "Compaq", "Os novos modelos em minitorres possibilitam uma ótima harmonia com o seu escritório ou em sua casa.", "2000", "2000", "v", "0", "mes", "s", "11", "12/12/2002", "0,750", "g_micro_presario.jpg", "p_micro_presario.gif", "nao", "38", "0", "s");
INSERT INTO produtos (idprod, nome, fabricante, detalhe, preco, precovelho, parcela, juro, aomes, estoque, idsessao, data, peso, imgra, impeq, status, contador, vendas, destaque) VALUES("59", "Windows XP Professional", "", "", "300", "300", "v", "0", "mes", "s", "6", "12/12/2002", "1", "g_windows_xp.jpg", "p_windows_xp.gif", "nao", "20", "0", "s");
INSERT INTO produtos (idprod, nome, fabricante, detalhe, preco, precovelho, parcela, juro, aomes, estoque, idsessao, data, peso, imgra, impeq, status, contador, vendas, destaque) VALUES("62", "Placa Aceleradora Gr&#225;fica de V&#237;deo GeForce2 MX200", "PixelView", "Obtenha uma performance, velocidade e qualidade numa placa com os melhores recursos do mercado 3D", "285,00", "350,00", "v", "0", "mes", "s", "5", "15/01/2004", "0,1", "g_PixelView.jpg", "p_PixelView.gif", "nao", "7", "0", "s");
INSERT INTO produtos (idprod, nome, fabricante, detalhe, preco, precovelho, parcela, juro, aomes, estoque, idsessao, data, peso, imgra, impeq, status, contador, vendas, destaque) VALUES("63", "PlayStation 2", "Sony", "O melhor console do ano. Tenha em mãos os melhores jogos do momento!", "1950,00", "1980,86", "v", "0", "mes", "s", "3", "15/01/2004", "1", "g_play.gif", "p_play.gif", "nao", "5", "0", "s");
INSERT INTO produtos (idprod, nome, fabricante, detalhe, preco, precovelho, parcela, juro, aomes, estoque, idsessao, data, peso, imgra, impeq, status, contador, vendas, destaque) VALUES("64", "Motorola - Hello Moto", "Motorola", "Tenha o celular com o melhor custo-benefício do mercado e receba R$ 200,00 de crédito para conversar com os seus amigos. Lançamento mundial.", "859,00", "900,00", "v", "0", "mes", "s", "8", "15/01/2004", "0,250", "g_Motorola.gif", "p_motorola.gif", "nao", "8", "0", "s");
INSERT INTO produtos (idprod, nome, fabricante, detalhe, preco, precovelho, parcela, juro, aomes, estoque, idsessao, data, peso, imgra, impeq, status, contador, vendas, destaque) VALUES("65", "Notebook Evo N160 W2000 Pentium III 1,2 GHz", "Compaq", "Um notebook poderoso, leve, delgado e com um preço promocional com garantia de 3 anos", "7499", "8000", "v", "0", "mês", "s", "11", "15/01/2004", "2,5", "g_nb_evo.jpg", "p_nb_evo.gif", "ok", "5", "0", "s");
INSERT INTO produtos (idprod, nome, fabricante, detalhe, preco, precovelho, parcela, juro, aomes, estoque, idsessao, data, peso, imgra, impeq, status, contador, vendas, destaque) VALUES("66", "Microcomputador OZ 10D - Pentium 4", "Gradiente", "Agora você poderá navegar na Internet, assistir TV sem você sair do seu micro. Tudo isso ao memso tempo e com outras vantagens que só esse modelo Oz da Gradiente pode oferecer.", "4399", "4690", "v", "0", "mês", "s", "11", "15/01/2004", "3,5", "g_micro_oz.jpg", "p_micro_oz.gif", "ok", "6", "0", "s");


#
# Table structure for table 'referencias'
#

DROP TABLE IF EXISTS referencias;
CREATE TABLE `referencias` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `referencia` text,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;



#
# Dumping data for table 'referencias'
#
INSERT INTO referencias (id, referencia) VALUES("568", "http://localhost/testes/comunidade/VSOpen_Grupo/sessoes.asp?item=6&Categoria=6");
INSERT INTO referencias (id, referencia) VALUES("569", "http://localhost/testes/comunidade/VSOpen_Grupo/administrador.asp?link=util&acao=sql&erro=Command%20text%20was%20not%20set%20for%20the%20command%20object.");
INSERT INTO referencias (id, referencia) VALUES("570", "http://localhost/testes/comunidade/VSOpen_Grupo/default.asp");
INSERT INTO referencias (id, referencia) VALUES("571", "http://localhost/testes/comunidade/VSOpen_Grupo/produtos.asp?produto=");
INSERT INTO referencias (id, referencia) VALUES("2719", "http://localhost/Biz/LojaVirtuaStoreOpen30/");
INSERT INTO referencias (id, referencia) VALUES("2720", "http://localhost/Biz/LojaVirtuaStoreOpen30/?Lan=Espanol");
INSERT INTO referencias (id, referencia) VALUES("2721", "http://localhost/Biz/LojaVirtuaStoreOpen30/?Lan=Espanol");
INSERT INTO referencias (id, referencia) VALUES("2722", "http://localhost/Biz/LojaVirtuaStoreOpen30/?Lan=English");
INSERT INTO referencias (id, referencia) VALUES("2723", "");


#
# Table structure for table 'semana'
#

DROP TABLE IF EXISTS semana;
CREATE TABLE `semana` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `dia_semana` varchar(50) default NULL,
  `acessos` int(11) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;



#
# Dumping data for table 'semana'
#
INSERT INTO semana (id, dia_semana, acessos) VALUES("1", "1", "64");
INSERT INTO semana (id, dia_semana, acessos) VALUES("2", "2", "422");
INSERT INTO semana (id, dia_semana, acessos) VALUES("3", "3", "224");
INSERT INTO semana (id, dia_semana, acessos) VALUES("4", "4", "184");
INSERT INTO semana (id, dia_semana, acessos) VALUES("5", "5", "397");
INSERT INTO semana (id, dia_semana, acessos) VALUES("6", "6", "364");
INSERT INTO semana (id, dia_semana, acessos) VALUES("7", "7", "522");


#
# Table structure for table 'sessoes'
#

DROP TABLE IF EXISTS sessoes;
CREATE TABLE `sessoes` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `data` varchar(50) default NULL,
  `nome` varchar(50) default NULL,
  `descr` varchar(255) default NULL,
  `ver` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;



#
# Dumping data for table 'sessoes'
#
INSERT INTO sessoes (id, data, nome, descr, ver) VALUES("3", "12/07/2002", "Games", "-", "s");
INSERT INTO sessoes (id, data, nome, descr, ver) VALUES("5", "12/07/2002", "Hardware", "-", "s");
INSERT INTO sessoes (id, data, nome, descr, ver) VALUES("6", "12/07/2002", "Internet", "-", "s");
INSERT INTO sessoes (id, data, nome, descr, ver) VALUES("8", "12/07/2002", "Celulares", "-", "s");
INSERT INTO sessoes (id, data, nome, descr, ver) VALUES("9", "12/07/2002", "Palmtops", "-", "s");
INSERT INTO sessoes (id, data, nome, descr, ver) VALUES("10", "12/07/2002", "Notebooks", "-", "s");
INSERT INTO sessoes (id, data, nome, descr, ver) VALUES("11", "12/07/2002", "Diversos", "-", "s");
