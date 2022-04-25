.PHONY: all \
  swigbox2d \
  clean

## Build mode: DEBUG, RELEASE
BUILD_MODE ?= RELEASE

## Build type: STATIC, SHARED
BUILD_TYPE ?= STATIC

## Target OS type
# - windows
# - unix
ifeq ($(OS),Windows_NT)
	TARGET_OS ?= windows
else
	TARGET_OS ?= unix
endif

## Output library file name
SWIGBOX2D_RELEASE_PATH ?= .
SWIGBOX2D_LIB_NAME ?= swigbox2d
ifeq ($(TARGET_OS),windows)
    SWIGBOX2D_LIB_NAME_PREFIX ?=
else
    SWIGBOX2D_LIB_NAME_PREFIX ?= lib
endif
SWIGBOX2D_LIB_NAME_SUFFIX ?=
ifeq ($(BUILD_TYPE),STATIC)
    ifeq ($(TARGET_OS),windows)
        SWIGBOX2D_LIB_NAME_EXTENSION ?= lib
    else
        SWIGBOX2D_LIB_NAME_EXTENSION ?= a
    endif
else
    ifeq ($(TARGET_OS),windows)
        SWIGBOX2D_LIB_NAME_EXTENSION ?= dll
    else
        SWIGBOX2D_LIB_NAME_EXTENSION ?= so
    endif
endif
SWIGBOX2D_LIB_NAME_FULL = $(SWIGBOX2D_RELEASE_PATH)/$(SWIGBOX2D_LIB_NAME_PREFIX)$(SWIGBOX2D_LIB_NAME)$(SWIGBOX2D_LIB_NAME_SUFFIX).$(SWIGBOX2D_LIB_NAME_EXTENSION)

## Misc
BOX2D_USER_SETTINGS ?= FALSE

## Swig
SWIG ?= swig

## Swig target language
SWIG_TARGET_LANGUAGE ?= lua

## Libraries
# Box2d library info
BOX2D_LIB_NAME     ?= box2d
BOX2D_LIB_PATH     ?= ./box2d/build/bin
BOX2D_INCLUDE_PATH ?= ./box2d/include/box2d
ifeq ($(SWIG_TARGET_LANGUAGE),lua)
    # Lua library info
    LUA_LIB_NAME     ?= lua5.1
    LUA_LIB_PATH     ?= /usr/lib/x86_64-linux-gnu
    LUA_INCLUDE_PATH ?= /usr/include/lua5.1
endif

########

# Objects
OBJS = box2d.i.o

# Toolchain
CC ?= cc
AR ?= ar

# Compile flags
CFLAGS        += -std=c++11
LDFLAGS       += -L$(BOX2D_LIB_PATH) -lstdc++
LDLIBS        += -l$(BOX2D_LIB_NAME)
INCLUDE_PATHS += -I$(BOX2D_INCLUDE_PATH)
CFLAGS_EXTRA  ?=
LDFLAGS_EXTRA ?=
ifeq ($(SWIG_TARGET_LANGUAGE),lua)
    LDFLAGS       += -L$(LUA_LIB_PATH)
    LDLIBS        += -l$(LUA_LIB_NAME)
    INCLUDE_PATHS += -I$(LUA_INCLUDE_PATH)
endif

ifeq ($(BUILD_MODE),DEBUG)
    CFLAGS += -g -DSWIGRUNTIME_DEBUG
else
	CFLAGS += -s -O3
endif
ifeq ($(BUILD_TYPE),SHARED)
    CFLAGS += -fPIC -DBUILD_LIBTYPE_SHARED
endif
ifeq ($(BOX2D_USER_SETTINGS),TRUE)
    CFLAGS += -DB2_USER_SETTINGS
endif

## Swig options
SWIG_OPTIONS = -c++
SWIG_OPTIONS_EXTRA ?=
ifeq ($(SWIG_TARGET_LANGUAGE),lua)
    SWIG_OPTIONS += -lua -no-old-metatable-bindings
endif
ifeq ($(BOX2D_USER_SETTINGS),TRUE)
    SWIG_OPTIONS += -DB2_USER_SETTINGS
endif

########

all: swigbox2d

swigbox2d: $(OBJS)
ifeq ($(BUILD_TYPE),STATIC)
	$(AR) rcs $(SWIGBOX2D_LIB_NAME_FULL) $(OBJS)
endif
ifeq ($(BUILD_TYPE),SHARED)
	$(CC) -shared -fPIC -o $(SWIGBOX2D_LIB_NAME_FULL) $(OBJS) $(LDFLAGS) $(LDFLAGS_EXTRA) $(LDLIBS)
endif

box2d.i.o: box2d.i.cpp
	$(CC) -c $< $(CFLAGS) $(CFLAGS_EXTRA) $(INCLUDE_PATHS) -o $@

box2d.i.cpp:
	$(SWIG) $(SWIG_OPTIONS) $(SWIG_OPTIONS_EXTRA) -I$(BOX2D_INCLUDE_PATH) -o $@ box2d.i

clean:
ifeq ($(OS),Windows_NT)
	del box2d.i.cpp
	del box2d.i.o
	del *$(BOX2D_LIB_NAME)*.lib
	del *$(BOX2D_LIB_NAME)*.dll
else
	rm -fv box2d.i.cpp
	rm -fv box2d.i.o
	rm -fv *$(BOX2D_LIB_NAME)*.a
	rm -fv *$(BOX2D_LIB_NAME)*.so
endif
