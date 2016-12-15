all:
	lex lurc.l
	yacc -d -b lurc lurc.y
	cc lex.yy.c lurc.tab.c -o lurc
	
clean:
	rm lex.yy.c lurc.tab.c lurc.tab.h lurc
