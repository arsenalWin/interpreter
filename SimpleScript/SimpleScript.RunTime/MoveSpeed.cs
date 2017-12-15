using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SimpleScript.RunTime
{
    public class MoveSpeed
    {
        public MoveSpeed(int value, String type)
        {
            this.type = type;
            this.value = value;
        }

        private String type;
        private int value;

        public String Type
        {
            get { return type; }
        }

        public int Value
        {
            get { return value; }
        }

    }
}
