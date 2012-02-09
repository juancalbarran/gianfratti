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
using System.IO;
using System.Xml.Serialization;
using log4net;

namespace BelvedereSharp
{
    [XmlRoot("belvedereSharp")]
    public class BelvedereSharp
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(BelvedereSharp));

        private int _sleepTime = 10; //in minutes
        List<BFolder> _folders = new List<BFolder>();

        [XmlAttribute("sleepTime")]
        public int SleepTime
        {
            get { return _sleepTime; }
            set { _sleepTime = value; }
        }

        [XmlElement("folder")]
        public BFolder[] Folders_Array
        {
            get { return _folders.ToArray(); }
            set
            {
                if (value == null) return;
                _folders.Clear();
                _folders.AddRange(value);
            }
        }

        [XmlIgnore]
        public List<BFolder> Folders
        {
            get { return _folders; }
            set { _folders = value; }
        }

        public BelvedereSharp()
        {
        }

        public void Serialize()
        {
            XmlSerializer s = new XmlSerializer(typeof(BelvedereSharp));
            TextWriter w = new StreamWriter("config.xml");
            s.Serialize(w, this);
            w.Close();
        }

        //TODO: Peform refactor on codes
        public bool Run()
        {
            bool result = true;
            foreach (BFolder f in _folders)
            {
                string sDir = f.Path;

                foreach (BRule r in f.Rules)
                {
                    if (!r.Enabled)
                        continue;

                    List<string> fileList = null;

                    bool matchAny = (r.AllOrAny != "All");

                    foreach (BCondition c in r.Conditions)
                    {
                        if (c.Condition == "is")
                            fileList = ConditionIs(fileList, sDir, matchAny, c);
                    }

                    if (fileList.Count == 0)
                        continue;

                    BAction a = r.Action;
                    if (a.Action == "Move file")
                        result = MoveFiles(fileList.ToArray(), a.Destinaton) ? result : false;
                    else if (a.Action == "Copy file")
                        result = CopyFiles(fileList.ToArray(), a.Destinaton) ? result : false;
                    else if (a.Action == "Send file to Recycle Bin")
                        result = SendFilesToRecycleBin(fileList.ToArray()) ? result : false;
                    else if (a.Action == "Custom command")
                        result = RunCustomCommand(fileList.ToArray(), sDir, a.Destinaton) ? result : false;
                }
            }
            return result;
        }

        #region Condition: Is
        private List<string> ConditionIs(List<string> fileList, string sDir, bool matchAny, BCondition c)
        {
            if (c.Element == "Extension")
                fileList = CombineFileList(matchAny, fileList, GetExtensionIs(sDir, c.Parameter));
            if (c.Element == "Name")
                fileList = CombineFileList(matchAny, fileList, GetNameIs(sDir, c.Parameter));
            return fileList;
        }

        private string[] GetExtensionIs(string dir, string ext)
        {
            if (ext.Length > 0 && ext[0] == '.')
                ext = ext.Substring(1);
            return Directory.GetFiles(dir, "*." + ext);
        }

        //TODO: Fix me, this will also move file with extension same as name 
        private string[] GetNameIs(string dir, string name)
        {
            return Directory.GetFiles(dir, name + ".*");
        }
        #endregion

        private List<string> CombineFileList(bool matchAny, List<string> a, string[] b)
        {
            //initialise
            if (a == null)
                return new List<string>(b);

            //matchAny
            if (matchAny)
            {
                foreach (string s in b)
                {
                    if (a.Contains(s)) a.Remove(s);
                }
                a.AddRange(b);
                return a;
            }

            //matchAll
            List<string> match = new List<string>();
            List<string> bl = new List<string>(b);
            foreach (string s in a)
            {
                if (bl.Contains(s))
                    match.Add(s);
            }
            return match;
        }

        #region IO operations
        protected bool CreateFolder(string d)
        {
            try
            {
                if (!Directory.Exists(d))
                {
                    Directory.CreateDirectory(d);
                    Log.Info("Created directory " + d);
                }
            }
            catch (Exception ex)
            {
                Log.Error("Unable to create directory " + d, ex);
                return false;
            }
            return true;
        }

        //TODO: Use object instead of long parameters
        //TODO: Support overwrite file, delete file if exists before move
        protected bool MoveFiles(string[] files, string dDir)
        {
            if (!CreateFolder(dDir))
                return false;

            bool result = true;
            foreach (string s in files)
            {
                try
                {
                    string d = Path.Combine(dDir, Path.GetFileName(s));
                    File.Move(s, d);
                    Log.Info("Moved file " + s + " to " + d);
                }
                catch (Exception ex)
                {
                    Log.Error("Unable to move file " + s, ex);
                    result = false;
                }
            }
            return result;
        }

        protected bool MoveDirectories(string[] dirs, string dDir)
        {
            if (!CreateFolder(dDir))
                return false;

            bool result = true;
            foreach (string s in dirs)
            {
                try
                {
                    string d = Path.Combine(dDir, Path.GetDirectoryName(s));
                    Directory.Move(s, d);
                    Log.Info("Moved directory " + s + " to " + d);
                }
                catch (Exception ex)
                {
                    Log.Error("Unable to move directory " + s, ex);
                    result = false;
                }
            }
            return result;
        }

        //TODO: Support overwrite file, delete file if exists before copy
        private bool CopyFiles(string[] files, string dDir)
        {
            if (!CreateFolder(dDir))
                return false;

            bool result = true;
            foreach (string s in files)
            {
                try
                {
                    File.Copy(s, Path.Combine(dDir, Path.GetFileName(s)));
                    Log.Info("Copied file " + s + " to " + Path.Combine(dDir, Path.GetFileName(s)));
                }
                catch (Exception ex)
                {
                    Log.Error("Unable to copy file " + s, ex);
                    result = false;
                }
            }
            return result;
        }

        protected bool CopyDirectories(string[] dirs, string dDir)
        {
            if (!CreateFolder(dDir))
                return false;

            bool result = true;
            foreach (string s in dirs)
            {
                try
                {
                    string d = Path.Combine(dDir, Path.GetFileName(s));
                    Directory.CreateDirectory(d);
                    string[] files = Directory.GetFiles(s);
                    result = CopyFiles(files, d) ? result : false;
                    string[] subDirs = Directory.GetDirectories(s);
                    result = CopyDirectories(subDirs, d) ? result : false;
                    Log.Info("Copied directory " + s + " to " + d);
                }
                catch (Exception ex)
                {
                    Log.Error("Unable to copy directory " + s, ex);
                    result = false;
                }
            }
            return result;
        }

        private bool SendFilesToRecycleBin(string[] files)
        {
            bool result = true;
            foreach (string f in files)
                result = BRecycle.RecycleFile(f) ? result : false;
            return result;
        }

        private bool RunCustomCommand(string[] files, string sDir, string cmd)
        {
            bool result = true;
            foreach (string f in files)
            {
                string c = cmd;
                string name = Path.GetFileName(f);
                c = c.Replace("${file}", f);
                c = c.Replace("${name}", name);
                c = c.Replace("${dir}", sDir);
                result = BShell.Run(c) ? result : false;
            }
            return result;
        }

        #endregion
    }
}
