//Data:         13/02/2009
//Autor:        Fabrizio Gianfratti Manes
//Descrição:    Classe de acesso a Dados
//Atualização:
using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Sql;
using System.Data.Common;
using BE;

namespace DAL
{
    public class ArquivoDAL
    {
        /// <summary>
        /// Innclui um novo registro
        /// </summary>
        /// <param name="usuarioBE"></param>
        public void Incluir(ArquivoBE arquivoBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("INSERT INTO Arquivo (idUsuario,idTipoMidia,idTipoArquivo,idTipoQualidade,idStatus,Codigo,TamanhoArquivo,Titulo,Original,Descricao,TituloOriginal,AnoLancamento,Legenda,Idioma,PaisOrigem,TAGS,ImgCapa,Localizacao,Qtd,Deletado) VALUES (" + arquivoBE.IdUsuario + "," + arquivoBE.idTipoMidia + "," + arquivoBE.idTipoArquivo + "," + arquivoBE.idTipoQualidade + "," + arquivoBE.idStatus + "," + arquivoBE.Codigo + "," + arquivoBE.TamanhoArquivo + "," + arquivoBE.Titulo + "," + arquivoBE.Original + "," + arquivoBE.Descricao + "," + arquivoBE.TituloOriginal + "," + arquivoBE.AnoLancamento + "," + arquivoBE.Legenda + "," + arquivoBE.Idioma + "," + arquivoBE.PaisOrigem + "," + arquivoBE.Tags + "," + arquivoBE.ImgCapa + "," + arquivoBE.Localizacao + "," + arquivoBE.Qtd + "," + arquivoBE.Deletado + ")");
            db.ExecuteNonQuery(command);
        }

        /// <summary>
        /// Retorna uma lista de registro
        /// </summary>
        /// <returns></returns>
        public List<ArquivoBE> Listar()
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT * FROM Arquivo");
            List<ArquivoBE> Lista = new List<ArquivoBE>();
            using (IDataReader dr = db.ExecuteReader(command))
            {
                while (dr.Read())
                {
                    ArquivoBE arquivoBE = new ArquivoBE();
                    arquivoBE.ID = Convert.ToInt32(dr["ID"]);
                    arquivoBE.IdUsuario = Convert.ToInt32(dr["idUsuario"]);
                    arquivoBE.idTipoMidia = Convert.ToInt32(dr["idTipoMidia"]);
                    arquivoBE.idTipoArquivo = Convert.ToInt32(dr["idTipoArquivo"]);
                    arquivoBE.idTipoQualidade = Convert.ToInt32(dr["idTipoQualidade"]);
                    arquivoBE.idStatus = Convert.ToInt32(dr["idStatus"]);
                    arquivoBE.Codigo = Convert.ToString(dr["Codigo"]);
                    arquivoBE.TamanhoArquivo = Convert.ToString(dr["TamanhoArquivo"]);
                    arquivoBE.Titulo = Convert.ToString(dr["Titulo"]);
                    arquivoBE.Original = Convert.ToString(dr["Original"]);
                    arquivoBE.Descricao = Convert.ToString(dr["Descricao"]);
                    arquivoBE.TituloOriginal = Convert.ToString(dr["TituloOriginal"]);
                    arquivoBE.AnoLancamento = Convert.ToString(dr["AnoLancamento"]);
                    arquivoBE.Legenda = Convert.ToString(dr["Legenda"]);
                    arquivoBE.Idioma = Convert.ToString(dr["Idioma"]);
                    arquivoBE.PaisOrigem = Convert.ToString(dr["PaisOrigem"]);
                    arquivoBE.Tags = Convert.ToString(dr["TAGS"]);
                    arquivoBE.ImgCapa = Convert.ToString(dr["ImgCapa"]);
                    arquivoBE.Localizacao = Convert.ToString(dr["Localizacao"]);
                    arquivoBE.Qtd = Convert.ToString(dr["Qtd"]);
                    arquivoBE.Deletado = Convert.ToBoolean(dr["Deletado"]);
                    Lista.Add(arquivoBE);
                }
            }
            return Lista;
        }

