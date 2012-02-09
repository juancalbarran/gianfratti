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
using System.Xml.Serialization;

namespace BelvedereSharp
{
    public class BFolder
    {
        private List<BRule> _rules = new List<BRule>();
        private string _path = "";

        [XmlElement("rule")]
        public BRule[] Rules_Array
        {
            get { return _rules.ToArray(); }
            set { 
                if (value == null) return;
                _rules.Clear();
                _rules.AddRange(value);
            }
        }

        [XmlIgnore]
        public List<BRule> Rules
        {
            get { return _rules; }
            set { _rules = value; }
        }

        [XmlAttribute("path")]
        public string Path
        {
            get { return _path; }
            set { _path = value; }
        }

        public BFolder()
        {
        }

        public BFolder(string path)
        {
            _path = path;
        }
    }
}
