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
    public class UsuarioDAL
    {
        /// <summary>
        /// Innclui um novo registro
        /// </summary>
        /// <param name="usuarioBE"></param>
        public void Incluir(UsuarioBE usuarioBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("INSERT INTO Usuario (Nome,Email,Senha,Img,Ativo) VALUES (" + usuarioBE.Nome + "," + usuarioBE.Email + "," + usuarioBE.Senha + "," + usuarioBE.Img + "," + usuarioBE.Ativo + ")");
            db.ExecuteNonQuery(command);
        }

        /// <summary>
        /// Retorna uma lista de registro
        /// </summary>
        /// <returns></returns>
        public List<UsuarioBE> Listar()
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT * FROM Usuario");
            List<UsuarioBE> Lista = new List<UsuarioBE>();
            using (IDataReader dr = db.ExecuteReader(command))
            {
                while (dr.Read())
                {
                    UsuarioBE usuarioBe = new UsuarioBE();
                    usuarioBe.ID = Convert.ToInt32(dr["ID"]);
                    usuarioBe.Nome = Convert.ToString(dr["Nome"]);
                    usuarioBe.Email = Convert.ToString(dr["Email"]);
                    usuarioBe.Senha = Convert.ToString(dr["Senha"]);
                    usuarioBe.Img = Convert.ToString(dr["Img"]);
                    usuarioBe.Ativo = Convert.ToBoolean(dr["Ativo"]);
                    Lista.Add(usuarioBe);
                }
            }
            return Lista;
        }

        /// <summary>
        /// Altera o cadastro
        /// </summary>
        /// <param name="usuarioBE"></param>
        public void Alterar(UsuarioBE usuarioBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("UPDATE Usuario SET Nome = " + usuarioBE.Nome + ",Email = " + usuarioBE.Email + ",Senha = " + usuarioBE.Senha + ",Img ="+ usuarioBE.Img + ", Ativo = " + usuarioBE.Ativo + " Where id = " + usuarioBE.ID);
            db.ExecuteNonQuery(command);
        }

        /// <summary>
        /// Obtem dados do registro passando o ID
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public UsuarioBE Obter(int ID)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT * FROM Usuario WHERE id = " + ID);

            using (IDataReader dr = db.ExecuteReader(command))
            {
                UsuarioBE usuarioBE = new UsuarioBE();
                if (dr.Read())
                {
                    usuarioBE.ID = Convert.ToInt32(dr["ID"]);
                    usuarioBE.Nome = Convert.ToString(dr["Nome"]);
                    usuarioBE.Email = Convert.ToString(dr["Email"]);
                    usuarioBE.Senha = Convert.ToString(dr["Senha"]);
                    usuarioBE.Img = Convert.ToString(dr["Img"]);
                    usuarioBE.Ativo = Convert.ToBoolean(dr["Ativo"]);
                }
                return usuarioBE;
            }
        }

        /// <summary>
        /// Exclui um o usuário passando o ID
        /// </summary>
        /// <param name="ID"></param>
        public void Excluir(int ID)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("DELETE FROM Usuario Where id = " + ID);
            db.ExecuteNonQuery(command);
        }

        /// <summary>
        /// Autentica o usuario no sistema
        /// </summary>
        /// <param name="Email"></param>
        /// <param name="Senha"></param>
        /// <returns></returns>
        public UsuarioBE Autentica(String Email, String Senha)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT Email, Senha FROM Usuario WHERE Ativo = 0 AND Email = " + Email + " AND Senha = " + Senha + " ");

            using (IDataReader dr = db.ExecuteReader(command))
            {
                UsuarioBE usuarioBE = new UsuarioBE();
                if (dr.Read())
                {
                    usuarioBE.ID = Convert.ToInt32(dr["ID"]);
                    usuarioBE.Nome = Convert.ToString(dr["Nome"]);
                    usuarioBE.Email = Convert.ToString(dr["Email"]);
                    usuarioBE.Img = Convert.ToString(dr["Img"]);
                    usuarioBE.Ativo = Convert.ToBoolean(dr["Ativo"]);
                }
                return usuarioBE;
            }
        }

        /// <summary>
        /// Verifica se o email já esta cadastrado
        /// </summary>
        /// <param name="Email"></param>
        /// <returns></returns>
        public bool VerificaDuplicidadeEmail(String Email)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT Email FROM Usuario WHERE Email = " + Email + "");

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
