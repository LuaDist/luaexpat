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

COMPAT_DIR= ../compat
LUA_LIB_DIR= /usr/local/lib/lua/5.0
LUA_DIR= /usr/local/share/lua/5.0

CFLAGS = $(CONFIG) $(CWARNS) -ansi -g -O2 -I/usr/local/include/lua5 \
   -I$(COMPAT_DIR) -L./expat/xmlparse

VERSION= 1.0b2
PKG = luaexpat-$(VERSION)
DIST_DIR= $(PKG)
TAR_FILE= $(PKG).tar.gz
ZIP_FILE= $(PKG).zip
SRCS= README makefile \
	lxplib.c lxplib.h lom.lua \
	test.lua test-lom.lua \
	index.html manual.html lom.html luaexpat.png


liblxp.so : lxplib.o compat-5.1.o
	ld -o liblxp.so -shared lxplib.o compat-5.1.o -lexpat
	ln -f -s liblxp.so lxp.so

liblxp.dylib : lxplib.o compat-5.1.o
	gcc -o liblxp.dylib -dynamiclib lxplib.o compat-5.1.o -lexpat -llua-5.0 -llualib-5.0
	ln -f -s liblxp.dylib lxp.dylib

compat-5.1.o: $(COMPAT_DIR)/compat-5.1.c
	$(CC) -c $(CFLAGS) -o $@ $(COMPAT_DIR)/compat-5.1.c

install:
	mkdir -p $(LUA_LIB_DIR)
	cp lib* lxp.* $(LUA_LIB_DIR)
	mkdir -p $(LUA_DIR)
	cp lom.lua $(LUA_DIR)

clean:
	rm -f liblxp.so liblxp.dylib lxplib.o

dist: dist_dir
	tar -czf $(TAR_FILE) $(DIST_DIR)
	zip -lq $(ZIP_FILE) $(DIST_DIR)/*
	rm -rf $(DIST_DIR)

dist_dir:
	mkdir $(DIST_DIR)
	cp $(SRCS) $(DIST_DIR)
