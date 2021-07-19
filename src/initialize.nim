import os, utils

const TOML_CONTENT*: string = """
  ############################### 
# This file contains your Click   # 
# configuration.                  #
# To reinitialize, run            #
# ---------                       #
#    $ click init                 #
# ---------                       #
# again.                          #
# This file is required for Click #
# to run. You can safely delete   #
# this message.                   #
  ###############################

name        = "bin"        # The name of the project, the name of the binary. "bin" by default.
compiler    = "gcc"        # What compiler to use. "gcc" by default.
extensions  = [".c"]       # List of file extensions Click should look for. [".c"] by default.
outputDir   = "build"    # To which directory to output the executable. `build` by default.
auxOutput   = true         # Whether Click should output auxiliary info: "Found <n> files!" and "Runnning <command>..."
ignoreDirs  = [".vscode"]  # List of directories to ignore in compilation. [".vscode"] by default.
ignoreFiles = []           # List of paths to files to ignore in compilation. Empty by default.
flags       = ["-Wall"]    # List of flags with which to compile. ["-Wall"] by default.
libs        = []           # List of static libraries to link. Empty by default.
includes    = []           # List of `include` directories. Empty by default.
linkDirs    = []           # List of link directories. Empty by default.
"""


## Initialises the Click configuration (by creating a new
## `click.toml` file) or reinitialize if there's one already.
## Simpler than you would think.
proc initialize*(reinitialize: bool, workspace: string) =
    writeFile(workspace / "click.toml", TOML_CONTENT)
    writeSuccess(
      if reinitialize: "Reinitialized `click.toml`!" 
      else: "Generated `click.toml`!",
    true)
