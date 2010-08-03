//Data:         13/02/2009
//Autor:        Fabrizio Gianfratti Manes
//Descrição:    Classe de entidade
//Atualização:

using System;
using System.Collections.Generic;
using System.Text;

namespace BE
{
    public class StatusBE
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
    }
}
