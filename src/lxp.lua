-- adapt the following lines to your system

local libname = "liblxp.so"
local libdir = "./"

local func = "luaopen_lxp"

assert(loadlib(libdir..libname, func))()
