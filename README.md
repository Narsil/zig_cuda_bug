
`main.zig`:

```zig
const std = @import("std");
pub const cu = @cImport({
    @cInclude("cuda.h");
});

pub fn main() !void {
    const x = cu.int2;
    _ = x; // autofix
}
```


`cuda.h` (extracted from cuda 12.4):

```c
#define __device_builtin__

#define __align__(n) \
        __attribute__((aligned(n)))

#define __cuda_builtin_vector_align8(tag, members) \
struct __device_builtin__ __align__(8) tag         \
{                                                  \
    members                                        \
}


__cuda_builtin_vector_align8(int2, int x; int y;);

typedef __device_builtin__ struct int2 int2;
```
