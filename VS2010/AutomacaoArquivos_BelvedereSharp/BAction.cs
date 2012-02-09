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
    public class BAction
    {
        private string _action = "";
        private string _destination = "";

        [XmlAttribute("action")]
        public string Action
        {
            get { return _action; }
            set { _action = value; }
        }

        [XmlAttribute("destination")]
        public string Destinaton
        {
            get { return _destination; }
            set { _destination = value; }
        }

        public BAction()
        {
        }

        public BAction(string action, string destination)
        {
            _action = action;
            _destination = destination;
        }
    }
}
