import os, compile, initialize, utils

const HELP_MSG = "  click      - run Click with the default parameters.\n  click init - create a TOML configuration file. Run again to reinitialize it.\n"

## Recursively walk down, looking for a
## click.toml file.
proc checkForWorkspace(dir: string): string =
  if splitPath(dir).head == "/":
    result = "./".expandFilename()
  elif fileExists(expandFilename(dir) / "click.toml"):
    result = dir
  else: # recur
    result = checkForWorkspace(expandFilename(dir).parentDir())


when isMainModule:
  let workspace = checkForWorkspace("./".expandFilename())
  echo workspace
  let configExists = fileExists(workspace / "click.toml")

  if paramCount() == 0:
    compile(configExists, workspace)
  else:
    if paramStr(1) == "init":
      initialize(configExists, workspace)
    else:
      writePrompt("USAGE:", true)
      echo(HELP_MSG)
