using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;


namespace BusinessObjects
{
    [Serializable()]
    public class Machine
    {
        private string _RemoteDesktopConnectionName;
        public string RemoteDesktopConnectionName
        {
            get { return _RemoteDesktopConnectionName; }
            set { _RemoteDesktopConnectionName = value; }
        }

        private string _MachineName;
        public string MachineName
        {
            get { return _MachineName; }
            set { _MachineName = value; }
        }

        private string _DomainName;
        public string DomainName
        {
            get { return _DomainName; }
            set { _DomainName = value; }
        }

        private string _UserName;
        public string UserName
        {
            get { return _UserName; }
            set { _UserName = value; }
        }

        private string _Password;
        public string Password
        {
            get { return _Password; }
            set { _Password = value; }
        }

        private bool _AutoConnect;
        public bool AutoConnect
        {
            get { return _AutoConnect; }
            set { _AutoConnect = value; }
        }

        private bool _ShareDiskDrives;
        public bool ShareDiskDrives
        {
            get { return _ShareDiskDrives; }
            set { _ShareDiskDrives = value; }
        }

        private bool _SharePrinters;
        public bool SharePrinters
        {
            get { return _SharePrinters; }
            set { _SharePrinters = value; }
        }

        private bool _SavePassword;
        public bool SavePassword
        {
            get { return _SavePassword; }
            set { _SavePassword = value; }
        }

        private Colors _ColorDepth;
        public Colors ColorDepth
        {
            get { return _ColorDepth; }
            set { _ColorDepth = value; }
        }

        public enum Colors
        {
            HighColor15 = 15,
            HighColor16 = 16,
            Color256 = 8,
            TrueColor = 24
        }
    }
}
