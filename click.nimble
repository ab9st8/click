# Package

version       = "0.2.0"
author        = "c1m5j"
description   = "A simple one-command configurable C/C++ build tool."
license       = "MIT"
srcDir        = "src"
bin           = @["click"]
binDir        = "build"


# Dependencies

requires "nim >= 1.2.0"
requires "tomlserialization >= 0.2.0"