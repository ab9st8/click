import os

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

compiler : clang    # What compiler click should use. `clang` by default.
outputDir: ./build  # Directory to which the executable should be outputted. `./build` by default.
auxOutput: true     # Whether Click should output auxiliary info: `Found <x> C files!` and `Runnning <command>`
"""


## Initialize the Click configuartion (by creating a new
## `click.yaml` file) or reinitialize if there's one already.
proc initialize*(reinitialize: bool) =
  if reinitialize:
    removeFile("click.yaml")

  writeFile("click.yaml", YAML_CONTENT)