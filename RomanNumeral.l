%{
#include <stdio.h>
#include "RomanNumeral.tab.h" 
%}

%%

[IVXLCDM]+   { yylval.string = strdup(yytext); return ROMAN_NUMERAL; }
[\t\n]       ;  
.            ; 

%%

int yywrap() {
    return 1;
}
