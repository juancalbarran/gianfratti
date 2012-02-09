/// Copyright (C) 2009 Matthew Ng
/// 
/// Based on Belvedere by Adam Pash (http://github.com/adampash/belvedere/tree/)
/// 
/// BelvedereSharp is free software; you can redistribute it and/or
/// modify it under the terms of the GNU General Public License
/// as published by the Free Software Foundation; either version 2
/// of the License, or (at your option) any later version.
/// 
/// BelvedereSharp is distributed in the hope that it will be useful,
/// but WITHOUT ANY WARRANTY; without even the implied warranty of
/// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
/// GNU General Public License for more details.
///
/// You should have received a copy of the GNU General Public License
/// along with this program; if not, write to the Free Software
/// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;
using log4net;
using System.IO;

namespace BelvedereSharp
{
    public static class BRecycle
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(BRecycle));

        // Following codes written by Jeff Key, reference in
        // http://www.personalmicrocosms.com/Pages/dotnettips.aspx?c=19&t=22

        private const int FO_DELETE = 0x0003;
        private const int FOF_ALLOWUNDO = 0x0040;
        private const int FOF_NOCONFIRMATION = 0x0010;

        [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Auto)] //Deleted Pack=1 to get it working
        private struct SHFILEOPSTRUCT
        {
            public IntPtr hwnd;
            [MarshalAs(UnmanagedType.U4)]
            public int wFunc;
            public string pFrom;
            public string pTo;
            public short fFlags;
            [MarshalAs(UnmanagedType.Bool)]
            public bool fAnyOperationsAborted;
            public IntPtr hNameMappings;
            public string lpszProgressTitle;
        }

        [DllImport("shell32.dll", CharSet = CharSet.Auto)]
        static extern int SHFileOperation(ref SHFILEOPSTRUCT FileOp);

        //TODO: Add support for Linux/Unix recycle
        public static bool RecycleFile(string path)
        {
            bool result = false;
            if (Program.Platform == PlatformID.Win32Windows || Program.Platform == PlatformID.Win32NT)
                result = WindowsRecycleFile(path);
            else if (Program.Platform == PlatformID.MacOSX)
                result = MacOSXMoveToTrash(path);
            else
                Log.Error("Send file to recycle bin or trash is not supported on this platform.");
            return result;
        }

        public static bool WindowsRecycleFile(string path)
        {
            try
            {
                SHFILEOPSTRUCT fileop = new SHFILEOPSTRUCT();
                fileop.wFunc = FO_DELETE;
                fileop.pFrom = path + '\0' + '\0';
                fileop.fFlags = FOF_ALLOWUNDO | FOF_NOCONFIRMATION;

                int r = SHFileOperation(ref fileop);

                if (File.Exists(path))
                    Log.Error("Unable to recycle file" + path);
                else
                    Log.Info("Recycled file " + path);
            }
            catch (Exception ex)
            {
                Log.Error("Unable to recycle file " + path, ex);
                return false;
            }
            return true;
        }

        public static bool MacOSXMoveToTrash(string path)
        {
            try
            {
                string home = Environment.GetFolderPath(Environment.SpecialFolder.Personal);
                string dest = Path.Combine(home + "/.trash", Path.GetFileName(path));
                File.Move(path, dest);
                if (File.Exists(dest))
                    Log.Error("Unable to move file to trash " + path + " -> " + dest);
                else
                    Log.Info("Moved file to trash " + path + " -> " + dest);
            }
            catch (Exception ex)
            {
                Log.Error("Unable to move file to trash " + path, ex);
                return false;
            }
            return true;
        }
    }
}
