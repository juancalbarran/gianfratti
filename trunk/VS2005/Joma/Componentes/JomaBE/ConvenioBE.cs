using System;
using System.Collections.Generic;
using System.Text;

namespace JomaBE
{
    public class ConvenioBE
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

        private double mValor;

        public double Valor
        {
            get { return mValor; }
            set { mValor = value; }
        }
    }
}
