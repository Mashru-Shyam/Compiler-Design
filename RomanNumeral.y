%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "RomanNumeral.tab.h"

int yylex();
void yyerror(const char *s);

int roman_to_int(const char *roman);

%}

%union {
    char *string;
}

%token <string> ROMAN_NUMERAL

%%

input: ROMAN_NUMERAL   { printf("Numeric value: %d\n", roman_to_int($1)); }
     |    
     ;

%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    exit(1);
}

int roman_to_int(const char *roman) {
    int roman_dict[256] = {0};
    roman_dict['I'] = 1;
    roman_dict['V'] = 5;
    roman_dict['X'] = 10;
    roman_dict['L'] = 50;
    roman_dict['C'] = 100;
    roman_dict['D'] = 500;
    roman_dict['M'] = 1000;

    int total = 0;
    int prev_value = 0;
    for (int i = strlen(roman) - 1; i >= 0; i--) {
        int value = roman_dict[roman[i]];
        if (value < prev_value) {
            total -= value;
        } else {
            total += value;
        }
        prev_value = value;
    }
    return total;
}