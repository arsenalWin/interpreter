using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using SimpleScript.RunTime;
 
namespace SimpleScript.RunTime
{
    public class WhileLoopStatement: IStatement
    {
        private Expression condition = null;
        private StatementList whileBody = null;

        public WhileLoopStatement(Expression cond, StatementList body)
        {
            if (cond == null || body == null)
            {
                throw new ArgumentException("Null argument(s) not valid for While statement.");
            }
            this.condition = cond;
            this.whileBody = body;
        }

        public string Print()
        {
            string pattern = "While ({0}) Do\n {1} Next";
            return string.Format(pattern, this.condition.Print(), this.whileBody.Print());
        }

        public void Execute()
        {
            bool result;// = (bool)this.condition.Evaluate();
            while (result = (bool)this.condition.Evaluate())
            {
                whileBody.Execute();
            }
        }
    }
}
