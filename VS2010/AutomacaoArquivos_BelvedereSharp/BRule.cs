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
    public class BRule
    {
        private bool _enabled = false;
        private bool _confirmAction = false;
        private bool _recursive = false;
        private string _description = "";
        private string _allOrAny = "";
        private List<BCondition> _conditions = new List<BCondition>();
        private BAction _action = new BAction();


        [XmlAttribute("enabled")]
        public bool Enabled
        {
            get { return _enabled; }
            set { _enabled = value; }
        }

        [XmlAttribute("confirmAction")]
        public bool ConfirmAction
        {
            get { return _confirmAction; }
            set { _confirmAction = value; }
        }

        [XmlAttribute("recursive")]
        public bool Recursive
        {
            get { return _recursive; }
            set { _recursive = value; }
        }

        [XmlAttribute("description")]
        public string Description
        {
            get { return _description; }
            set { _description = value; }
        }

        [XmlAttribute("allOrAny")]
        public string AllOrAny
        {
            get { return _allOrAny; }
            set { _allOrAny = value; }
        }

        [XmlElement("condition")]
        public BCondition[] Conditions
        {
            get { return _conditions.ToArray(); }
            set
            {
                if (value == null) return;
                _conditions.Clear();
                _conditions.AddRange(value);
            }
        }

        [XmlElement("action")]
        public BAction Action
        {
            get { return _action; }
            set { _action = value; }
        }

        public BRule()
        {
        }
    }
}
