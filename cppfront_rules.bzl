load("@bazel_skylib//lib:paths.bzl", "paths")

def cpp2_library(name, cppfront_flags = [], srcs = [], **kwargs):
    """Like cc_library, but for .cpp2 files

    This is a simple macro that takes .cpp2 files, runs them through cppfront,
    then sticks the resulting files in a cc_library.

    cppfront_flags: Flags to stick in the cppfront command line
    srcs: .cpp2 files to compile into C++ files
    All other arguments are passed into the cc_library rule.
    """

    cc_files = []
    for s in srcs:
        cc_files += [paths.split_extension(s)[0] + ".cpp"]

    # The cppfront binary only supports outputting output files to the cwd. As
    # such, we have to use this hacky solution to copy them from the exec root
    # (typically in a temporary sandbox) into the location where they are
    # supposed to go.
    # Hopefully cppfront will add a -o flag or something so that we can remove
    # the copy.
    flags_str = " ".join(cppfront_flags)
    native.genrule(
        name = name + "_cpp2_to_cc",
        srcs = srcs,
        outs = cc_files,
        cmd = ("$(location @cppfront//:cppfront) " + flags_str + " $<;" +
               "cp " + " ".join(cc_files) + "  $(@D)"),
        tools = ["@cppfront//:cppfront"],
        visibility = ["//visibility:private"],
    )

    native.cc_library(
        name = name,
        srcs = cc_files,
        deps = ["@cppfront//:cpp2util"] + kwargs.get("deps", default = []),
        **kwargs
    )
