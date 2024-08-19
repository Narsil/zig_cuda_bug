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
