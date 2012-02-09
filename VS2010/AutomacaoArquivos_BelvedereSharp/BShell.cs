using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;
using log4net;

namespace BelvedereSharp
{
    public class BShell
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(BShell));

        //TODO: Add reasonable timeout for shell execution, better option will be user customisable timeout value
        public static bool Run(string cmd)
        {   
            string shell;
            string options;
            if (Program.Platform == PlatformID.Win32NT || Program.Platform == PlatformID.Win32Windows)
            {
                shell = "cmd.exe";
                options = "/C";
            }
            else
            {
                shell = "/bin/bash";
                options = "-c ";
            }
            ProcessStartInfo pi = new ProcessStartInfo(shell, options + cmd);
            pi.CreateNoWindow = true;
            pi.UseShellExecute = false;
            Process p = new Process();
            p.StartInfo = pi;

            try
            {
                p.Start();
                p.WaitForExit();
                int c = p.ExitCode;
                p.Close();
                Log.Info("Successfully executed command: " + cmd);
            }
            catch (Exception ex)
            {
                Log.Error("Error raised during executing command " + cmd, ex);
                return false;
            }
            return true;
        }
    }
}
