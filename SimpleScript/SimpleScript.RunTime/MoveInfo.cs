using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SimpleScript.RunTime
{
    public class MoveInfo
    {
        public MoveInfo(MoveTypes moveType, PosInfo posInfo, MoveSpeed speed)
        {
            this.moveType = moveType;
            this.posInfo = posInfo;
            this.speed = speed;
        }

        private MoveTypes moveType;
        private MoveSpeed speed;
        private PosInfo posInfo;

        public MoveSpeed Speed
        {
            get { return speed; }
        }
        public MoveTypes Type
        {
            get { return moveType; }
        }
        public PosInfo PosInfo
        {
            get { return posInfo; }
        }

    }
}
