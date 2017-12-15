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

        //private bool isHome = false;
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

        public float J1
        {
            get { return j1; }
            set { j1 = value; }
        }
        public float J2
        {
            get { return j2; }
            set { j2 = value; }
        }
        public float J3
        {
            get { return j3; }
            set { j3 = value; }
        }
        public float J4
        {
            get { return j4; }
            set { j4 = value; }
        }
        public float J5
        {
            get { return j5; }
            set { j5 = value; }
        }
        public float J6
        {
            get { return j6; }
            set { j6 = value; }
        }

    }
}
