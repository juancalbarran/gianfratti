using System;
using System.Collections.Generic;
using System.Text;

namespace Util
{
    public class UtilWeb
    {
        #region [Valida Hora]

        /// <summary>
        /// Valida Hora
        /// A hora deve ser passada no seguinte formato. Ex: 12:00
        /// </summary>
        /// <param name="Hora"></param>
        /// <returns></returns>
        public bool ValidaHora(string Hora)
        {
            DateTime DataTemp;
            if (!DateTime.TryParse(Hora + ":00", out DataTemp))
            {
                return false;
            }
            return true;  
        }

        #endregion

        #region [Validações de Datas]

        /// <summary>
        /// Compara 2 Datas e verifica se a data final é menor que a data final
        /// Para usar passas as datas no formato DateTime
        /// </summary>
        /// <param name="DataInicial"></param>
        /// <param name="DataFinal"></param>
        /// <returns></returns>
        public bool ComparaDatas(DateTime DataInicial, DateTime DataFinal)
        {
            if (DataFinal >= DataInicial)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        #endregion

        #region [Tempo Entre Datas]

        /// <summary>
        /// Extrai o tempo entre 2 datas retornando um array contendo a quantidade de Dias,Horas,Minutos,Segundos
        /// Exemplo de usar:
        /// int[] Array = new int[4];
        /// Array = validacoes.TempoEntreDatas(Convert.ToDateTime("30/03/2009 10:00:00"),Convert.ToDateTime("31/03/2009 14:10:00"));
        /// Response.Write(Array[0] + "-" + Array[1] + "-" + Array[2] + "-" + Array[3]);
        /// </summary>
        /// <param name="DataInicial"></param>
        /// <param name="DataFinal"></param>
        /// <returns></returns>
        public int[] TempoEntreDatas(DateTime DataInicial, DateTime DataFinal)
        {
            DateTime startTime = DataInicial; //DateTime.Now;
            DateTime endTime = DataFinal.AddSeconds(100); //DateTime.Now.AddSeconds(100); 

            TimeSpan span = endTime.Subtract(startTime);
            int[] Array = { span.Days, span.Hours, span.Minutes, span.Seconds };
            return Array;
        }

        #endregion

        #region [Gera Senha]

        /// <summary>
        /// Gera Senha Randomica com 6 Caracteres alfanumericos
        /// Para usar. Ex: GeraSenhaRandomica()
        /// </summary>
        /// <returns></returns>
        public string GeraSenhaRandomica()
        {
            Random rLetra = new Random();
            string Alfabeto = "ABCDEFGHIJKLMNOPQRSTUVXZ0123456789";

            char[] aSenha ={ 
            Alfabeto[ (rLetra.Next(0,33))], 
            Alfabeto[ (rLetra.Next(0,33))], 
            Alfabeto[ (rLetra.Next(0,33))], 
            Alfabeto[ (rLetra.Next(0,33))], 
            Alfabeto[ (rLetra.Next(0,33))], 
            Alfabeto[ (rLetra.Next(0,33))]
            };

            string SenhaGerada = string.Empty;
            for (int i = 0; i < aSenha.Length; i++)
            {
                SenhaGerada += aSenha[i].ToString();
            }
            
            return SenhaGerada;
        }

        #endregion
    }
}
