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
using System.Windows.Forms;
using System.IO;
using log4net;

namespace BelvedereSharp
{
    public static class Program
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(Program));
        public static PlatformID Platform;

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            //Platform = Environment.OSVersion.Platform;
            if (Environment.OSVersion.Platform == PlatformID.Win32NT)
            {
                Platform = PlatformID.Win32NT;
            }
            else if (Environment.OSVersion.Platform == PlatformID.Unix)
            {
                if (Directory.Exists("/System"))
                    Platform = PlatformID.MacOSX;
                else
                    Platform = PlatformID.Unix;
            }
            Log.Info("Detected OS: " + Platform.ToString());

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new FormMain());
        }
    }
}
