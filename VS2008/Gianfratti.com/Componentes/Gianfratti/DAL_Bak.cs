using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.OleDb;

namespace Gianfratti
{
    public class DAL_Bak
    {
        string connectionString = "";

        #region Metodos XML
        /// <summary>  
        /// Converte um DataSet para XML em disco  
        /// </summary>  
        /// <param name="ds">Nosso DataSet</param>  
        /// <param name="CaminhoXML">Caminho e nome do arquivo xml a ser gravado</param>  
        public void GravaDataSetXML(DataSet dataset, string CaminhoXML)
        {
            if (dataset != null && dataset.Tables.Count > 0)
            {
                dataset.WriteXml(CaminhoXML);
            }
        }

        /// <summary>  
        /// Converte um DataTable para XML em disco  
        /// </summary>  
        /// <param name="dt">Nosso DataTable</param>  
        /// <param name="CaminhoXML">Caminho e nome do arquivo xml a ser gravado</param>  
        public void GravaDataTableXML(DataTable dataTable, string CaminhoXML)
        {
            if (dataTable != null)
            {
                DataSet ds = new DataSet();
                ds.Tables.Add(dataTable);
                GravaDataSetXML(ds, CaminhoXML);
            }
        }
        # endregion

        public DataSet DataSet(string SQL)
        {
                OleDbConnection conn = new OleDbConnection(connectionString);
                OleDbDataAdapter adp = new OleDbDataAdapter(SQL,conn);
                DataSet ds = new DataSet();
                adp.Fill(ds);
                conn.Close();
                return ds;
        }
    }
}
