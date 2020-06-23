import os, strutils, yaml/serialization, streams, terminal

const HELP_MSG = "  click - run Click with the default parameters.\n  click init - create a YAML configuration file. Run again to reinitialize it.\n"

type
  ClickConfig = object
    compiler, outputDir: string
    auxOutput: bool

## Compile all C files found in the workspace.
proc compile(fromFile: bool) =
  var config: ClickConfig = ClickConfig(
    compiler: "clang",
    outputDir: "./build/",
    auxOutput: true
  )
  if fromFile:
    var stream = newFileStream("./click.yaml")
    load(stream, config)
    stream.close()
  var inputFiles: seq[string] = @[]
  var command = "echo You shouldn't see this! Something went wrong! && exit 1"
  for file in walkDirRec("./"):
    if file[^2..^1] == ".c":
      inputFiles.add(file)

  if inputFiles.len() == 0:
    echo("Hmm... are you sure this is a C project? I couldn't find any C files and therefore wasn't able compile them. 😕")
    quit(1)
  
  
  var outputFile = config.outputDir / getCurrentDir().lastPathPart() # Not division; path joining. Pretty sick.
  
  command = config.compiler & " " & inputFiles.join(" ") & " -o " & outputFile

  if config.auxOutput:
    stdout.styledWrite(styleBright, "Found " & inputFiles.len().intToStr() & " C files!\nCompiling...\n", resetStyle, styleDim, "$ " & command & "\n")
  
  discard execShellCmd(command)
  quit(0)

## Initialize the Click configuartion (by creating a new
## `click.yaml` file) or reinitialize if there's one already.
proc initialize(reinitialize: bool) =
  if reinitialize:
    removeFile("click.yaml")

  writeFile("click.yaml", """--- # CLICK CONFIGURATION # ---

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

compiler : gcc    # What compiler click should use. `clang` by default.
outputDir: ./dist  # Directory to which the executable should be outputted. `./build` by default.
auxOutput: true     # Whether Click should output auxiliary info: `Found <x> C files!` and `Runnning <command>`
""")



when isMainModule:
  let configExists = existsFile("click.yaml")
  if paramCount() == 0:
    compile(configExists)
  else:
    if paramStr(1) == "init":
      initialize(configExists)
    else:
      stdout.styledWrite(styleBright, styleUnderscore, "Click - USAGE\n", resetStyle, HELP_MSG)