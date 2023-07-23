// Implementation of Ice-Cream-Van in Zig
// original program written in TRS-80 BASIC
// Creative Computing / September 1985

const std = @import("std");

pub fn main() !void {
    display_menu();
}

fn display_menu() void {
    var day: u8 = 1;
    std.debug.print("Willams Refreshment Service, Day {}\n", .{day});
}
