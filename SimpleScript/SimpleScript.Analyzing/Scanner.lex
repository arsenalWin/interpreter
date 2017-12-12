%namespace LexScanner
%option noparser
alpha [a-zA-Z]
alphaplus [a-zA-Z\-']
digits [0-9]+

%% 
\n|\r\n? {;}
{digits} { 	; }
{alpha} {  return (int)1234; }
%%

    public static void Main(string[] argp) { 
        Scanner scnr = new Scanner();
        for (int i = 0; i < argp.Length; i++) {
            Console.WriteLine("Scanning \"" + argp[i] + "\"");
            scnr.SetSource(argp[i], 0);
            scnr.yylex();
        }
    }
