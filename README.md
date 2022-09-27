# cppfront-bzl-rules
bazel rules for the experimental cppfront compiler (WIP)

This repository provides bazel rules for the cppfront compiler (https://github.com/hsutter/cppfront).

It is a work in progress. I've only tested very simple projects with it.

# Usage
## BUILD file
```bazel
load("@cppfront_rules//:cppfront_rules.bzl", "cpp2_library")

cpp2_library(
    name = "hello_world_cpp2",
    srcs = ["foo.cpp2"],
)

cc_binary(
    name = "hello_world",
    deps = [":hello_world_cpp2"],
)
```
## Build it
```sh
bazel build --copt="-std=c++20" :hello_world
```

# Requirements for integration:
 - A reasonably up to date version of bazel (I have tested as far back as 3.5.1, maybe it works on even older versions though)
 - `bazel-skylib` (https://github.com/bazelbuild/bazel-skylib) must be available in your WORKSPACE
 - A C++ compiler that supports `-std=c++20`
 - A build that is configured in `-std=c++20` mode (ie, your entire project should be using `-std=c++20`)

# Demo repository:
As both a demonstration for how to integrate as well as some examples, see jray272/cppfront-bzl-rules-demo.
