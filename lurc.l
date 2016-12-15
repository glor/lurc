%{
#include <stdio.h>
#include "lurc.tab.h"
#define YYSTYPE char *
extern YYSTYPE yylval;
%}
%%
<<EOF>>			return END;
\(				return BR_OPEN;
\)				return BR_CLOSE;
if				return IF;
else			return ELSE;
while			return WHILE;
do				return REPEAT;
until			return UNTIL;
let				return LET;
fun				return FUN;
letfun			return LETFUN;
\"[^"]*\"		yylval=strdup(yytext); return ID; /* string */;
[^ \n\t\(\)]+	yylval=strdup(yytext); return ID; /* identifier */;
\n				/* ignore end of line */;
[ \t]+			/* ignore whitespace */; /*<<EOF>>			return END;*/
%%
