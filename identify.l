%{
#undef yywrap
#define yywrap() 1
#include<stdio.h>
    int statements = 0;
    int ids = 0;
    int assign = 0;
    int ops = 0;
    int keywords = 0;
    int integers = 0; 
%}
DIGIT [0-9]
LETTER [A-Za-z]
TYPE int|char|bool|float|void|for|do|while|if|else|return|void
%option yylineno
%option noyywrap

%%


{TYPE} {printf("Keyword: %s\n",yytext);keywords++;}
(<|>|<=|>=|==) {printf("Operator: %s\n",yytext);ops++;}

[a-zA-Z]+[a-zA-Z0-9]* {printf("Identifier: %s\n",yytext);ids++;}

[0-9]+ {printf("Integer: %s\n",yytext);integers++;}
.      {;}

%%

int main(){
    FILE *fh;
    if (fh = fopen("in.c", "r")) {
      yyin = fh;
    }
    yylex();
    printf("Identifiers = %d | Keywords = %d | Operators = %d | Integers = %d \n",ids,keywords,ops,integers);
}