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
LUA_LIBDIR= /usr/local/lib/lua/5.0
LUA_DIR= /usr/local/share/lua/5.0
LUA_INC= /usr/local/include/lua5

CFLAGS = $(CONFIG) $(CWARNS) -ansi -g -O2 -I$(LUA_INC) \
   -I$(COMPAT_DIR) -L./expat/xmlparse
LIB_EXT= .so
#LIB_EXT= .dylib
LUA_LIBS= -llua-5.0 -llualib-5.0 -lm

VERSION= 1.0.1
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
	gcc -o liblxp.dylib -dynamiclib lxplib.o compat-5.1.o -lexpat $(LUA_LIBS)
	ln -f -s liblxp.dylib lxp.dylib

compat-5.1.o: $(COMPAT_DIR)/compat-5.1.c
	$(CC) -c $(CFLAGS) -o $@ $(COMPAT_DIR)/compat-5.1.c

install:
	mkdir -p $(LUA_LIBDIR)
	cp liblxp$(LIB_EXT) lxp$(LIB_EXT) $(LUA_LIBDIR)
	mkdir -p $(LUA_DIR)/lxp
	cp lom.lua $(LUA_DIR)/lxp

clean:
	rm -f liblxp.so liblxp.dylib lxplib.o

dist: dist_dir
	tar -czf $(TAR_FILE) $(DIST_DIR)
	zip -rq $(ZIP_FILE) $(DIST_DIR)/*
	rm -rf $(DIST_DIR)

dist_dir:
	mkdir $(DIST_DIR)
	cp $(SRCS) $(DIST_DIR)
