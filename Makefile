Program = quicktest

all: ${Program}

${Program}.tab.c: ${Program}.y
		bison -d $^
lex.yy.c: ${Program}.l ${Program}.tab.h
	flex $<

${Program}: ${Program}.tab.c lex.yy.c ${Objects}
	gcc -o $@ $^ -lfl -ggdb
