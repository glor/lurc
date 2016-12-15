%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdarg.h>

#define YYSTYPE char *
int yydebug=0;

char* checkFun(char* cmd) {
	if(!strcmp(cmd, "+")) {
		return "lush.add";
	} else if(!strcmp(cmd, "-")) {
		return "lush.sub";
	} else if(!strcmp(cmd, "*")) {
		return "lush.mul";
	} else if(!strcmp(cmd, "/")) {
		return "lush.div";
	} else if(!strcmp(cmd, "..")) {
		return "lush.cat";
	} else if(!strcmp(cmd, "==")) {
		return "lush.equ";
	} else if(!strcmp(cmd, "and")) {
		return "lush.conjuction";
	} else if(!strcmp(cmd, "or")) {
		return "lush.disjuction";
	} else if(!strcmp(cmd, "<")) {
		return "lush.less";
	} else if(!strcmp(cmd, ">")) {
		return "lush.greater";
	} else if(!strcmp(cmd, "<=")) {
		return "lush.lesseq";
	} else if(!strcmp(cmd, ">=")) {
		return "lush.greatereq";
	} else if(!strcmp(cmd, "%")) {
		return "lush.mod";
	} else if(!strcmp(cmd, "~=")) {
		return "lush.noteq";
	} else if(!strcmp(cmd, "^")) {
		return "lush.xor";
	}
	return cmd;
}

char* sumstr(int n, ...) {
	char* args[n];
	va_list vl;
	va_start(vl,n);
	int len = 0;
	for(int i=0;i<n;i++) {
		args[i] = va_arg(vl,char*);
		len += strlen(args[i]);
	}
	va_end(vl);
	
	char* res = malloc(sizeof(char)*(len+1));
	res[0]=0;
	for(int i=0;i<n;i++) {
		strcat(res,args[i]);
		free(args[i]);
	}
	return res;
}

void yyerror(const char *str)
{
	fprintf(stderr,"error: %s\n",str);
}

int yywrap()
{
	return 1;
}

int main(void)
{
	yyparse();
}

%}

%token BR_OPEN BR_CLOSE ID END IF ELSE WHILE REPEAT UNTIL LET FUN LETFUN

%%
begin: sexpr sexprlist END		{printf("%s\n%s", $1, $2); exit(0);}
//	| ID members				{puts(sumstr(4, $1, strdup("("),$2,strdup(")")));}
	;
sexprlist:						{$$ = strdup("");}
	| sexpr sexprlist			{$$ = sumstr(3, $1, strdup("\n"), $2);}
	;
sexpr: ID						{$$ = $1;}
	| BR_OPEN fun members BR_CLOSE	{$$ = sumstr(4, $2, strdup("("),$3,strdup(")"));}
	| BR_OPEN IF sexpr sexprlist BR_CLOSE	{$$ = sumstr(5, strdup("if "), $3, strdup(" then "),$4,strdup(" end\n"));}
	| BR_OPEN WHILE sexpr sexprlist BR_CLOSE	{$$ = sumstr(5, strdup("while "), $3, strdup(" do "),$4,strdup(" end\n"));}
	| BR_OPEN REPEAT sexprlist UNTIL sexpr BR_CLOSE	{$$ = sumstr(5, strdup("repeat "), $3, strdup("\nuntil "),$5,strdup(" end\n"));}
	| BR_OPEN IF sexpr sexprlist ELSE sexprlist BR_CLOSE	{$$ = sumstr(7, strdup("if "), $3, strdup(" then\n"),$4, strdup("\nelse "), $6,strdup(" end\n"));}
	| BR_OPEN LET ID sexpr BR_CLOSE	{$$ = sumstr(4, $3, strdup(" = "), $4, strdup("\n"));}
	| BR_OPEN FUN BR_OPEN params BR_CLOSE sexprlist BR_CLOSE	{$$ = sumstr(5, strdup("function("), $4, strdup(") "), $6, strdup(" end\n"));}
	| BR_OPEN LETFUN ID BR_OPEN params BR_CLOSE sexprlist BR_CLOSE	{$$ = sumstr(7, $3, strdup(" = "), strdup("function("), $5, strdup(") "), $7, strdup(" end\n"));}
	;
members:						{$$ = strdup("");}
	| sexpr		 				{$$ = $1;}
	| members sexpr		 		{$$ = sumstr(3, $1, strdup(", "), $2);}
	;
params:							{$$ = strdup("");}
	| ID		 				{$$ = $1;}
	| members ID		 		{$$ = sumstr(3, $1, strdup(", "), $2);}
	;
fun:  ID						{$$ = strdup(checkFun($1));}
