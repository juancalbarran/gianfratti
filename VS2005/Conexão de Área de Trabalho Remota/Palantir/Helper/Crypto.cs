using System;
using System.Collections.Generic;
using System.Text;
using System.Security.Cryptography;
using System.IO;

namespace Helper
{
  public  class Crypto
    {
       static SymmetricAlgorithm mCSP;

        private static string SetLengthString(string str, int length)
        {
            while (length > str.Length)
            {
                str += str;
            }
            if (str.Length > length)
            {
                str = str.Remove(length);
            }
            return str;
        }

        public static string EncryptString(string Value, string parKey)
        {
            mCSP = SetEnc();
            string iv = "PenS8UCVF7s=";
            mCSP.IV = Convert.FromBase64String(iv);
            string key = SetLengthString(parKey.ToString(), 32);
            mCSP.Key = Convert.FromBase64String(key);
            ICryptoTransform ct;
            MemoryStream ms;
            CryptoStream cs;
            Byte[] byt = new byte[64];

            try
            {
                ct = mCSP.CreateEncryptor(mCSP.Key, mCSP.IV);
                byt = Encoding.UTF8.GetBytes(Value);
                ms = new MemoryStream();
                cs = new CryptoStream(ms, ct, CryptoStreamMode.Write);
                cs.Write(byt, 0, byt.Length);
                cs.FlushFinalBlock();
                cs.Close();

                return Convert.ToBase64String(ms.ToArray());
            }
            catch (Exception Ex)
            {
                throw (new Exception("An error occurred while encrypting string"));
            }
        }
        private static SymmetricAlgorithm SetEnc()
        {
            return new TripleDESCryptoServiceProvider();
        }
        public static string DecryptString(string Value, string parKey)
        {
            mCSP = SetEnc();
            string iv = "PenS8UCVF7s=";
            mCSP.IV = Convert.FromBase64String(iv);
            string key = SetLengthString(parKey.ToString(), 32);
            mCSP.Key = Convert.FromBase64String(key);
            ICryptoTransform ct;
            MemoryStream ms;
            CryptoStream cs;
            Byte[] byt = new byte[64];
            try
            {
                ct = mCSP.CreateDecryptor(mCSP.Key, mCSP.IV);
                byt = Convert.FromBase64String(Value);
                ms = new MemoryStream();
                cs = new CryptoStream(ms, ct, CryptoStreamMode.Write);
                cs.Write(byt, 0, byt.Length);
                cs.FlushFinalBlock();
                cs.Close();

                return Encoding.UTF8.GetString(ms.ToArray());                
            }
            catch (Exception ex)
            {
                throw (new Exception("An error occurred while decrypting string"));
            }
        }
    }
}
