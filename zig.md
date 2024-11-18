# Notas de Zig

- El archivo `root.zig` sirve como punto de entrada para cuando queres que el proyecto sea una
  libreria.
  Si solo vas a correr como ejecutable se puede borrar.

- El `main.zig` es el archivo que es el punto de entrada para los ejecutables.
  Si se va a crear una libreria se puede borrar.

Example allocator usage:

```zig
const std = @import("std");

pub fn main() !void {
    // type: "std.mem.Allocator"
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    // ** The next two lines are the important ones **
    var arr = try allocator.alloc(usize, try getRandomCount());
    defer allocator.free(arr);

    for (0..arr.len) |i| { 
        arr[i] = i;
    }
    std.debug.print("{any}\n", .{arr});
}

fn getRandomCount() !u8 {
    var seed: u64 = undefined;
    try std.posix.getrandom(std.mem.asBytes(&seed));
    var random = std.Random.DefaultPrng.init(seed);
    return random.random().uintAtMost(u8, 5) + 5;
}
```

## Generics

Ejemplo de uso de genericos en Zig:

```zig
const std = @import("std");
const Allocator = std.mem.Allocator;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var list = try List(u32).init(allocator);
    defer list.deinit();

    for (0..10) |i| {
        try list.add(@intCast(i));
    }

    std.debug.print("{any}\n", .{list.items[0..list.pos]});
}

fn List(comptime T: type) type {
    return struct {
pos: usize,
         items: []T,
         allocator: Allocator,

         fn init(allocator: Allocator) !List(T) {
             return .{
                 .pos = 0,
                 .allocator = allocator,
                 .items = try allocator.alloc(T, 4),
             };
         }

     fn deinit(self: List(T)) void {
         self.allocator.free(self.items);
     }

     fn add(self: *List(T), value: T) !void {
         const pos = self.pos;
         const len = self.items.len;

         if (pos == len) {
             // we've run out of space
             // create a new slice that's twice as large
             var larger = try self.allocator.alloc(T, len * 2);

             // copy the items we previously added to our new space
             @memcpy(larger[0..len], self.items);

             self.allocator.free(self.items);

             self.items = larger;
         }

         self.items[pos] = value;
         self.pos = pos + 1;
     }
    };
}
```

NOTA:
se podria realizar un pequeno truco para poder utilizar un tipo "Self" para hacer un poco mas
simple la escritura dle codigo usando el macro `@This()`, el cual trae el tipo del ultimo
contexto donde fue llamado:

```zig
// inside the struct
{
    // Added
    const Self = @This();

    fn init(allocator: Allocator) !Self {
        // ... same code
    }

    fn deinit(self: Self) void {
        // .. same code
    }

    fn add(self: *Self, value: T) !void {
        // .. same code
    }
}
```
