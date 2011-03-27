# Copyright (C) 2007-2009 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

PROJECT(luaexpat C)
CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
INCLUDE(dist.cmake)

# Find Expat
FIND_PACKAGE (EXPAT REQUIRED)
INCLUDE_DIRECTORIES (${EXPAT_INCLUDE_DIR})

# Build LuaExpat module
ADD_LUA_MODULE(lxp src/lxplib.c src/lxp.def)
TARGET_LINK_LIBRARIES(lxp ${EXPAT_LIBRARIES})

# Install LuaExpat
INSTALL (TARGETS lxp LIBRARY DESTINATION ${INSTALL_CMOD})
INSTALL (FILES src/lxp/lom.lua DESTINATION ${INSTALL_LMOD}/lxp)
INSTALL(FILES README DESTINATION ${INSTALL_DATA})
INSTALL(DIRECTORY doc/ DESTINATION ${INSTALL_DOC})
INSTALL(DIRECTORY tests/ DESTINATION ${INSTALL_TEST})

ADD_LUA_TEST(tests/test.lua)
ADD_LUA_TEST(tests/test-lom.lua) # FIX: need to add src/?.lua to package.path

