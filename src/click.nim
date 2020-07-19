import os, terminal
import compile, initialize

const HELP_MSG = "  click      - run Click with the default parameters.\n  click init - create a YAML configuration file. Run again to reinitialize it.\n"

proc checkForWorkspace(dir: string): string =
  if splitPath(dir).head == "/":
    result = "./".expandFilename()
  elif existsFile(expandFilename(dir) / "click.yaml"):
    result = dir
  else: # recur
    result = checkForWorkspace(expandFilename(dir).parentDir())


when isMainModule:
  let configExists = existsFile("click.yaml")
  let workspace = checkForWorkspace("./")

  if paramCount() == 0:
    compile(configExists, workspace)
  else:
    if paramStr(1) == "init":
      initialize(configExists, workspace)
    else:
      stdout.styledWrite(styleBright, styleUnderscore, "USAGE\n", resetStyle, HELP_MSG)
