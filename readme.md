# !!! Work-In-Progress #

# swigbox2d #

[SWIG](http://www.swig.org/) binding for [Box2D](https://github.com/erincatto/box2d)

This repo generates bindings for Box2D to other languages (eg. Lua), by providing a `box2d.i` SWIG interface file.

> SWIG is a software development tool that connects programs written in C and C++ with a variety of high-level programming languages (C#, Java, Lua, Python, Ruby, ...)

> Box2D is a 2D physics engine for games

## Current Status ##

- SWIG 4.0.2
- box2d v2.4.1

## Build ##

Currently the provided `Makefile` only compiles this repo for the lua language, and you need to install `swig` and build `box2d` manually before proceeding.
After you have the built binary of `box2d`, you use `make` to build this project.

### Using make ###
```sh
# This method requires `swig` installed and `box2d` already built.

# If you don't have a `box2d` binary on your drive, you can recursively clone this repo to download the source to the submodule folder `box2d/`, and do:
# cd box2d; ./build.bat; cd ..     # For Windows
# (cd box2d && bash ./build.sh)    # For Unix systems

# Set the options first.
# You may want to read the `Makefile` for more options. (not very well documented though...)
EXPORT BUILD_MODE=[DEBUG|RELEASE]
EXPORT BUILD_TYPE=[SHARED|STATIC]
EXPORT SWIG_TARGET_LANGUAGE=[lua]
# If the binding targets to lua, you also need to set the path of the lua library. Change the following paths accordingly.
EXPORT LUA_LIB_NAME=[luajit|lua5.1|...]
EXPORT LUA_LIB_PATH=/usr/lib/x86_64-linux-gnu
EXPORT LUA_INCLUDE_PATH=/usr/include/lua5.1

# Build.
make

# Clean the project.
make clean
```

## Examples ##

### Lua ###

TODO

## Usage Notes ##

TODO

## Performance Notes ##

TODO

## Pull Requests are welcomed ##

Would be nicer if this repo can be a collection featuring Ruby/Python/... bindings as well!

## LICENSE ##

MIT
