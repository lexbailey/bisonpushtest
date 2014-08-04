%{
    #include <stdio.h>
    void yyerror(char* msg);
%}

%define api.pure full
%define api.push-pull push
%union {
    int INT_VAL;
}

%token STRING EXC
%token <INT_VAL> INT
%type <INT_VAL> somenumber

%%

    start: somenumber           {printf ("Result: %d\n", $1);}
         | start somenumber     {printf ("Result: %d\n", $2);}
         ;

    somenumber: STRING INT EXC           {$$ = $2 *2;}
              | STRING somenumber EXC    {$$ = $2 *2;}
              ;

%%

void yyerror(char* s){
    fprintf(stderr, "%s\n", s);
}
