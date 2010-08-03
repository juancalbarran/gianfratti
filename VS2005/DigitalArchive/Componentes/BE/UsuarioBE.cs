//Data:         13/02/2009
//Autor:        Fabrizio Gianfratti Manes
//Descrição:    Classe de entidade
//Atualização:

using System;
using System.Collections.Generic;
using System.Text;

namespace BE
{
    public class UsuarioBE
    {
        private int mID;

        public int ID
        {
            get { return mID; }
            set { mID = value; }
        }

        private String mNome;

        public String Nome
        {
            get { return mNome; }
            set { mNome = value; }
        }

        private String mEmail;

        public String Email
        {
            get { return mEmail; }
            set { mEmail = value; }
        }

        private String mSenha;

        public String Senha
        {
            get { return mSenha; }
            set { mSenha = value; }
        }

        private String mImg;

        public String Img
        {
            get { return mImg; }
            set { mImg = value; }
        }

        private bool mAtivo;

        public bool Ativo
        {
            get { return mAtivo; }
            set { mAtivo = value; }
        }
	
    }


}
