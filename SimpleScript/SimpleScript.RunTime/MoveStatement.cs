using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SimpleScript.RunTime
{
    public class MoveStatement : IStatement
    {
        public MoveStatement(MoveTypes moveType, string posInfo, MoveSpeed speed)
        {
            this.moveType = moveType;
            this.posInfo = posInfo;
            this.speed = speed;
        }

        private MoveTypes moveType;
        private MoveSpeed speed;
        private string posInfo;

        public MoveSpeed Speed
        {
            get { return speed; }
        }
        public MoveTypes Type
        {
            get { return moveType; }
        }
        public string PosInfo
        {
            get { return posInfo; }
        }

        public string Print()
        {
            throw new NotImplementedException();
        }

        public void Execute()
        {
            throw new NotImplementedException();
        }
    }
}
