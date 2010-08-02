using System;
using System.Collections.Generic;
using System.Text;

namespace JomaBE
{
    public class SessoesStatusBE
    {

        private int mid;

        public int id
        {
            get { return mid; }
            set { mid = value; }
        }

        private string mNome;

        public string Nome
        {
            get { return mNome; }
            set { mNome = value; }
        }
    }
}
