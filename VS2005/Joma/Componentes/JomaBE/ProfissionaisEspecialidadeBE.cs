using System;
using System.Collections.Generic;
using System.Text;

namespace JomaBE
{
    public class ProfissionaisEspecialidadeBE
    {

        private int mid;
        public int id
        {
            get { return mid; }
            set { mid = value; }
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
    }
}
