-- adapt the following lines to your system
-- See Copyright Notice in license.html
-- $Id: lxp.lua,v 1.2 2003-12-02 14:56:28 tomas Exp $

local libname = "liblxp.so"
local libdir = "./"

local func = "luaopen_lxp"

assert(loadlib(libdir..libname, func))()
