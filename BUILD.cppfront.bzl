# Bazel build file that provides build rules for the cppfront compiler and the
# utility library that is required by compiled .cpp2 -> .cpp files.

# Should be used in combination with the "new_local_repository" WORKSPACE rule
# so that the cpp2 generator rule can find the cppfront binary without pointing
# directly to the this path.

package(
    default_visibility = ["//visibility:public"],
)

cc_library(
    name = "cpp2util",
    hdrs = ["include/cpp2util.h"],
    includes = ["include/"],
)

cc_binary(
    name = "cppfront",
    srcs = glob(["source/*.cpp"]) + glob(["source/*.h"]),
    copts = ["-std=c++20"],
)
