import os, terminal

const YAML_CONTENT = """--- # CLICK CONFIGURATION # ---

##################################
# This file contains your Click  # 
# configuration.                 #
# To reinitialize, run           #
# --------                       #
#    $ click init                #
# --------                       #
# again.                         #
# If no `click.yaml` file is     #
# found, Click will run with its #
# default settings.              #
##################################

compiler   : clang       # What compiler Click should use. `clang` by default.
outputDir  : ./build     # Directory to which the executable should be outputted. `./build` by default.
auxOutput  : true        # Whether Click should output auxiliary info: `Found <x> C files!` and `Runnning <command>`
ignoreDirs : [".vscode"] # List of directories to ignore in compilation.
ignoreFiles: []          # List of paths to files to ignore in compilation.
"""


## Initialize the Click configuartion (by creating a new
## `click.yaml` file) or reinitialize if there's one already.
## Simpler than you would think.
proc initialize*(reinitialize: bool, workspace: string) =
  if reinitialize:
    removeFile(workspace / "click.yaml")

  stdout.styledWriteLine(fgCyan, if reinitialize: "Reinitialized `click.yaml`!" else: "Generated `click.yaml`!")
  writeFile(workspace / "click.yaml", YAML_CONTENT)
