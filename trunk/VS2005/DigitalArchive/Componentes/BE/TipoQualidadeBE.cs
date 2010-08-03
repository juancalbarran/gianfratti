//Data:         13/02/2009
//Autor:        Fabrizio Gianfratti Manes
//Descrição:    Classe de entidade
//Atualização:

using System;
using System.Collections.Generic;
using System.Text;

namespace BE
{
    public class TipoQualidadeBE
    {
        private int mID;

        public int ID
        {
            get { return mID; }
            set { mID = value; }
        }

        private int mIdUsuario;

        public int idUsuario
        {
            get { return mIdUsuario; }
            set { mIdUsuario = value; }
        }

        private String mNome;

        public String Nome
        {
            get { return mNome; }
            set { mNome = value; }
        }

        //Referencia a outra classe relacionada
        private UsuarioBE mUsuarioBE = new UsuarioBE();

        public UsuarioBE RefUsuario
        {
            get { return mUsuarioBE; }
            set { mUsuarioBE = value; }
        }
    }
}
