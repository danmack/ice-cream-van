// Implementation of Ice-Cream-Van in Zig
// original program written in TRS-80 BASIC
// Creative Computing / September 1985

const std = @import("std");
const bufPrint = std.fmt.bufPrint;

const Assets = struct {
    cash: f16,
    savings: f16,
    ice_cost: f16,
    ice_value: f16,
    auto_efficency: u8,
    fuel: u8,
};

pub fn main() !void {

    const stdin = std.io.getStdIn();
    // const stdout = std.io.getStdOut().outStream();

    // starting inventory
    var inventory = Assets {
        .cash = 8.5,
        .savings = 0.0,
        .ice_cost = 137.50,
        .ice_value = 359.05,
        .auto_efficency = 100,
        .fuel = 18,
    };

    const main_menu =
        \\1 Play Ice Cream Van
        \\2 Quit to System Prompt
        \\
        \\Select Option? 
    ;

    var choice : i32 = 0;
    while (choice != 2) {
        std.debug.print("\n{s}", .{main_menu});
        choice = read_num(&stdin);
        switch (choice) {
            1 => {
                disp_menu(1);
                disp_assets(&inventory);
                choice = 0;
                std.debug.print("\nGame Over\n\n", .{});
            },
            2 => {
                std.debug.print("\nGood Bye\n\n", .{});
                std.os.exit(0);
            },
            else => continue,
        }
    }

    std.debug.print("\n", .{});
    disp_menu(1);
    disp_assets(&inventory);
}

fn read_num(stdin: *const std.fs.File) i32 {

    var buf: [20]u8 = undefined;
    const len = stdin.*.read(&buf) catch |err| {
        std.debug.print("Error while reading num: {}\n", .{err});
        std.os.exit(1);
    };

    if (len == buf.len) {
        std.debug.print("Input is too big!\n", .{});
        std.os.exit(1);
    }

    const line = std.mem.trimRight(u8, buf[0..len], "\r\n");
    const val = std.fmt.parseInt(i32, line, 10) catch |err| {
        std.debug.print("Error while reading number: {}\n", .{err});
        std.os.exit(1);
    };

    return val;
}

fn disp_menu(day: u8) void {
    std.debug.print("Willams Refreshment Service, Day {}\n", .{day});
    std.debug.print("\n", .{});

    const menu =
        \\1 Assets report   5 Automobile report
        \\2 Navigate        6 Take van invty
        \\3 Visit Johnson's 7 Work your route
        \\4 Visit Sentry Bank
        \\
        \\Select Option?
    ;
    std.debug.print("{s}\n", .{menu});
}

fn disp_assets(inv: *Assets) void {

    std.debug.print("-----------------------------------\n", .{});
    std.debug.print("Cash             : $ {d:9>.2}\n", .{inv.cash});
    std.debug.print("Savings Acct     : $ {d:>.2}\n", .{inv.savings});
    std.debug.print("Ice Cost         : $ {d:.2}\n", .{inv.ice_cost});
    std.debug.print("Ice Retail Value : $ {d:.2}\n", .{inv.ice_value});
    std.debug.print("\n", .{});
}
