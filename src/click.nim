import os, terminal
import compile, initialize

const HELP_MSG = "  click - run Click with the default parameters.\n  click init - create a YAML configuration file. Run again to reinitialize it.\n"

when isMainModule:
  let configExists = existsFile("click.yaml")
  if paramCount() == 0:
    compile(configExists)
  else:
    if paramStr(1) == "init":
      initialize(configExists)
    else:
      stdout.styledWrite(styleBright, styleUnderscore, "Click - USAGE\n", resetStyle, HELP_MSG)