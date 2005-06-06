T= lxp
V= 1.0.1
CONFIG= ./config

include $(CONFIG)


lib: src/$(LIBNAME)

src/$(LIBNAME) : src/lxplib.o $(COMPAT_DIR)/compat-5.1.o
	$(CC) -o src/$(LIBNAME) $(LIB_OPTION) src/lxplib.o $(COMPAT_DIR)/compat-5.1.o

$(COMPAT_DIR)/compat-5.1.o: $(COMPAT_DIR)/compat-5.1.c
	$(CC) -c $(CFLAGS) -o $@ $(COMPAT_DIR)/compat-5.1.c

install:
	mkdir -p $(LUA_LIBDIR)
	cp src/$(LIBNAME) $(LUA_LIBDIR)
	ln -f -s $(LUA_LIBDIR)/$(LIBNAME) $(LUA_LIBDIR)/$T.so
	mkdir -p $(LUA_DIR)/$T
	cp src/$T/lom.lua $(LUA_DIR)/$T

clean:
	rm -f src/$(LIBNAME) src/lxplib.o $(COMPAT_DIR)/compat-5.1.o

# $Id: makefile,v 1.28 2005-06-06 20:25:23 tomas Exp $
