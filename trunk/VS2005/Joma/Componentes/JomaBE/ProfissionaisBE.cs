using System;
using System.Collections.Generic;
using System.Text;

namespace JomaBE
{
    public class ProfissionaisBE
    {

        private int mid;

        public int id
        {
            get { return mid; }
            set { mid = value; }
        }

        private int midProfissionalPerfil;

        public int idProfissionalPerfil
        {
            get { return midProfissionalPerfil; }
            set { midProfissionalPerfil = value; }
        }

        private string mNome;

        public string Nome
        {
            get { return mNome; }
            set { mNome = value; }
        }

        private DateTime mDtNascimento;
        public DateTime DtNascimento
        {
            get { return mDtNascimento; }
            set { mDtNascimento = value; }
        }

        private string mSexo;

        public string Sexo
        {
            get { return mSexo; }
            set { mSexo = value; }
        }

        private string mSenha;

        public string Senha
        {
            get { return mSenha; }
            set { mSenha = value; }
        }

        private string mEndereco;
        public string Endereco
        {
            get { return mEndereco; }
            set { mEndereco = value; }
        }

        private string mCEP;
        public string CEP
        {
            get { return mCEP; }
            set { mCEP = value; }
        }

        private string mBairro;
        public string Bairro
        {
            get { return mBairro; }
            set { mBairro = value; }
        }

        private string mUF;
        public string UF
        {
            get { return mUF; }
            set { mUF = value; }
        }

        private string mCidade;
        public string Cidade
        {
            get { return mCidade; }
            set { mCidade = value; }
        }

        private string mTelefone;
        public string Telefone
        {
            get { return mTelefone; }
            set { mTelefone = value; }
        }

        private string mCelular;
        public string Celular
        {
            get { return mCelular; }
            set { mCelular = value; }
        }

        private string mEmail;
        public string Email
        {
            get { return mEmail; }
            set { mEmail = value; }
        }

        private string mRG;
        public string RG
        {
            get { return mRG; }
            set { mRG = value; }
        }

        private string mCPF;
        public string CPF
        {
            get { return mCPF; }
            set { mCPF = value; }
        }

        private string mRegistro;
        public string Registro
        {
            get { return mRegistro; }
            set { mRegistro = value; }
        }

        private bool mFlgAtivo;
        public bool FlgAtivo
        {
            get { return mFlgAtivo; }
            set { mFlgAtivo = value; }
        }

        private string mObs;
        public string Obs
        {
            get { return mObs; }
            set { mObs = value; }
        }

        private bool mDeletado;
        public bool Deletado
        {
            get { return mDeletado; }
            set { mDeletado = value; }
        }
        
        //Referencia a outra classe relacionada
        private ProfissionalPerfilBE profissionalPerfilBE = new ProfissionalPerfilBE();

        public ProfissionalPerfilBE RefprofissionalPerfilBE
        {
            get { return profissionalPerfilBE; }
            set { profissionalPerfilBE = value; }
        }

    }
}
