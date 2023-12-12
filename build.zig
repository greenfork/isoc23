const std = @import("std");
const jaylib = @import("jaylib/build.zig");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const exe = b.addExecutable(.{
        .name = "isoc23",
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });
    const flags = &[_][]const u8{ "-std=c99", "-DJANET_BUILD_TYPE=release" };
    exe.addCSourceFiles(&.{ "src/thehouse_hello_world.c", "src/janet.c" }, flags);
    exe.addIncludePath(.{ .path = "src" });
    exe.addLibraryPath(.{ .path = "/usr/lib" });
    jaylib.addJaylib(b, exe, target, optimize);

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
