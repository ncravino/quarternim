# Package

version = "0.1.0"
author = "nunocravino"
description = "Quaternim is a small quaternion library for nim"
license = "BSD-3-Clause"
srcDir = "src"


# Dependencies

requires "nim >= 1.6.12"

task build_docs, "Build docs":
    exec "nim doc --index:on --project --outdir:docs src/quaternim.nim && cp docs/quaternim.html docs/index.html"