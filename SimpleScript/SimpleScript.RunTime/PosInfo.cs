using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SimpleScript.RunTime
{
    public class PosInfo : SymbolTableElement
    {
        public PosInfo(String name)
            : base(name)
        {
            
        }

        private bool isHome = false;
        private string config = "N U T, 0, 0, 0";
        private int uf = 0;
        private int ut = 1;
        private int type;
        private float j1, j2, j3, j4, j5, j6;

        public int Type
        {
            get { return type; }
            set { type = value; }
        }

    }
}
