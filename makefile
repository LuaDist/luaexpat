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

COMPAT_DIR= ../compat/src
LUA_LIBDIR= /usr/local/lib/lua/5.0
LUA_DIR= /usr/local/share/lua/5.0
LUA_INC= /usr/local/include/lua5

CFLAGS = $(CONFIG) $(CWARNS) -ansi -g -O2 -I$(LUA_INC) \
   -I$(COMPAT_DIR) -L./expat/xmlparse
#LUA_LIBS= -llua-5.0 -llualib-5.0 -lm
LIB_OPTION= -shared #for Linux
#LIB_OPTION= -bundle -undefined dynamic_lookup #for MacOS X

VERSION= 1.0.1
PKG = luaexpat-$(VERSION)
DIST_DIR= $(PKG)
TAR_FILE= $(PKG).tar.gz
ZIP_FILE= $(PKG).zip
SRCS= README makefile \
	src/lxplib.c src/lxplib.h src/lom.lua \
	tests/test.lua tests/test-lom.lua \
	doc/us/index.html doc/us/manual.html doc/us/license.html doc/us/lom.html doc/us/examples.html doc/us/luaexpat.png


lib: src/liblxp.so

src/liblxp.so : src/lxplib.o $(COMPAT_DIR)/compat-5.1.o
	gcc -o src/liblxp.so $(LIB_OPTION) src/lxplib.o $(COMPAT_DIR)/compat-5.1.o -lexpat

$(COMPAT_DIR)/compat-5.1.o: $(COMPAT_DIR)/compat-5.1.c
	$(CC) -c $(CFLAGS) -o $@ $(COMPAT_DIR)/compat-5.1.c

install:
	mkdir -p $(LUA_LIBDIR)
	cp src/liblxp.so $(LUA_LIBDIR)
	cd $(LUA_LIBDIR); ln -f -s liblxp.so lxp.so
	mkdir -p $(LUA_DIR)/lxp
	cp src/lxp/lom.lua $(LUA_DIR)/lxp

clean:
	rm -f src/liblxp.so src/lxplib.o

dist: dist_dir
	tar -czf $(TAR_FILE) $(DIST_DIR)
	zip -rq $(ZIP_FILE) $(DIST_DIR)/*
	rm -rf $(DIST_DIR)

dist_dir:
	mkdir $(DIST_DIR)
	cp $(SRCS) $(DIST_DIR)

# $Id: makefile,v 1.25 2005-06-03 19:31:43 tuler Exp $
