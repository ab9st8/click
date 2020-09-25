import yaml/serialization, streams, os, terminal, strutils

import initialize

## This type represents the Click configuration.
type
  ClickConfig = object
    name, compiler, outputDir: string
    auxOutput: bool
    ignoreDirs, ignoreFiles, flags: seq[string]


## Handle the file-finding in a single directory
## and pass it on to subdirectories recursively.
proc handleDirectory(dir: string, ignoreFiles: seq[string], ignoreDirs: seq[string]): seq[string] =
  result = @[]
  for kind, name in walkDir(dir):
    if kind == pcFile:
      if ignoreFiles.contains(name): continue
      elif name[^2..^1] == ".c": result.add(name)
    elif kind == pcDir:
      if ignoreDirs.contains(name): continue
      else: result.add(handleDirectory(name, ignoreFiles, ignoreDirs))


## Compile all C files found in the workspace.
proc compile*(fromFile: bool, workspace: string) =
  var config: ClickConfig = ClickConfig(
    name: "bin",
    compiler: "clang",
    outputDir: "build/",
    auxOutput: true,
    ignoreDirs: @[".vscode"],
    ignoreFiles: @[],
    flags: @["-Wall"]
  )
  # Load the YAML configuration. If there isn't one, create it.
  if fromFile:
    var stream = newFileStream(workspace / "click.yaml")
    load(stream, config)
    stream.close()
  else:
    stdout.styledWrite("In order to Click this project, a `click.yaml` file needs to be created. Proceed? y/n ", styleDim, "[y]\n", resetStyle)
    var result = ""
    while true:
      result = stdin.readLine()
      if result == "y" or result == "" or result == "yes":
        writeFile(workspace / "click.yaml", YAML_CONTENT)
        stdout.styledWrite(fgCyan, "Generated a `click.yaml` file, Clicking!\n", resetStyle)
        break
      elif result == "n" or result == "no":
        echo("Discarding.")
        return
      stdout.styledWrite(fgRed, "Please input either `y` or `n`.\n", resetStyle)
  
  var ignoreDirs: seq[string] = @[]
  var ignoreFiles: seq[string] = @[]
  
  # Not sure if both of these are really necessary but it doesn't work without this.

  # Normalize directory names
  for dir in config.ignoreDirs:
    if not existsDir(workspace / dir): continue
    ignoreDirs.add(workspace / dir)
  config.ignoreDirs = ignoreDirs
  # Normalize filenames
  for file in config.ignoreFiles:
    if not existsFile(workspace / file): continue
    ignoreFiles.add(workspace / file)
  config.ignoreFiles = ignoreFiles


  var inputFiles: seq[string] = @[]
  var command = "echo You shouldn't see this, something went wrong!\nStart an issue (https://github.com/aachh/click/issues) if you're seeing this. && exit 1"

  inputFiles = handleDirectory(workspace, config.ignoreFiles, config.ignoreDirs)

  if inputFiles.len() == 0:
    stdout.styledWrite(styleBright, "No C files found. Discarding.", resetStyle, "\n")
    quit(1)
  
  let outputFile = workspace / config.outputDir / config.name
  
  command = config.compiler & " " & config.flags.join(" ") & " " & inputFiles.join(" ") & " -o " & outputFile

  if config.auxOutput:
    stdout.styledWrite(styleBright, "Found " & intToStr(inputFiles.len()) & " C files!\nCompiling...\n", resetStyle, styleDim, "$ " & command, resetStyle, "\n\n")
  
  let exitCode = execShellCmd(command)
  quit(exitCode)
