using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;

namespace Helper
{
    public class BinarySerializer
    {
        public static string ToBinary(object objectToBinary)
        {
            MemoryStream ms = new MemoryStream();
            BinaryFormatter bf = new BinaryFormatter();
            bf.Serialize(ms, objectToBinary);
            ms.Close();
            byte[] byteArr = ms.ToArray();
            return Encoding.GetEncoding("iso-8859-9").GetString(byteArr, 0, byteArr.Length);
        }
        public static object BinaryTo(string str)
        {
            byte[] byteArr = Encoding.GetEncoding("iso-8859-9").GetBytes(str);
            MemoryStream memStream = new MemoryStream(byteArr);
            BinaryFormatter bFormatter = new BinaryFormatter();
            object obj = bFormatter.Deserialize(memStream);
            return obj;
        }
    }
}
