const std = @import("std");

pub fn main() !void {
    const sender = try std.process.getEnvVarOwned(std.debug.global_allocator, "SENDER");

    var numberBytes: [@sizeOf(u8)]u8 = undefined;
    try std.crypto.randomBytes(numberBytes[0..]);
    const number: u8 = std.mem.readIntLittle(u8, &numberBytes);

    const stdout = &(try std.io.getStdOut()).outStream().stream;
    try stdout.print("Hi {}! Your number is {}.", sender, number);
}
