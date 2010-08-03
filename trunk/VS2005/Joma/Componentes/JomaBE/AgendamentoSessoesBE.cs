using System;
using System.Collections.Generic;
using System.Text;

namespace JomaBE
{
    public class AgendamentoSessoesBE
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

        private int midConvenio;

        public int idConvenio
        {
            get { return midConvenio; }
            set { midConvenio = value; }
        }

        private int midProfissional;

        public int idProfissional
        {
            get { return midProfissional; }
            set { midProfissional = value; }
        }

        private int midEspecialidade;

        public int idEspecialidade
        {
            get { return midEspecialidade; }
            set { midEspecialidade = value; }
        }

        private int midSessoesStatus;

        public int idSessoesStatus 
        {
            get { return midSessoesStatus; }
            set { midSessoesStatus = value; }
        }

        private string mNumeroConvenio;

        public string NumeroConvenio
        {
            get { return mNumeroConvenio; }
            set { mNumeroConvenio = value; }
        }

        private int mQtd;

        public int Qtd
        {
            get { return mQtd; }
            set { mQtd = value; }
        }

        private DateTime mDataInicio;

        public DateTime DataInicio
        {
            get { return mDataInicio; }
            set { mDataInicio = value; }
        }

        private DateTime mDataFim;

        public DateTime DataFim
        {
            get { return mDataFim; }
            set { mDataFim = value; }
        }

        private string mHoraInicio;

        public string HoraInicio
        {
            get { return mHoraInicio; }
            set { mHoraInicio = value; }
        }

        private string mHoraFim;

        public string HoraFim
        {
            get { return mHoraFim; }
            set { mHoraFim = value; }
        }

        private string mValor;

        public string Valor
        {
            get { return mValor; }
            set { mValor = value; }
        }

        //Referencia a outra classe relacionada
        private PacienteBE pacienteBE = new PacienteBE();

        public PacienteBE RefPacienteBE
        {
            get { return pacienteBE; }
            set { pacienteBE = value; }
        }

        //Referencia a outra classe relacionada
        private ProfissionaisBE profissionaisBE = new ProfissionaisBE();

        public ProfissionaisBE RefprofissionaisBE
        {
            get { return profissionaisBE; }
            set { profissionaisBE = value; }
        }

        //Referencia a outra classe relacionada
        private EspecialidadeBE especialidadeBE = new EspecialidadeBE();

        public EspecialidadeBE RefespecialidadeBE
        {
            get { return especialidadeBE; }
            set { especialidadeBE = value; }
        }

    }
}