        /// <summary>
        /// Altera o cadastro
        /// </summary>
        /// <param name="usuarioBE"></param>
        public void Alterar(ArquivoBE arquivoBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("UPDATE Arquivo SET idUsuario = " + arquivoBE.IdUsuario + ",idTipoMidia = " + arquivoBE.idTipoMidia + ",idTipoArquivo = " + arquivoBE.idTipoArquivo + ",idTipoQualidade = " + arquivoBE.idTipoQualidade + ",idStatus = " + arquivoBE.idStatus + ",Codigo = " + arquivoBE.Codigo + ",TamanhoArquivo= " + arquivoBE.TamanhoArquivo + ",Titulo= " + arquivoBE.Titulo + ",Original= " + arquivoBE.Original + ",Descricao= " + arquivoBE.Descricao + ",TituloOriginal= " + arquivoBE.Original + ",AnoLancamento= " + arquivoBE.AnoLancamento + ",Legenda= " + arquivoBE.Legenda + ",Idioma= " + arquivoBE.Idioma + ",PaisOrigem= " + arquivoBE.PaisOrigem + ",TAGS= " + arquivoBE.Tags + ",ImgCapa= " + arquivoBE.ImgCapa + ",Localizacao= " + arquivoBE.Localizacao + ",Qtd = " + arquivoBE.Qtd + ",Deletado= " + arquivoBE.Deletado + " Where id = " + arquivoBE.ID);
            db.ExecuteNonQuery(command);
        }

        /// <summary>
        /// Obtem dados do registro passando o ID
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public ArquivoBE Obter(int ID)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT * FROM Arquivo WHERE id = " + ID);

            using (IDataReader dr = db.ExecuteReader(command))
            {
                ArquivoBE arquivoBE = new ArquivoBE();
                if (dr.Read())
                {
                    arquivoBE.ID = Convert.ToInt32(dr["ID"]);
                    arquivoBE.IdUsuario = Convert.ToInt32(dr["idUsuario"]);
                    arquivoBE.idTipoMidia = Convert.ToInt32(dr["idTipoMidia"]);
                    arquivoBE.idTipoArquivo = Convert.ToInt32(dr["idTipoArquivo"]);
                    arquivoBE.idTipoQualidade = Convert.ToInt32(dr["idTipoQualidade"]);
                    arquivoBE.idStatus = Convert.ToInt32(dr["idStatus"]);
                    arquivoBE.Codigo = Convert.ToString(dr["Codigo"]);
                    arquivoBE.TamanhoArquivo = Convert.ToString(dr["TamanhoArquivo"]);
                    arquivoBE.Titulo = Convert.ToString(dr["Titulo"]);
                    arquivoBE.Original = Convert.ToString(dr["Original"]);
                    arquivoBE.Descricao = Convert.ToString(dr["Descricao"]);
                    arquivoBE.TituloOriginal = Convert.ToString(dr["TituloOriginal"]);
                    arquivoBE.AnoLancamento = Convert.ToString(dr["AnoLancamento"]);
                    arquivoBE.Legenda = Convert.ToString(dr["Legenda"]);
                    arquivoBE.Idioma = Convert.ToString(dr["Idioma"]);
                    arquivoBE.PaisOrigem = Convert.ToString(dr["PaisOrigem"]);
                    arquivoBE.Tags = Convert.ToString(dr["TAGS"]);
                    arquivoBE.ImgCapa = Convert.ToString(dr["ImgCapa"]);
                    arquivoBE.Localizacao = Convert.ToString(dr["Localizacao"]);
                    arquivoBE.Qtd = Convert.ToString(dr["Qtd"]);
                    arquivoBE.Deletado = Convert.ToBoolean(dr["Deletado"]);
                }
                return arquivoBE;
            }
        }

        /// <summary>
        /// Exclui um o usuário passando o ID
        /// </summary>
        /// <param name="ID"></param>
        public void Excluir(int ID)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("DELETE FROM Arquivo Where id = " + ID);
            db.ExecuteNonQuery(command);
        }

        /// <summary>
        /// Verifica se o código já esta cadastrado
        /// </summary>
        /// <param name="Codigo"></param>
        /// <returns></returns>
        public bool VerificaDuplicidadeCodigo(String Codigo)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT Codigo FROM Arquivo WHERE Codigo = " + Codigo + "");

            using (IDataReader dr = db.ExecuteReader(command))
            {
                bool Existe;
                if (dr.Read())
                {
                    Existe = true;
                }
                else
                {
                    Existe = false;
                }
                return Existe;
            }
        }

    }
}
