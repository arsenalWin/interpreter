﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SimpleScript.RunTime
{
    public interface IStatement
    {
        //ToDo: statement 接口需要修改
        string Print();
        void Execute();
    }
}
