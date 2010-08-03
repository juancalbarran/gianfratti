using System;
using System.Collections.Generic;
using System.Text;

namespace JomaBE
{
    public class ReciboAgendamentoSessoesBE
    {

        private int mid;
        public int id
        {
            get { return mid; }
            set { mid = value; }
        }

        private int midRecibo;
        public int idRecibo
        {
            get { return midRecibo; }
            set { midRecibo = value; }
        }

        private int midAgendamentoSessoes;
        public int idAgendamentoSessoes
        {
            get { return midAgendamentoSessoes; }
            set { midAgendamentoSessoes = value; }
        }

        private double mValor;
        public double Valor
        {
            get { return mValor; }
            set { mValor = value; }
        }

        private DateTime mData;
        public DateTime Data
        {
            get { return mData; }
            set { mData = value; }
        }
    }
}
