# Compilation parameters
CC = gcc
CWARNS = -Wall -pedantic \
        -Waggregate-return \
        -Wcast-align \
        -Wmissing-prototypes \
        -Wstrict-prototypes \
        -Wnested-externs \
        -Wpointer-arith \
        -Wshadow \
        -Wwrite-strings


CFLAGS = $(CONFIG) $(CWARNS) -ansi -g -O2 -I/home/roberto/tmp/lua/include \
   -L./expat/xmlparse


liblxp.so : lxplib.o
	ld -o liblxp.so -shared lxplib.o -lexpat

