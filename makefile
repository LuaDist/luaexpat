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


CFLAGS = $(CONFIG) $(CWARNS) -ansi -g -O2 -I/usr/local/include/lua5 \
   -L./expat/xmlparse

VERSION= 1.0b
PKG = luaexpat-$(VERSION)
TAR_FILE= $(PKG).tar.gz
ZIP_FILE= $(PKG).zip
SRCS= README makefile \
	lxplib.c lxplib.h lxp.lua lom.lua \
	test.lua test-lom.lua \
	index.html manual.html lom.html luaexpat.png


liblxp.so : lxplib.o
	ld -o liblxp.so -shared lxplib.o -lexpat

liblxp.dylib : lxplib.o
	gcc -o liblxp.dylib -dynamiclib lxplib.o -lexpat -llua.5.0 -llualib.5.0

clean:
	rm -f liblxp.so liblxp.dylib lxplib.o

dist:
	mkdir $(PKG)
	cp $(SRCS) $(PKG)
	tar -czf $(TAR_FILE) $(PKG)
	zip -lq $(ZIP_FILE) $(PKG)/*
	rm -rf $(PKG)
