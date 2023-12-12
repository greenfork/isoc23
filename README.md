Reproduction of isoc23 compilation failure.

```
$ git clone https://github.com/greenfork/isoc23.git
$ git submodule init --update --recursive jaylib
$ zig version
0.11.0
$ zig build # works fine
$ zig build -Dtarget=x86_64-linux-gnu # fails

zig build-exe isoc23 Debug x86_64-linux-gnu: error: the following command failed with 3 compilation errors:
/home/grfork/zig-linux-x86_64-0.11.0/zig build-exe -cflags -std=c99 -DJANET_BUILD_TYPE=release -- /home/grfork/playground/zig/isoc23/src/thehouse_hello_world.c /home/grfork/playground/zig/isoc23/src/janet.c /home/grfork/playground/zig/isoc23/zig-cache/o/cb167f7fe73e888448f3fc5ab48312a8/libraylib.a -lGL -lX11 /home/grfork/playground/zig/isoc23/zig-cache/o/d976185b6c1e9c47510220c966067d4a/libjaylib.a -lc --cache-dir /home/grfork/playground/zig/isoc23/zig-cache --global-cache-dir /home/grfork/.cache/zig --name isoc23 -target x86_64-linux-gnu -mcpu x86_64 -I /home/grfork/playground/zig/isoc23/src -L /usr/lib --listen=-
Build Summary: 3/6 steps succeeded; 1 failed (disable with --summary none)
install transitive failure
└─ install isoc23 transitive failure
   └─ zig build-exe isoc23 Debug x86_64-linux-gnu 3 errors
error: ld.lld: undefined symbol: __isoc23_sscanf
    note: referenced by glad.h:8550 (jaylib/raylib/src/external/glad.h:8550)
    note:               /home/grfork/playground/zig/isoc23/zig-cache/o/57e5afc777678d2b304f8dd88b738997/rcore.o:(glad_gl_find_core_gl) in archive /home/grfork/playground/zig/isoc23/zig-cache/o/cb167f7fe73e888448f3fc5ab48312a8/libraylib.a
    note: referenced by tinyobj_loader_c.h:792 (jaylib/raylib/src/external/tinyobj_loader_c.h:792)
    note:               /home/grfork/playground/zig/isoc23/zig-cache/o/4fc88bc30d46b95d6f036b3967493d45/rmodels.o:(tinyobj_parse_and_index_mtl_file) in archive /home/grfork/playground/zig/isoc23/zig-cache/o/cb167f7fe73e888448f3fc5ab48312a8/libraylib.a
    note: referenced by rtext.c:2051 (jaylib/raylib/src/rtext.c:2051)
    note:               /home/grfork/playground/zig/isoc23/zig-cache/o/7af67c08f7865ff254dca04678614f98/rtext.o:(LoadBMFont) in archive /home/grfork/playground/zig/isoc23/zig-cache/o/cb167f7fe73e888448f3fc5ab48312a8/libraylib.a
    note: referenced 6 more times
error: ld.lld: undefined symbol: __isoc23_strtol
    note: referenced by init.c:213 (jaylib/raylib/src/external/glfw/src/init.c:213)
    note:               /home/grfork/playground/zig/isoc23/zig-cache/o/947250a0408e0142d4482b32f813d322/rglfw.o:(_glfwParseUriList) in archive /home/grfork/playground/zig/isoc23/zig-cache/o/cb167f7fe73e888448f3fc5ab48312a8/libraylib.a
error: ld.lld: undefined symbol: __isoc23_strtoul
    note: referenced by input.c:223 (jaylib/raylib/src/external/glfw/src/input.c:223)
    note:               /home/grfork/playground/zig/isoc23/zig-cache/o/947250a0408e0142d4482b32f813d322/rglfw.o:(parseMapping) in archive /home/grfork/playground/zig/isoc23/zig-cache/o/cb167f7fe73e888448f3fc5ab48312a8/libraylib.a
    note: referenced by input.c:224 (jaylib/raylib/src/external/glfw/src/input.c:224)
    note:               /home/grfork/playground/zig/isoc23/zig-cache/o/947250a0408e0142d4482b32f813d322/rglfw.o:(parseMapping) in archive /home/grfork/playground/zig/isoc23/zig-cache/o/cb167f7fe73e888448f3fc5ab48312a8/libraylib.a
    note: referenced by input.c:228 (jaylib/raylib/src/external/glfw/src/input.c:228)
    note:               /home/grfork/playground/zig/isoc23/zig-cache/o/947250a0408e0142d4482b32f813d322/rglfw.o:(parseMapping) in archive /home/grfork/playground/zig/isoc23/zig-cache/o/cb167f7fe73e888448f3fc5ab48312a8/libraylib.a

$ zig version # same on master
0.12.0-dev.1814+5c0d58b71
$ zig build -Dtarget=x86_64-linux-gnu # fails
```
