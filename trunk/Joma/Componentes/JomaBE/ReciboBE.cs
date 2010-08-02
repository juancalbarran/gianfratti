using System;
using System.Collections.Generic;
using System.Text;

namespace JomaBE
{
    public class ReciboBE
    {

        private int mid;
        public int id
        {
            get { return mid; }
            set { mid = value; }
        }

        private int midPaciente;
        public int idPaciente
        {
            get { return midPaciente; }
            set { midPaciente = value; }
        }

        private int midProfissional;
        public int idProfissional
        {
            get { return midProfissional; }
            set { midProfissional = value; }
        }

        private string mPacienteNome;
        public string PacienteNome
        {
            get { return mPacienteNome; }
            set { mPacienteNome = value; }
        }

        private DateTime mData;
        public DateTime Data
        {
            get { return mData; }
            set { mData = value; }
        }

        private double mValorTotal;
        public double ValorTotal
        {
            get { return mValorTotal; }
            set { mValorTotal = value; }
        }

        private decimal mDesconto;
        public decimal Desconto
        {
            get { return mDesconto; }
            set { mDesconto = value; }
        }

        ProfissionaisBE profissionalBE = new ProfissionaisBE();
        public ProfissionaisBE RefProfissionalBE
        {
            get { return profissionalBE; }
            set { profissionalBE = value; }
        }

        //Referencia a outra classe relacionada
        List<ReciboAgendamentoSessoesBE> reciboAgendamentoSessoesBE = new List<ReciboAgendamentoSessoesBE>();
        public List<ReciboAgendamentoSessoesBE> RefReciboAgendamentoSessoesBE
        {
            get { return reciboAgendamentoSessoesBE; }
            set { reciboAgendamentoSessoesBE = value; }
        }
    }
}
