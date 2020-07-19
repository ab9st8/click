# Package

version       = "0.1.0"
author        = "aachh"
description   = "A simple one-command configurable C build tool."
license       = "MIT"
srcDir        = "src"
bin           = @["click"]
binDir        = "build"



# Dependencies

requires "nim >= 1.2.0"
requires "yaml >= 0.13.1"
