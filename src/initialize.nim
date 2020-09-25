import os, terminal

const YAML_CONTENT* = """--- # CLICK CONFIGURATION # ---

##################################/
# This file contains your Click   # 
# configuration.                  #
# To reinitialize, run            #
# --------                        #
#    $ click init                 #
# --------                        #
# again.                          #
# This file is required for Click #
# to run.                         #
##################################/

name       : bin         # The name of the project. Your binary will be named this. `bin` by default.
compiler   : clang       # What compiler Click should use. `clang` by default.
outputDir  : ./build     # Directory to which the executable should be outputted. `./build` by default.
auxOutput  : true        # Whether Click should output auxiliary info: `Found <x> C files!` and `Runnning <command>`
ignoreDirs : [".vscode"] # List of directories to ignore in compilation. [".vscode"] by default.
ignoreFiles: []          # List of paths to files to ignore in compilation. Empty by default.
"""


## Initialize the Click configuartion (by creating a new
## `click.yaml` file) or reinitialize if there's one already.
## Simpler than you would think. (Ran *only* with `click init`.)
proc initialize*(reinitialize: bool, workspace: string) =
  if reinitialize:
    removeFile(workspace / "click.yaml")

  stdout.styledWriteLine(fgCyan, if reinitialize: "Reinitialized `click.yaml`!" else: "Generated `click.yaml`!")
  writeFile(workspace / "click.yaml", YAML_CONTENT)
