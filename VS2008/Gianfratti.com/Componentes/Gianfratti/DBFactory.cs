using System.Data.SqlClient;
using System.Data.OleDb;
using System.Data.Odbc;
using System.Data.OracleClient;
using System.Data.Common;

namespace Gianfratti
{
    public enum DataProviderType
    {
        Oracle, SqlServer, OleDb, Odbc
    }

    internal class DBFactory
    {
        private static DbProviderFactory objFactory = null;

        public static DbProviderFactory GetDataProvider(DataProviderType provider)
        {
            switch (provider)
            {
                case DataProviderType.SqlServer:
                    objFactory = SqlClientFactory.Instance;
                    break;
                case DataProviderType.OleDb:
                    objFactory = OleDbFactory.Instance;
                    break;
                case DataProviderType.Oracle:
                    objFactory = OracleClientFactory.Instance;
                    break;
                case DataProviderType.Odbc:
                    objFactory = OdbcFactory.Instance;
                    break;
            }
            return objFactory;
        }

        public static DbConnection GetConnection(DataProviderType providerType)
        {
            switch (providerType)
            {
                case DataProviderType.SqlServer:
                    return new SqlConnection();
                case DataProviderType.OleDb:
                    return new OleDbConnection();
                case DataProviderType.Odbc:
                    return new OdbcConnection();
                case DataProviderType.Oracle:
                    return new OracleConnection();
                default:
                    return null;
            }
        }

        public static DbCommand GetCommand(DataProviderType providerType)
        {
            switch (providerType)
            {
                case DataProviderType.SqlServer:
                    return new SqlCommand();
                case DataProviderType.OleDb:
                    return new OleDbCommand();
                case DataProviderType.Odbc:
                    return new OdbcCommand();
                case DataProviderType.Oracle:
                    return new OracleCommand();
                default:
                    return null;
            }
        }

        public static DbDataAdapter GetDataAdapter(DataProviderType providerType)
        {
            switch (providerType)
            {
                case DataProviderType.SqlServer:
                    return new SqlDataAdapter();
                case DataProviderType.OleDb:
                    return new OleDbDataAdapter();
                case DataProviderType.Odbc:
                    return new OdbcDataAdapter();
                case DataProviderType.Oracle:
                    return new OracleDataAdapter();
                default:
                    return null;
            }
        }
    }
}
