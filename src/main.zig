const std = @import("std");
pub const cu = @cImport({
    // @cInclude("fix.h");
    @cInclude("cuda.h");
});

pub fn main() !void {
    const x = cu.int2;
    _ = x; // autofix
}
