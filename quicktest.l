%{
	#include "quicktest.tab.h"	

  #define PARSE(tok,tag,val) do { \
    YYSTYPE yylval = {.tag=val};  \
    int status = yypush_parse(ps, tok, &yylval); \
    if (status != YYPUSH_MORE) return status; \
  } while(0)
  #define PARSE_TOKEN(tok) do { \
    int status = yypush_parse(ps, tok, 0); \
    if (status != YYPUSH_MORE) return status; \
  } while(0)
%}
%option noyywrap nounput noinput

%%
                         yypstate *ps = yypstate_new ();

[A-Za-z]+               {PARSE_TOKEN(STRING);}
[1-9][0-9]*             {PARSE(INT,INT_VAL,atoi(yytext));}
"!*"[1-9][0-9]*         {int r = atoi(yytext+2);
                         while (r--) PARSE_TOKEN(EXC);
                        }
"!"                     {PARSE_TOKEN(EXC);}
.|\n                    {}
<<EOF>>                 {int status = yypush_parse(ps, 0, 0);
                         yypstate_delete(ps);
                         return status; 
                        }

%%

int main(int argc, char** argv) {
  return yylex();
}
