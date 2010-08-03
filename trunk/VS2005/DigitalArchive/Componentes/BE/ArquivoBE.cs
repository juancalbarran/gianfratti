//Data:         13/02/2009
//Autor:        Fabrizio Gianfratti Manes
//Descrição:    Classe de entidade
//Atualização:

using System;
using System.Collections.Generic;
using System.Text;

namespace BE
{
    public class ArquivoBE
    {
        private int mID;

        public int ID
        {
            get { return mID; }
            set { mID = value; }
        }

        private int mIdUsuario;

        public int IdUsuario
        {
            get { return mIdUsuario; }
            set { mIdUsuario = value; }
        }

        private int midTipoMidia;

        public int idTipoMidia
        {
            get { return midTipoMidia; }
            set { midTipoMidia = value; }
        }

        private int midTipoArquivo;

        public int idTipoArquivo
        {
            get { return midTipoArquivo; }
            set { midTipoArquivo = value; }
        }

        private int midTipoQualidade;

        public int idTipoQualidade
        {
            get { return midTipoQualidade; }
            set { midTipoQualidade = value; }
        }

        private int midStatus;

        public int idStatus
        {
            get { return midStatus; }
            set { midStatus = value; }
        }

        private String mCodigo;

        public String Codigo
        {
            get { return mCodigo; }
            set { mCodigo = value; }
        }

        private String mTamanhoArquivo;

        public String TamanhoArquivo
        {
            get { return mTamanhoArquivo; }
            set { mTamanhoArquivo = value; }
        }

        private String mTitulo;

        public String Titulo
        {
            get { return mTitulo; }
            set { mTitulo = value; }
        }

        private String mOriginal;

        public String Original
        {
            get { return mOriginal; }
            set { mOriginal = value; }
        }

        private String mDescricao;

        public String Descricao
        {
            get { return mDescricao; }
            set { mDescricao = value; }
        }

        private String mTituloOriginal;

        public String TituloOriginal
        {
            get { return mTituloOriginal; }
            set { mTituloOriginal = value; }
        }

        private String mAnoLancamento;

        public String AnoLancamento
        {
            get { return mAnoLancamento; }
            set { mAnoLancamento = value; }
        }

        private String mLegenda;

        public String Legenda
        {
            get { return mLegenda; }
            set { mLegenda = value; }
        }

        private String mIdioma;

        public String Idioma
        {
            get { return mIdioma; }
            set { mIdioma = value; }
        }

        private String mPaisOrigem;

        public String PaisOrigem
        {
            get { return mPaisOrigem; }
            set { mPaisOrigem = value; }
        }

        private String mTags;

        public String Tags
        {
            get { return mTags; }
            set { mTags = value; }
        }

        private String mImgCapa;

        public String ImgCapa
        {
            get { return mImgCapa; }
            set { mImgCapa = value; }
        }

        private String mLocalizacao;

        public String Localizacao
        {
            get { return mLocalizacao; }
            set { mLocalizacao = value; }
        }

        private String mQtd;

        public String Qtd
        {
            get { return mQtd; }
            set { mQtd = value; }
        }

        private bool mDeletado;

        public bool Deletado
        {
            get { return mDeletado; }
            set { mDeletado = value; }
        }

        //Referencia a outra classe relacionada
        private UsuarioBE mUsuarioBE = new UsuarioBE();

        public UsuarioBE RefUsuario
        {
            get { return mUsuarioBE; }
            set { mUsuarioBE = value; }
        }

        //Referencia a outra classe relacionada
        private TipoMidiaBE mTipoMidiaBE = new TipoMidiaBE();

        public TipoMidiaBE RefTipoMidiaBE
        {
            get { return mTipoMidiaBE; }
            set { mTipoMidiaBE = value; }
        }

        //Referencia a outra classe relacionada
        private TipoArquivoBE mTipoArquivoBE = new TipoArquivoBE();

        public TipoArquivoBE RefTipoArquivoBE
        {
            get { return mTipoArquivoBE; }
            set { mTipoArquivoBE = value; }
        }

        //Referencia a outra classe relacionada
        private TipoQualidadeBE mTipoQualidadeBE = new TipoQualidadeBE();

        public TipoQualidadeBE RefTipoQualidadeBE
        {
            get { return mTipoQualidadeBE; }
            set { mTipoQualidadeBE = value; }
        }

        //Referencia a outra classe relacionada
        private StatusBE mStatusBE = new StatusBE();

        public StatusBE RefStatusBE
        {
            get { return mStatusBE; }
            set { mStatusBE = value; }
        }
    }
}
