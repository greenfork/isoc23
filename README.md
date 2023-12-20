Reproduction of isoc23 compilation failure.

```
$ git clone https://github.com/greenfork/isoc23.git
$ cd isoc23

# Wait a bit because this command downloads a large Raylib repository!
$ git submodule update --init --recursive jaylib

# Add janet.h to the hardcoded in jaylib include path (remember to delete it afterwords)
$ sudo mkdir /usr/local/include/janet
$ sudo cp src/janet.h /usr/local/include/janet/

$ zig version
0.11.0
$ zig build # works fine
$ zig build -Dtarget=x86_64-linux-gnu # fails

zig build-exe isoc23 Debug x86_64-linux-gnu: error: the following command failed with 3 compilation errors:
/home/grfork/zig-linux-x86_64-0.11.0/zig build-exe -cflags -std=c99 -DJANET_BUILD_TYPE=release -- /tmp/isoc23/src/thehouse_hello_world.c /tmp/isoc23/src/janet.c /tmp/isoc23/zig-cache/o/a488295558bcebe973d5d2fd0f35b729/libraylib.a -lGL -lX11 /tmp/isoc23/zig-cache/o/75663b2f53ebaf3a2586f24809272912/libjaylib.a -lc --cache-dir /tmp/isoc23/zig-cache --global-cache-dir /home/grfork/.cache/zig --name isoc23 -target x86_64-linux-gnu -mcpu x86_64 -I /tmp/isoc23/src -L /usr/lib --listen=-
Build Summary: 3/6 steps succeeded; 1 failed (disable with --summary none)
install transitive failure
└─ install isoc23 transitive failure
   └─ zig build-exe isoc23 Debug x86_64-linux-gnu 3 errors
error: ld.lld: undefined symbol: __isoc23_strtol
    note: referenced by init.c:213 (jaylib/raylib/src/external/glfw/src/init.c:213)
    note:               /tmp/isoc23/zig-cache/o/1dfae6069d01d348c4482230698d5016/rglfw.o:(_glfwParseUriList) in archive /tmp/isoc23/zig-cache/o/a488295558bcebe973d5d2fd0f35b729/libraylib.a
error: ld.lld: undefined symbol: __isoc23_sscanf
    note: referenced by context.c:408 (jaylib/raylib/src/external/glfw/src/context.c:408)
    note:               /tmp/isoc23/zig-cache/o/1dfae6069d01d348c4482230698d5016/rglfw.o:(_glfwRefreshContextAttribs) in archive /tmp/isoc23/zig-cache/o/a488295558bcebe973d5d2fd0f35b729/libraylib.a
    note: referenced by tinyobj_loader_c.h:792 (jaylib/raylib/src/external/tinyobj_loader_c.h:792)
    note:               /tmp/isoc23/zig-cache/o/7fbd155baba90ba2941e259d327944c1/rmodels.o:(tinyobj_parse_and_index_mtl_file) in archive /tmp/isoc23/zig-cache/o/a488295558bcebe973d5d2fd0f35b729/libraylib.a
    note: referenced by glad.h:8550 (jaylib/raylib/src/external/glad.h:8550)
    note:               /tmp/isoc23/zig-cache/o/c8be532591c10fa8971ba04591cac7e4/rcore.o:(glad_gl_find_core_gl) in archive /tmp/isoc23/zig-cache/o/a488295558bcebe973d5d2fd0f35b729/libraylib.a
    note: referenced 6 more times
error: ld.lld: undefined symbol: __isoc23_strtoul
    note: referenced by input.c:223 (jaylib/raylib/src/external/glfw/src/input.c:223)
    note:               /tmp/isoc23/zig-cache/o/1dfae6069d01d348c4482230698d5016/rglfw.o:(parseMapping) in archive /tmp/isoc23/zig-cache/o/a488295558bcebe973d5d2fd0f35b729/libraylib.a
    note: referenced by input.c:224 (jaylib/raylib/src/external/glfw/src/input.c:224)
    note:               /tmp/isoc23/zig-cache/o/1dfae6069d01d348c4482230698d5016/rglfw.o:(parseMapping) in archive /tmp/isoc23/zig-cache/o/a488295558bcebe973d5d2fd0f35b729/libraylib.a
    note: referenced by input.c:228 (jaylib/raylib/src/external/glfw/src/input.c:228)
    note:               /tmp/isoc23/zig-cache/o/1dfae6069d01d348c4482230698d5016/rglfw.o:(parseMapping) in archive /tmp/isoc23/zig-cache/o/a488295558bcebe973d5d2fd0f35b729/libraylib.a

$ zig version # same on master
0.12.0-dev.1814+5c0d58b71
$ zig build -Dtarget=x86_64-linux-gnu # fails

$ sudo rm -r /usr/local/include/janet
```

Commenting lines in `src/thehouse_hello_world.c` that include the jaylib
library also resolve the problem.

```c
    temptab = janet_table(0);
    temptab->proto = env;
    janet_module_entry_jaylib(temptab);
    janet_env_lookup_into(lookup, temptab, "_0000iS", 0);
```
