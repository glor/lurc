# lurc
	poc transpiler from lisp-like-syntax to lua  
# dependencies
	- yacc (i used yacc 1.9 on BSD (byacc); GNU bison would need small changes)  
	- lex  
	- make  
	- lua for testing  
# what works
	- translating from s-expressions to lua function calls  
	- arithmetric operations  
	- some control structures: [while, do-while, if, if-else]  
	- [let, fun, letfun]  
# what doesn't work
	most everything else e.g.  
	- access to lua data structures  
	- quoted lists  
	- macros  
	- interactive mode (currently there is just the transpiler an no interpreter)  
# how to run
	`test.lrc` holds example code printing some sqare numbers and running a recursive fibonaci sequence algorithm  
	run `make` and then do `cat test.lrc | ./lurc | lua -i -e 'lush=require "stdlib"'` to test
# overview
	- lurc.l contains the lexer code
	- lurc.y contains the parser code
	- stdlib.lua contains redefinitions for (partially binary) infix operators; it needs to be 'required' in lua first for lurc to work
	- test.lrc contains example lurc code
